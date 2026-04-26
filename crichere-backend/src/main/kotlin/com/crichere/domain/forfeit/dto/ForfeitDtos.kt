package com.crichere.domain.forfeit.dto

import com.crichere.domain.forfeit.enums.FeeRefundDecision
import com.crichere.domain.forfeit.enums.ForfeitStatus
import com.crichere.domain.forfeit.enums.ForfeitType
import jakarta.validation.constraints.*
import java.time.Instant
import java.util.UUID

data class ForfeitRequestCreateRequest(
    val type: ForfeitType,
    val franchiseId: UUID? = null,

    @field:NotBlank
    @field:Size(max = 500)
    val reason: String
)

data class ForfeitApproveRequest(
    val feeRefundDecision: FeeRefundDecision,

    @field:PositiveOrZero
    val feeRefundAmount: Int? = null,

    @field:Size(max = 500)
    val adminNotes: String? = null
)

data class ForfeitRequestResponse(
    val id: UUID,
    val leagueId: UUID,
    val userId: UUID,
    val franchiseId: UUID?,
    val type: ForfeitType,
    val reason: String,
    val status: ForfeitStatus,
    val feeRefundDecision: FeeRefundDecision?,
    val feeRefundAmount: Int?,
    val adminNotes: String?,
    val createdAt: Instant,
    val resolvedAt: Instant?
)

data class ForfeitRequestListResponse(
    val requests: List<ForfeitRequestResponse>,
    val totalElements: Long,
    val totalPages: Int,
    val pageNumber: Int,
    val pageSize: Int
)
