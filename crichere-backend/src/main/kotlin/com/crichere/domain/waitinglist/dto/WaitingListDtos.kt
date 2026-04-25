package com.crichere.domain.waitinglist.dto

import com.crichere.domain.waitinglist.enums.WaitingListStatus
import com.crichere.domain.waitinglist.enums.WaitingListType
import java.time.Instant
import java.util.UUID

data class WaitingListEntryCreateRequest(
    val type: WaitingListType,
    val franchiseId: UUID? = null
)

data class WaitingListEntryResponse(
    val id: UUID,
    val leagueId: UUID,
    val userId: UUID,
    val franchiseId: UUID?,
    val type: WaitingListType,
    val position: Int,
    val status: WaitingListStatus,
    val createdAt: Instant,
    val promotedAt: Instant?
)

data class WaitingListResponse(
    val entries: List<WaitingListEntryResponse>,
    val totalElements: Long,
    val totalPages: Int,
    val pageNumber: Int,
    val pageSize: Int
)
