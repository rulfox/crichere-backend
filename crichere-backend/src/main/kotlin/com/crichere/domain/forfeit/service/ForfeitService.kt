package com.crichere.domain.forfeit.service

import com.crichere.common.exception.AlreadyExistsException
import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.fee.dto.FeePaymentRequest
import com.crichere.domain.fee.enums.FeeStatus
import com.crichere.domain.fee.enums.PaymentMode
import com.crichere.domain.fee.repository.FeeObligationRepository
import com.crichere.domain.fee.service.FeeService
import com.crichere.domain.forfeit.dto.*
import com.crichere.domain.forfeit.entity.ForfeitRequest
import com.crichere.domain.forfeit.enums.FeeRefundDecision
import com.crichere.domain.forfeit.enums.ForfeitStatus
import com.crichere.domain.forfeit.repository.ForfeitRequestRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.league.service.LeagueService
import com.crichere.domain.player.repository.LeaguePlayerRepository
import com.crichere.domain.waitinglist.service.WaitingListService
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.util.*

@Service
class ForfeitService(
    private val forfeitRequestRepository: ForfeitRequestRepository,
    private val feeService: FeeService,
    private val feeObligationRepository: FeeObligationRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val franchiseRepository: FranchiseRepository,
    private val leagueRepository: LeagueRepository,
    private val waitingListService: WaitingListService,
    private val notificationService: com.crichere.domain.notification.service.NotificationService
) {

    @Transactional
    fun createRequest(leagueId: UUID, userId: UUID, request: ForfeitRequestCreateRequest): ForfeitRequestResponse {
        forfeitRequestRepository.findByLeagueIdAndUserIdAndStatus(leagueId, userId, ForfeitStatus.PENDING)
            .ifPresent { throw AlreadyExistsException("A pending forfeit request already exists", "error.pending_forfeit_exists") }

        // Participant validation
        val isPlayer = leaguePlayerRepository.findByLeagueIdAndUserId(leagueId, userId) != null
        val isFranchiseOwner = franchiseRepository.findByLeagueId(leagueId).any { it.ownerId == userId }
        
        if (!isPlayer && !isFranchiseOwner) {
            throw BusinessLogicException("User is not a participant in this league", "error.not_league_participant")
        }
        
        val forfeitRequest = forfeitRequestRepository.save(ForfeitRequest(
            leagueId = leagueId,
            userId = userId,
            franchiseId = request.franchiseId,
            type = request.type,
            reason = request.reason
        ))
        return mapToResponse(forfeitRequest)
    }

    fun getRequests(leagueId: UUID, status: ForfeitStatus?, type: com.crichere.domain.forfeit.enums.ForfeitType?, pageable: Pageable): Page<ForfeitRequestResponse> {
        val page = when {
            status != null && type != null -> forfeitRequestRepository.findByLeagueIdAndStatusAndType(leagueId, status, type, pageable)
            status != null -> forfeitRequestRepository.findByLeagueIdAndStatus(leagueId, status, pageable)
            type != null -> forfeitRequestRepository.findByLeagueIdAndType(leagueId, type, pageable)
            else -> forfeitRequestRepository.findByLeagueId(leagueId, pageable)
        }
        return page.map { mapToResponse(it) }
    }

    @Transactional
    fun approveRequest(leagueId: UUID, requestId: UUID, request: ForfeitApproveRequest, adminId: UUID): ForfeitRequestResponse {
        val forfeitRequest = forfeitRequestRepository.findById(requestId)
            .orElseThrow { ResourceNotFoundException("Forfeit request not found", "error.forfeit_request_not_found") }
        
        if (forfeitRequest.status != ForfeitStatus.PENDING) {
            throw BusinessLogicException("Only PENDING requests can be approved", "error.invalid_forfeit_status")
        }

        val obligation = feeObligationRepository.findByLeagueIdAndUserIdAndFeeType(
            leagueId, forfeitRequest.userId, if (forfeitRequest.type == com.crichere.domain.forfeit.enums.ForfeitType.PLAYER) com.crichere.domain.fee.enums.FeeType.PLAYER_FEE else com.crichere.domain.fee.enums.FeeType.FRANCHISE_FEE
        ).orElse(null)

        if (obligation != null) {
            if (request.feeRefundDecision == FeeRefundDecision.PARTIAL_REFUND) {
                if (request.feeRefundAmount == null || request.feeRefundAmount < 0 || request.feeRefundAmount > obligation.paidAmount) {
                    throw BusinessLogicException("Invalid refund amount", "error.invalid_refund_amount")
                }
            }
            
            forfeitRequest.feeRefundAmount = when(request.feeRefundDecision) {
                FeeRefundDecision.FULL_REFUND -> obligation.paidAmount
                FeeRefundDecision.PARTIAL_REFUND -> request.feeRefundAmount
                FeeRefundDecision.NO_REFUND -> 0
            }

            // Waive obligation
            obligation.status = FeeStatus.WAIVED
            feeObligationRepository.save(obligation)

            // Refund payment
            if (forfeitRequest.feeRefundAmount!! > 0) {
                feeService.recordPayment(leagueId, obligation.id, FeePaymentRequest(
                    amount = -forfeitRequest.feeRefundAmount!!,
                    paymentMode = PaymentMode.REFUND,
                    notes = "Refund on forfeit approval"
                ), adminId)
            }
        } else {
            forfeitRequest.feeRefundAmount = 0
            if (request.feeRefundDecision != FeeRefundDecision.NO_REFUND) {
                 // Option to warn or ignore. Audit says it fails, so we'll just force NO_REFUND.
                 forfeitRequest.feeRefundDecision = FeeRefundDecision.NO_REFUND
            }
        }

        forfeitRequest.status = ForfeitStatus.APPROVED
        forfeitRequest.resolvedAt = Instant.now()
        forfeitRequest.feeRefundDecision = request.feeRefundDecision
        forfeitRequest.adminNotes = request.adminNotes

        // De-eligible player
        val player = leaguePlayerRepository.findByLeagueIdAndUserId(leagueId, forfeitRequest.userId)
        if (player != null) {
            player.auctionEligible = false
            leaguePlayerRepository.save(player)
        }

        forfeitRequestRepository.save(forfeitRequest)

        val league = leagueRepository.findById(leagueId).get()

        // Notify user
        notificationService.notifyForfeitApproved(forfeitRequest.userId, league.name)

        // Auto-promote if enabled
        if (league.waitingListMode == com.crichere.domain.league.enums.WaitingListMode.AUTO_PROMOTE) {
            waitingListService.promoteNext(leagueId)
        }

        return mapToResponse(forfeitRequest)
    }

    @Transactional
    fun rejectRequest(requestId: UUID, notes: String): ForfeitRequestResponse {
        val forfeitRequest = forfeitRequestRepository.findById(requestId)
            .orElseThrow { ResourceNotFoundException("Forfeit request not found", "error.forfeit_request_not_found") }
        
        if (forfeitRequest.status != ForfeitStatus.PENDING) {
            throw BusinessLogicException("Only PENDING requests can be rejected", "error.invalid_forfeit_status")
        }

        forfeitRequest.status = ForfeitStatus.REJECTED
        forfeitRequest.resolvedAt = Instant.now()
        forfeitRequest.adminNotes = notes
        return mapToResponse(forfeitRequestRepository.save(forfeitRequest))
    }

    @Transactional
    fun cancelRequest(requestId: UUID, userId: UUID): ForfeitRequestResponse {
        val forfeitRequest = forfeitRequestRepository.findById(requestId)
            .orElseThrow { ResourceNotFoundException("Forfeit request not found", "error.forfeit_request_not_found") }
        
        if (forfeitRequest.userId != userId) {
            throw com.crichere.common.exception.UnauthorizedException("Cannot cancel someone else's request")
        }

        if (forfeitRequest.status != ForfeitStatus.PENDING) {
            throw BusinessLogicException("Cannot cancel resolved request", "error.cannot_cancel_resolved_request")
        }

        forfeitRequest.status = ForfeitStatus.CANCELLED
        forfeitRequest.resolvedAt = Instant.now()
        return mapToResponse(forfeitRequestRepository.save(forfeitRequest))
    }

    private fun mapToResponse(f: ForfeitRequest) = ForfeitRequestResponse(
        f.id, f.leagueId, f.userId, f.franchiseId, f.type, f.reason, f.status, f.feeRefundDecision, f.feeRefundAmount, f.adminNotes, f.createdAt, f.resolvedAt
    )
}
