package com.crichere.domain.league.dto

import com.crichere.domain.league.enums.LeagueStatus
import java.util.UUID

data class LeagueCreateRequest(
    val name: String,
    val logoUrl: String? = null,
    val bannerUrl: String? = null
)

data class LeagueResponse(
    val id: UUID,
    val name: String,
    val logoUrl: String?,
    val bannerUrl: String?,
    val status: LeagueStatus,
    val createdBy: UUID
)

data class LeagueStatusUpdateRequest(
    val status: LeagueStatus
)
