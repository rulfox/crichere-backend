package com.crichere.domain.forfeit.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.fee.dto.FeePaymentRequest
import com.crichere.domain.fee.enums.FeeStatus
import com.crichere.domain.fee.enums.PaymentMode
import com.crichere.domain.fee.repository.FeeObligationRepository
import com.crichere.domain.fee.usecase.RecordFeePaymentUseCase
import com.crichere.domain.forfeit.dto.*
import com.crichere.domain.forfeit.entity.ForfeitRequest
import com.crichere.domain.forfeit.enums.FeeRefundDecision
import com.crichere.domain.forfeit.enums.ForfeitStatus
import com.crichere.domain.forfeit.error.ForfeitDomainError
import com.crichere.domain.forfeit.repository.ForfeitRequestRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.player.repository.LeaguePlayerRepository
import com.crichere.domain.waitinglist.usecase.PromoteNextEntryUseCase
import com.crichere.domain.notification.usecase.CreateAndSendNotificationUseCase
import com.crichere.domain.notification.enums.NotificationType
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.util.UUID

@Component
class CreateForfeitRequestUseCase(
    private val forfeitRequestRepository: ForfeitRequestRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val franchiseRepository: FranchiseRepository
) {
    @Transactional
    fun execute(leagueId: UUID, userId: UUID, request: ForfeitRequestCreateRequest): Result<ForfeitRequestResponse, ForfeitDomainError> {
        if (forfeitRequestRepository.findByLeagueIdAndUserIdAndStatus(leagueId, userId, ForfeitStatus.PENDING).isPresent) {
            return Result.Failure(ForfeitDomainError.PendingRequestAlreadyExists())
        }

        // Participant validation
        val isPlayer = leaguePlayerRepository.findByLeagueIdAndUserId(leagueId, userId) != null
        val isFranchiseOwner = franchiseRepository.findByLeagueId(leagueId).any { it.ownerId == userId }
        
        if (!isPlayer && !isFranchiseOwner) {
            return Result.Failure(ForfeitDomainError.NotLeagueParticipant())
        }
        
        val forfeitRequest = forfeitRequestRepository.save(ForfeitRequest(
            leagueId = leagueId,
            userId = userId,
            franchiseId = request.franchiseId,
            type = request.type,
            reason = request.reason
        ))
        return Result.Success(mapToResponse(forfeitRequest))
    }

    private fun mapToResponse(f: ForfeitRequest) = ForfeitRequestResponse(
        f.id, f.leagueId, f.userId, f.franchiseId, f.type, f.reason, f.status, f.feeRefundDecision, f.feeRefundAmount, f.adminNotes, f.createdAt, f.resolvedAt
    )
}

