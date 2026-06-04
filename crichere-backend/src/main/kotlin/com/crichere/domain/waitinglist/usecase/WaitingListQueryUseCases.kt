package com.crichere.domain.waitinglist.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.waitinglist.dto.WaitingListEntryResponse
import com.crichere.domain.waitinglist.entity.WaitingListEntry
import com.crichere.domain.waitinglist.enums.WaitingListStatus
import com.crichere.domain.waitinglist.enums.WaitingListType
import com.crichere.domain.waitinglist.error.WaitingListDomainError
import com.crichere.domain.waitinglist.repository.WaitingListEntryRepository
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Component
import java.util.UUID

@Component
class GetWaitingListQuery(
    private val waitingListEntryRepository: WaitingListEntryRepository
) {
    fun execute(leagueId: UUID, type: WaitingListType?, status: WaitingListStatus?, pageable: Pageable): Result<Page<WaitingListEntryResponse>, WaitingListDomainError> {
        val page = when {
            type != null && status != null -> waitingListEntryRepository.findByLeagueIdAndStatusAndTypeOrderByPositionAsc(leagueId, status, type, pageable)
            type != null -> waitingListEntryRepository.findByLeagueIdAndTypeOrderByPositionAsc(leagueId, type, pageable)
            status != null -> waitingListEntryRepository.findByLeagueIdAndStatusOrderByPositionAsc(leagueId, status, pageable)
            else -> waitingListEntryRepository.findByLeagueIdOrderByPositionAsc(leagueId, pageable)
        }
        return Result.Success(page.map { mapToResponse(it) })
    }

    private fun mapToResponse(e: WaitingListEntry) = WaitingListEntryResponse(
        e.id, e.leagueId, e.userId, e.franchiseId, e.type, e.position, e.status, e.createdAt, e.promotedAt
    )
}

@Component
class GetMyPositionQuery(
    private val waitingListEntryRepository: WaitingListEntryRepository
) {
    fun execute(leagueId: UUID, userId: UUID): Result<WaitingListEntryResponse, WaitingListDomainError> {
        val entry = waitingListEntryRepository.findByLeagueIdAndUserIdAndStatus(leagueId, userId, WaitingListStatus.WAITING).orElse(null)
            ?: return Result.Failure(WaitingListDomainError.NotOnWaitingList())
        return Result.Success(mapToResponse(entry))
    }

    private fun mapToResponse(e: WaitingListEntry) = WaitingListEntryResponse(
        e.id, e.leagueId, e.userId, e.franchiseId, e.type, e.position, e.status, e.createdAt, e.promotedAt
    )
}
