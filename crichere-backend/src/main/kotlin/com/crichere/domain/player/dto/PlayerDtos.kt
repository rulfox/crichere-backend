package com.crichere.domain.player.dto

import com.crichere.domain.player.enums.LeaguePlayerStatus
import java.util.UUID

data class PlayerRegisterRequest(
    val leagueId: UUID,
    val userId: UUID,
    val basePrice: Int? = null,
    val category: String? = null,
    val tag: String? = null
)

data class LeaguePlayerResponse(
    val id: UUID,
    val leagueId: UUID,
    val userId: UUID,
    val basePrice: Int,
    val basePriceOverride: Int? = null,
    val tag: String? = null,
    val status: LeaguePlayerStatus,
    val category: String? = null
)
