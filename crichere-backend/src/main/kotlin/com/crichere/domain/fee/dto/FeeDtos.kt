package com.crichere.domain.fee.dto

import com.crichere.domain.fee.enums.FeeStatus
import com.crichere.domain.fee.enums.FeeType
import com.crichere.domain.fee.enums.PaymentMode
import java.time.Instant
import java.util.UUID

data class FeeObligationCreateRequest(
    val userId: UUID,
    val feeType: FeeType,
    val franchiseId: UUID? = null,
    val totalAmount: Int,
    val minimumToRegister: Int? = null
)

data class FeePaymentRequest(
    val amount: Int,
    val paymentMode: PaymentMode,
    val notes: String? = null
)

data class FeeObligationResponse(
    val id: UUID,
    val leagueId: UUID,
    val userId: UUID,
    val franchiseId: UUID?,
    val feeType: FeeType,
    val totalAmount: Int,
    val minimumToRegister: Int?,
    val paidAmount: Int,
    val status: FeeStatus,
    val createdAt: Instant,
    val updatedAt: Instant
)

data class FeePaymentResponse(
    val id: UUID,
    val obligationId: UUID,
    val amount: Int,
    val paymentMode: PaymentMode,
    val notes: String?,
    val recordedBy: UUID,
    val createdAt: Instant
)

data class FeeObligationDetailResponse(
    val obligation: FeeObligationResponse,
    val payments: List<FeePaymentResponse>
)

data class FeeSummaryResponse(
    val totalExpected: Int,
    val totalCollected: Int,
    val balanceDue: Int,
    val unpaidCount: Long,
    val partiallyPaidCount: Long,
    val paidCount: Long,
    val waivedCount: Long
)

data class FeeObligationListResponse(
    val obligations: List<FeeObligationDetailResponse>,
    val totalElements: Long,
    val totalPages: Int,
    val pageNumber: Int,
    val pageSize: Int
)
