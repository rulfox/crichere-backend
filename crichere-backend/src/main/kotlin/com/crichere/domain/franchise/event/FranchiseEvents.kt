package com.crichere.domain.franchise.event

import java.util.UUID

/**
 * Published when a user accepts a franchise invite.
 * Listened by the Auth module to create UserFranchiseMembership.
 */
data class FranchiseInviteAcceptedEvent(
    val franchiseId: UUID,
    val userId: UUID
)
