package com.crichere.domain.league.event

import java.util.UUID

/**
 * Event published when a new League is successfully created.
 * Other domains (like Auth) can listen to this event to perform side-effects 
 * (e.g., creating the initial League Admin membership) without creating tight coupling.
 */
data class LeagueCreatedEvent(
    val leagueId: UUID,
    val createdByUserId: UUID
)
