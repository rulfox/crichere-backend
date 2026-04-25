package com.crichere.domain.franchise.dto

import com.crichere.domain.franchise.enums.FranchiseInviteStatus
import java.util.UUID

data class FranchiseCreateRequest(
    val leagueId: UUID,
    val name: String,
    val logoUrl: String? = null,
    val ownerId: UUID,
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
    val email: String
)

data class FranchiseInviteResponse(
    val id: UUID,
    val franchiseId: UUID,
    val email: String,
    val token: UUID,
    val status: FranchiseInviteStatus,
    val expiresAt: java.time.Instant
)
