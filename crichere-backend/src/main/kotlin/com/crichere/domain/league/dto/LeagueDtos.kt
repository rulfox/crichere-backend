package com.crichere.domain.league.dto

import com.crichere.domain.league.enums.LeagueStatus
import java.util.UUID

data class LeagueCreateRequest(
    val name: String,
    val format: String? = null,
    val rulesUrl: String? = null,
    val mustSellAll: Boolean = false,
    val playerOrderMode: com.crichere.domain.league.enums.PlayerOrderMode = com.crichere.domain.league.enums.PlayerOrderMode.RANDOM,
    val waitingListMode: com.crichere.domain.league.enums.WaitingListMode = com.crichere.domain.league.enums.WaitingListMode.ADMIN_PICKS,
    val logoUrl: String? = null,
    val bannerUrl: String? = null
)

data class LeagueResponse(
    val id: UUID,
    val name: String,
    val format: String?,
    val rulesUrl: String?,
    val mustSellAll: Boolean,
    val playerOrderMode: com.crichere.domain.league.enums.PlayerOrderMode,
    val waitingListMode: com.crichere.domain.league.enums.WaitingListMode,
    val logoUrl: String?,
    val bannerUrl: String?,
    val status: LeagueStatus,
    val createdBy: UUID
)

data class LeagueStatusUpdateRequest(
    val status: LeagueStatus
)

data class PlayerImportRequest(
    val phone: String,
    val name: String,
    val category: String? = null,
    val tag: String? = null,
    val basePrice: Int? = null
)

data class BulkImportResponse(
    val added: Int,
    val skipped: Int,
    val errors: List<String>
)
