package com.crichere.domain.player.dto

import com.crichere.domain.player.enums.LeaguePlayerStatus
import jakarta.validation.constraints.*
import java.util.UUID

data class PlayerRegisterRequest(
    val leagueId: UUID,
    val userId: UUID,

    @field:Positive
    val basePrice: Int? = null,

    @field:Size(max = 50)
    val category: String? = null,

    @field:Size(max = 50)
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
    val category: String? = null,
    val auctionEligible: Boolean = false
)

data class LeaguePlayerListResponse(
    val players: List<LeaguePlayerResponse>,
    val totalElements: Long,
    val totalPages: Int,
    val pageNumber: Int,
    val pageSize: Int
)
