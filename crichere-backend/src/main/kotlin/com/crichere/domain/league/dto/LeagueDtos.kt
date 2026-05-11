package com.crichere.domain.league.dto

import com.crichere.domain.league.enums.LeagueStatus
import jakarta.validation.constraints.*
import java.util.UUID

data class LeagueCreateRequest(
    @field:NotBlank
    @field:Size(max = 100)
    val name: String,

    @field:Size(max = 50)
    val format: String? = null,

    @field:Size(max = 512)
    val rulesUrl: String? = null,
    val mustSellAll: Boolean = false,
    val playerOrderMode: com.crichere.domain.league.enums.PlayerOrderMode = com.crichere.domain.league.enums.PlayerOrderMode.RANDOM,
    val waitingListMode: com.crichere.domain.league.enums.WaitingListMode = com.crichere.domain.league.enums.WaitingListMode.ADMIN_PICKS,
    val auctionDate: java.time.Instant? = null,

    @field:Size(max = 512)
    val logoUrl: String? = null,

    @field:Size(max = 512)
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
    val auctionDate: java.time.Instant?,
    val createdBy: UUID
)

data class LeagueStatusUpdateRequest(
    val status: LeagueStatus
)

data class PlayerImportRequest(
    @field:NotBlank
    @field:Pattern(regexp = "^[6-9]\\d{9}$", message = "must be a valid 10-digit Indian mobile number")
    val phone: String,

    @field:NotBlank
    @field:Size(max = 100)
    val name: String,

    @field:Size(max = 50)
    val category: String? = null,

    @field:Size(max = 50)
    val tag: String? = null,

    @field:Positive
    val basePrice: Int? = null
)

data class CategoryPriceRequest(
    val category: String,
    val price: Int
)

data class TagPriceRequest(
    val tag: String,
    val price: Int
)

data class CategoryPriceResponse(
    val id: UUID,
    val category: String,
    val price: Int
)

data class TagPriceResponse(
    val id: UUID,
    val tag: String,
    val price: Int
)

data class BulkImportResponse(
    val added: Int,
    val skipped: Int,
    val errors: List<String>
)
