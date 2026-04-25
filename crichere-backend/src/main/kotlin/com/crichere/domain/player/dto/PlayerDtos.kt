package com.crichere.domain.player.dto

import com.crichere.domain.player.enums.LeaguePlayerStatus
import java.util.UUID

data class PlayerRegisterRequest(
    val leagueId: UUID,
    val userId: UUID,
    val basePrice: Int,
    val category: String? = null
)

data class LeaguePlayerResponse(
    val id: UUID,
    val leagueId: UUID,
    val userId: UUID,
    val basePrice: Int,
    val status: LeaguePlayerStatus,
    val category: String?
)