@Component
class ApproveForfeitRequestUseCase(
    private val forfeitRequestRepository: ForfeitRequestRepository,
    private val recordFeePaymentUseCase: RecordFeePaymentUseCase,
    private val feeObligationRepository: FeeObligationRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val leagueRepository: LeagueRepository,
    private val promoteNextEntryUseCase: PromoteNextEntryUseCase,
    private val createAndSendNotificationUseCase: CreateAndSendNotificationUseCase
) {
    @Transactional
    fun execute(leagueId: UUID, requestId: UUID, request: ForfeitApproveRequest, adminId: UUID): Result<ForfeitRequestResponse, ForfeitDomainError> {
        val forfeitRequest = forfeitRequestRepository.findById(requestId).orElse(null)
            ?: return Result.Failure(ForfeitDomainError.RequestNotFound())
        
        if (forfeitRequest.status != ForfeitStatus.PENDING) {
            return Result.Failure(ForfeitDomainError.InvalidStatusTransition("Only PENDING requests can be approved"))
        }

        val obligation = feeObligationRepository.findByLeagueIdAndUserIdAndFeeType(
            leagueId, forfeitRequest.userId, if (forfeitRequest.type == com.crichere.domain.forfeit.enums.ForfeitType.PLAYER) com.crichere.domain.fee.enums.FeeType.PLAYER_FEE else com.crichere.domain.fee.enums.FeeType.FRANCHISE_FEE
        ).orElse(null)

        if (obligation != null) {
            if (request.feeRefundDecision == FeeRefundDecision.PARTIAL_REFUND) {
                if (request.feeRefundAmount == null || request.feeRefundAmount < 0 || request.feeRefundAmount > obligation.paidAmount) {
                    return Result.Failure(ForfeitDomainError.InvalidRefundAmount())
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
                val paymentResult = recordFeePaymentUseCase.execute(leagueId, obligation.id, FeePaymentRequest(
                    amount = -forfeitRequest.feeRefundAmount!!,
                    paymentMode = PaymentMode.REFUND,
                    notes = "Refund on forfeit approval"
                ), adminId)
                
                if (paymentResult is Result.Failure) {
                    return Result.Failure(ForfeitDomainError.BusinessLogicError(paymentResult.error.message, paymentResult.error.messageKey))
                }
            }
        } else {
            forfeitRequest.feeRefundAmount = 0
            if (request.feeRefundDecision != FeeRefundDecision.NO_REFUND) {
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
        createAndSendNotificationUseCase.execute(
            userId = forfeitRequest.userId,
            type = NotificationType.FORFEIT_APPROVED,
            title = "Forfeit Approved",
            body = "Your forfeit request for ${league.name} has been approved.",
            payload = emptyMap()
        )

        // Auto-promote if enabled
        if (league.waitingListMode == com.crichere.domain.league.enums.WaitingListMode.AUTO_PROMOTE) {
            promoteNextEntryUseCase.execute(leagueId)
        }

        return Result.Success(mapToResponse(forfeitRequest))
    }

    private fun mapToResponse(f: ForfeitRequest) = ForfeitRequestResponse(
        f.id, f.leagueId, f.userId, f.franchiseId, f.type, f.reason, f.status, f.feeRefundDecision, f.feeRefundAmount, f.adminNotes, f.createdAt, f.resolvedAt
    )
}

@Component
class RejectForfeitRequestUseCase(
    private val forfeitRequestRepository: ForfeitRequestRepository
) {
    @Transactional
    fun execute(requestId: UUID, notes: String): Result<ForfeitRequestResponse, ForfeitDomainError> {
        val forfeitRequest = forfeitRequestRepository.findById(requestId).orElse(null)
            ?: return Result.Failure(ForfeitDomainError.RequestNotFound())
        
        if (forfeitRequest.status != ForfeitStatus.PENDING) {
            return Result.Failure(ForfeitDomainError.InvalidStatusTransition("Only PENDING requests can be rejected"))
        }

        forfeitRequest.status = ForfeitStatus.REJECTED
        forfeitRequest.resolvedAt = Instant.now()
        forfeitRequest.adminNotes = notes
        return Result.Success(mapToResponse(forfeitRequestRepository.save(forfeitRequest)))
    }

    private fun mapToResponse(f: ForfeitRequest) = ForfeitRequestResponse(
        f.id, f.leagueId, f.userId, f.franchiseId, f.type, f.reason, f.status, f.feeRefundDecision, f.feeRefundAmount, f.adminNotes, f.createdAt, f.resolvedAt
    )
}

@Component
class CancelForfeitRequestUseCase(
    private val forfeitRequestRepository: ForfeitRequestRepository
) {
    @Transactional
    fun execute(requestId: UUID, userId: UUID): Result<ForfeitRequestResponse, ForfeitDomainError> {
        val forfeitRequest = forfeitRequestRepository.findById(requestId).orElse(null)
            ?: return Result.Failure(ForfeitDomainError.RequestNotFound())
        
        if (forfeitRequest.userId != userId) {
            return Result.Failure(ForfeitDomainError.Unauthorized("Cannot cancel someone else's request"))
        }

        if (forfeitRequest.status != ForfeitStatus.PENDING) {
            return Result.Failure(ForfeitDomainError.InvalidStatusTransition("Cannot cancel resolved request", "error.cannot_cancel_resolved_request"))
        }

        forfeitRequest.status = ForfeitStatus.CANCELLED
        forfeitRequest.resolvedAt = Instant.now()
        return Result.Success(mapToResponse(forfeitRequestRepository.save(forfeitRequest)))
    }

    private fun mapToResponse(f: ForfeitRequest) = ForfeitRequestResponse(
        f.id, f.leagueId, f.userId, f.franchiseId, f.type, f.reason, f.status, f.feeRefundDecision, f.feeRefundAmount, f.adminNotes, f.createdAt, f.resolvedAt
    )
}
