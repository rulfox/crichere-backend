package com.crichere.domain.fee.service

import com.crichere.common.exception.AlreadyExistsException
import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.fee.dto.*
import com.crichere.domain.fee.entity.FeeObligation
import com.crichere.domain.fee.entity.FeePayment
import com.crichere.domain.fee.enums.FeeStatus
import com.crichere.domain.fee.enums.FeeType
import com.crichere.domain.fee.enums.PaymentMode
import com.crichere.domain.fee.repository.FeeObligationRepository
import com.crichere.domain.fee.repository.FeePaymentRepository
import com.crichere.domain.player.repository.LeaguePlayerRepository
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Service
class FeeService(
    private val feeObligationRepository: FeeObligationRepository,
    private val feePaymentRepository: FeePaymentRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val notificationService: com.crichere.domain.notification.service.NotificationService
) {

    @Transactional
    fun createObligation(leagueId: UUID, request: FeeObligationCreateRequest): FeeObligationResponse {
        feeObligationRepository.findByLeagueIdAndUserIdAndFeeType(leagueId, request.userId, request.feeType)
            .ifPresent { throw AlreadyExistsException("Fee obligation already exists", "error.fee_obligation_already_exists") }

        val obligation = feeObligationRepository.save(FeeObligation(
            leagueId = leagueId,
            userId = request.userId,
            franchiseId = request.franchiseId,
            feeType = request.feeType,
            totalAmount = request.totalAmount,
            minimumToRegister = request.minimumToRegister
        ))
        return mapToResponse(obligation)
    }

    @Transactional
    fun recordPayment(leagueId: UUID, obligationId: UUID, request: FeePaymentRequest, recordedBy: UUID): FeeObligationResponse {
        val obligation = feeObligationRepository.findById(obligationId)
            .orElseThrow { ResourceNotFoundException("Fee obligation not found", "error.fee_obligation_not_found") }
        
        if (obligation.leagueId != leagueId) {
            throw ResourceNotFoundException("Fee obligation not found in this league", "error.fee_obligation_not_found")
        }

        if (request.amount <= 0 && request.paymentMode != PaymentMode.REFUND) {
             throw BusinessLogicException("Amount must be greater than zero", "error.invalid_amount")
        }

        obligation.paidAmount += request.amount
        obligation.recalculateStatus()
        
        // Check minimum to register rule
        if (obligation.feeType == FeeType.PLAYER_FEE && obligation.minimumToRegister != null) {
            if (obligation.paidAmount >= obligation.minimumToRegister!!) {
                val player = leaguePlayerRepository.findByLeagueIdAndUserId(leagueId, obligation.userId)
                if (player != null && !player.auctionEligible) {
                    player.auctionEligible = true
                    leaguePlayerRepository.save(player)
                }
            }
        }

        feeObligationRepository.save(obligation)
        feePaymentRepository.save(FeePayment(
            obligationId = obligationId,
            amount = request.amount,
            paymentMode = request.paymentMode,
            notes = request.notes,
            recordedBy = recordedBy
        ))

        // Notify user
        notificationService.notifyFeePaymentRecorded(obligation.userId, request.amount)

        return mapToResponse(obligation)
    }

    fun getObligations(leagueId: UUID, status: FeeStatus?, feeType: FeeType?, pageable: Pageable): Page<FeeObligationDetailResponse> {
        val page = when {
            status != null && feeType != null -> feeObligationRepository.findByLeagueIdAndStatusAndFeeType(leagueId, status, feeType, pageable)
            status != null -> feeObligationRepository.findByLeagueIdAndStatus(leagueId, status, pageable)
            feeType != null -> feeObligationRepository.findByLeagueIdAndFeeType(leagueId, feeType, pageable)
            else -> feeObligationRepository.findByLeagueId(leagueId, pageable)
        }
        return page.map { mapToDetailResponse(it) }
    }

    fun getObligationForUser(leagueId: UUID, userId: UUID): FeeObligationDetailResponse {
        val obligations = feeObligationRepository.findByLeagueIdAndUserId(leagueId, userId)
        if (obligations.isEmpty()) {
             throw ResourceNotFoundException("No fee obligation found for user", "error.fee_obligation_not_found")
        }
        // Assuming one obligation of a certain type or just return the first one for detail
        return mapToDetailResponse(obligations.first())
    }

    fun getFeeSummary(leagueId: UUID): FeeSummaryResponse {
        val all = feeObligationRepository.findByLeagueId(leagueId)
        val nonWaived = all.filter { it.status != FeeStatus.WAIVED }
        
        val totalExpected = nonWaived.sumOf { it.totalAmount }
        val totalCollected = all.sumOf { it.paidAmount }
        
        return FeeSummaryResponse(
            totalExpected = totalExpected,
            totalCollected = totalCollected,
            balanceDue = totalExpected - totalCollected,
            unpaidCount = all.count { it.status == FeeStatus.UNPAID }.toLong(),
            partiallyPaidCount = all.count { it.status == FeeStatus.PARTIALLY_PAID }.toLong(),
            paidCount = all.count { it.status == FeeStatus.PAID }.toLong(),
            waivedCount = all.count { it.status == FeeStatus.WAIVED }.toLong()
        )
    }

    @Transactional
    fun waiveObligation(leagueId: UUID, obligationId: UUID, reason: String, recordedBy: UUID): FeeObligationResponse {
        val obligation = feeObligationRepository.findById(obligationId)
            .orElseThrow { ResourceNotFoundException("Fee obligation not found", "error.fee_obligation_not_found") }
        
        if (obligation.leagueId != leagueId) {
            throw ResourceNotFoundException("Fee obligation not found in this league", "error.fee_obligation_not_found")
        }

        obligation.status = FeeStatus.WAIVED
        feeObligationRepository.save(obligation)
        
        feePaymentRepository.save(FeePayment(
            obligationId = obligationId,
            amount = 0,
            paymentMode = PaymentMode.WAIVER,
            notes = "WAIVED: $reason",
            recordedBy = recordedBy
        ))

        return mapToResponse(obligation)
    }

    private fun mapToResponse(o: FeeObligation) = FeeObligationResponse(
        o.id, o.leagueId, o.userId, o.franchiseId, o.feeType, o.totalAmount, o.minimumToRegister, o.paidAmount, o.status, o.createdAt, o.updatedAt
    )

    private fun mapToDetailResponse(o: FeeObligation): FeeObligationDetailResponse {
        val payments = feePaymentRepository.findByObligationIdOrderByCreatedAtDesc(o.id).map { p ->
            FeePaymentResponse(p.id, p.obligationId, p.amount, p.paymentMode, p.notes, p.recordedBy, p.createdAt)
        }
        return FeeObligationDetailResponse(mapToResponse(o), payments)
    }
}
