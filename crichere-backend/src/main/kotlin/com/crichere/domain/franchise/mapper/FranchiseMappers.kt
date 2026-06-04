package com.crichere.domain.franchise.mapper

import com.crichere.domain.franchise.dto.FranchiseInviteResponse
import com.crichere.domain.franchise.dto.FranchiseResponse
import com.crichere.domain.franchise.entity.Franchise
import com.crichere.domain.franchise.entity.FranchiseInvite

fun Franchise.toResponse(): FranchiseResponse {
    return FranchiseResponse(
        id = this.id,
        leagueId = this.leagueId,
        name = this.name,
        logoUrl = this.logoUrl,
        ownerId = this.ownerId,
        totalPurse = this.totalPurse,
        remainingPurse = this.remainingPurse
    )
}

fun FranchiseInvite.toResponse(inviteUrl: String): FranchiseInviteResponse {
    return FranchiseInviteResponse(
        id = this.id,
        franchiseId = this.franchiseId,
        email = this.email,
        token = this.token,
        status = this.status,
        expiresAt = this.expiresAt,
        inviteUrl = inviteUrl
    )
}
