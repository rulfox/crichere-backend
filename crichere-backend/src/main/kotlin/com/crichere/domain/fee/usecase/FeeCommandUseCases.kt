package com.crichere.domain.fee.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.fee.dto.FeeObligationCreateRequest
import com.crichere.domain.fee.dto.FeeObligationResponse
import com.crichere.domain.fee.dto.FeePaymentRequest
import com.crichere.domain.fee.entity.FeeObligation
import com.crichere.domain.fee.entity.FeePayment
import com.crichere.domain.fee.enums.FeeStatus
import com.crichere.domain.fee.enums.FeeType
import com.crichere.domain.fee.enums.PaymentMode
import com.crichere.domain.fee.error.FeeDomainError
import com.crichere.domain.fee.repository.FeeObligationRepository
import com.crichere.domain.fee.repository.FeePaymentRepository
import com.crichere.domain.player.repository.LeaguePlayerRepository
import com.crichere.domain.notification.usecase.CreateAndSendNotificationUseCase
import com.crichere.domain.notification.enums.NotificationType
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

@Component
class CreateFeeObligationUseCase(
    private val feeObligationRepository: FeeObligationRepository
) {
    @Transactional
    fun execute(leagueId: UUID, request: FeeObligationCreateRequest): Result<FeeObligationResponse, FeeDomainError> {
        if (feeObligationRepository.findByLeagueIdAndUserIdAndFeeType(leagueId, request.userId, request.feeType).isPresent) {
            return Result.Failure(FeeDomainError.ObligationAlreadyExists())
        }

        val obligation = feeObligationRepository.save(FeeObligation(
            leagueId = leagueId,
            userId = request.userId,
            franchiseId = request.franchiseId,
            feeType = request.feeType,
            totalAmount = request.totalAmount,
            minimumToRegister = request.minimumToRegister
        ))
        return Result.Success(mapToResponse(obligation))
    }

    private fun mapToResponse(o: FeeObligation) = FeeObligationResponse(
        o.id, o.leagueId, o.userId, o.franchiseId, o.feeType, o.totalAmount, o.minimumToRegister, o.paidAmount, o.status, o.createdAt, o.updatedAt
    )
}

@Component
class RecordFeePaymentUseCase(
    private val feeObligationRepository: FeeObligationRepository,
    private val feePaymentRepository: FeePaymentRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val createAndSendNotificationUseCase: CreateAndSendNotificationUseCase
) {
    @Transactional
    fun execute(leagueId: UUID, obligationId: UUID, request: FeePaymentRequest, recordedBy: UUID): Result<FeeObligationResponse, FeeDomainError> {
        val obligation = feeObligationRepository.findById(obligationId).orElse(null)
            ?: return Result.Failure(FeeDomainError.ObligationNotFound())
        
        if (obligation.leagueId != leagueId) {
            return Result.Failure(FeeDomainError.ObligationNotFound(message = "Fee obligation not found in this league", messageKey = "error.fee_obligation_not_found"))
        }

        if (request.amount <= 0 && request.paymentMode != PaymentMode.REFUND) {
            return Result.Failure(FeeDomainError.InvalidAmount())
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
        createAndSendNotificationUseCase.execute(
            userId = obligation.userId,
            type = NotificationType.FEE_PAYMENT_RECORDED,
            title = "Payment Recorded",
            body = "A payment of ${request.amount} has been recorded.",
            payload = emptyMap()
        )

        return Result.Success(mapToResponse(obligation))
    }

    private fun mapToResponse(o: FeeObligation) = FeeObligationResponse(
        o.id, o.leagueId, o.userId, o.franchiseId, o.feeType, o.totalAmount, o.minimumToRegister, o.paidAmount, o.status, o.createdAt, o.updatedAt
    )
}

@Component
class WaiveFeeObligationUseCase(
    private val feeObligationRepository: FeeObligationRepository,
    private val feePaymentRepository: FeePaymentRepository
) {
    @Transactional
    fun execute(leagueId: UUID, obligationId: UUID, reason: String, recordedBy: UUID): Result<FeeObligationResponse, FeeDomainError> {
        val obligation = feeObligationRepository.findById(obligationId).orElse(null)
            ?: return Result.Failure(FeeDomainError.ObligationNotFound())
        
        if (obligation.leagueId != leagueId) {
            return Result.Failure(FeeDomainError.ObligationNotFound(message = "Fee obligation not found in this league", messageKey = "error.fee_obligation_not_found"))
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

        return Result.Success(mapToResponse(obligation))
    }

    private fun mapToResponse(o: FeeObligation) = FeeObligationResponse(
        o.id, o.leagueId, o.userId, o.franchiseId, o.feeType, o.totalAmount, o.minimumToRegister, o.paidAmount, o.status, o.createdAt, o.updatedAt
    )
}
