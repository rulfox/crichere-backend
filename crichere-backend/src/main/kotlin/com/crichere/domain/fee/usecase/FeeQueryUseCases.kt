package com.crichere.domain.fee.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.fee.dto.FeeObligationDetailResponse
import com.crichere.domain.fee.dto.FeeObligationResponse
import com.crichere.domain.fee.dto.FeePaymentResponse
import com.crichere.domain.fee.dto.FeeSummaryResponse
import com.crichere.domain.fee.entity.FeeObligation
import com.crichere.domain.fee.enums.FeeStatus
import com.crichere.domain.fee.enums.FeeType
import com.crichere.domain.fee.error.FeeDomainError
import com.crichere.domain.fee.repository.FeeObligationRepository
import com.crichere.domain.fee.repository.FeePaymentRepository
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Component
import java.util.UUID

@Component
class GetFeeObligationsQuery(
    private val feeObligationRepository: FeeObligationRepository,
    private val feePaymentRepository: FeePaymentRepository
) {
    fun execute(leagueId: UUID, status: FeeStatus?, feeType: FeeType?, pageable: Pageable): Result<Page<FeeObligationDetailResponse>, FeeDomainError> {
        val page = when {
            status != null && feeType != null -> feeObligationRepository.findByLeagueIdAndStatusAndFeeType(leagueId, status, feeType, pageable)
            status != null -> feeObligationRepository.findByLeagueIdAndStatus(leagueId, status, pageable)
            feeType != null -> feeObligationRepository.findByLeagueIdAndFeeType(leagueId, feeType, pageable)
            else -> feeObligationRepository.findByLeagueId(leagueId, pageable)
        }
        return Result.Success(page.map { mapToDetailResponse(it) })
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

@Component
class GetFeeObligationForUserQuery(
    private val feeObligationRepository: FeeObligationRepository,
    private val feePaymentRepository: FeePaymentRepository
) {
    fun execute(leagueId: UUID, userId: UUID): Result<FeeObligationDetailResponse, FeeDomainError> {
        val obligations = feeObligationRepository.findByLeagueIdAndUserId(leagueId, userId)
        if (obligations.isEmpty()) {
             return Result.Failure(FeeDomainError.ObligationNotFound())
        }
        return Result.Success(mapToDetailResponse(obligations.first()))
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

@Component
class GetFeeSummaryQuery(
    private val feeObligationRepository: FeeObligationRepository
) {
    fun execute(leagueId: UUID): Result<FeeSummaryResponse, FeeDomainError> {
        val all = feeObligationRepository.findByLeagueId(leagueId)
        val nonWaived = all.filter { it.status != FeeStatus.WAIVED }
        
        val totalExpected = nonWaived.sumOf { it.totalAmount }
        val totalCollected = all.sumOf { it.paidAmount }
        
        return Result.Success(FeeSummaryResponse(
            totalExpected = totalExpected,
            totalCollected = totalCollected,
            balanceDue = totalExpected - totalCollected,
            unpaidCount = all.count { it.status == FeeStatus.UNPAID }.toLong(),
            partiallyPaidCount = all.count { it.status == FeeStatus.PARTIALLY_PAID }.toLong(),
            paidCount = all.count { it.status == FeeStatus.PAID }.toLong(),
            waivedCount = all.count { it.status == FeeStatus.WAIVED }.toLong()
        ))
    }
}
