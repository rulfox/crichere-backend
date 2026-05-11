package com.crichere.domain.franchise.dto

import com.crichere.domain.franchise.enums.FranchiseInviteStatus
import jakarta.validation.constraints.*
import java.util.UUID

data class FranchiseCreateRequest(
    val leagueId: UUID,

    @field:NotBlank
    @field:Size(max = 100)
    val name: String,

    @field:Size(max = 512)
    val logoUrl: String? = null,
    val ownerId: UUID,

    @field:Positive
    val totalPurse: Int
)

data class FranchiseResponse(
    val id: UUID,
    val leagueId: UUID,
    val name: String,
    val logoUrl: String?,
    val ownerId: UUID,
    val totalPurse: Int,
    val remainingPurse: Int
)

data class FranchiseInviteRequest(
    @field:NotBlank
    @field:Email
    val email: String
)

data class FranchiseInviteResponse(
    val id: UUID,
    val franchiseId: UUID,
    val email: String,
    val token: UUID,
    val status: FranchiseInviteStatus,
    val expiresAt: java.time.Instant,
    val inviteUrl: String? = null
)

data class InviteValidationResponse(
    val valid: Boolean,
    val token: UUID,
    val franchiseName: String,
    val leagueName: String,
    val invitedBy: String,
    val expiresAt: java.time.Instant
)

data class InviteAcceptRequest(
    val token: UUID
)
