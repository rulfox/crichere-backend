package com.crichere.domain.waitinglist.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.franchise.entity.Franchise
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.repository.LeaguePlayerRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.waitinglist.dto.WaitingListEntryCreateRequest
import com.crichere.domain.waitinglist.dto.WaitingListEntryResponse
import com.crichere.domain.waitinglist.entity.WaitingListEntry
import com.crichere.domain.waitinglist.enums.WaitingListStatus
import com.crichere.domain.waitinglist.enums.WaitingListType
import com.crichere.domain.waitinglist.error.WaitingListDomainError
import com.crichere.domain.waitinglist.repository.WaitingListEntryRepository
import com.crichere.domain.notification.usecase.CreateAndSendNotificationUseCase
import com.crichere.domain.notification.enums.NotificationType
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.util.UUID

@Component
class AddToWaitingListUseCase(
    private val waitingListEntryRepository: WaitingListEntryRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val franchiseRepository: FranchiseRepository
) {
    @Transactional
    fun execute(leagueId: UUID, userId: UUID, request: WaitingListEntryCreateRequest): Result<WaitingListEntryResponse, WaitingListDomainError> {
        if (waitingListEntryRepository.findByLeagueIdAndUserIdAndStatus(leagueId, userId, WaitingListStatus.WAITING).isPresent) {
            return Result.Failure(WaitingListDomainError.AlreadyOnWaitingList())
        }

        // Participant check
        if (leaguePlayerRepository.findByLeagueIdAndUserId(leagueId, userId) != null) {
            return Result.Failure(WaitingListDomainError.AlreadyLeagueParticipant("Already a player in this league"))
        }
        if (franchiseRepository.findByLeagueId(leagueId).any { it.ownerId == userId }) {
            return Result.Failure(WaitingListDomainError.AlreadyLeagueParticipant("Already a franchise owner in this league"))
        }

        val position = waitingListEntryRepository.findMaxPositionByLeagueId(leagueId) + 1

        try {
            val entry = waitingListEntryRepository.save(WaitingListEntry(
                leagueId = leagueId,
                userId = userId,
                franchiseId = request.franchiseId,
                type = request.type,
                position = position
            ))
            return Result.Success(mapToResponse(entry))
        } catch (e: DataIntegrityViolationException) {
            return Result.Failure(WaitingListDomainError.PositionConflict())
        }
    }

    private fun mapToResponse(e: WaitingListEntry) = WaitingListEntryResponse(
        e.id, e.leagueId, e.userId, e.franchiseId, e.type, e.position, e.status, e.createdAt, e.promotedAt
    )
}

@Component
class WithdrawFromWaitingListUseCase(
    private val waitingListEntryRepository: WaitingListEntryRepository
) {
    @Transactional
    fun execute(leagueId: UUID, entryId: UUID, userId: UUID): Result<Unit, WaitingListDomainError> {
        val entry = waitingListEntryRepository.findById(entryId).orElse(null)
            ?: return Result.Failure(WaitingListDomainError.EntryNotFound())
        
        if (entry.userId != userId) {
             return Result.Failure(WaitingListDomainError.Unauthorized("Cannot withdraw someone else's entry"))
        }

        if (entry.status != WaitingListStatus.WAITING) {
            return Result.Failure(WaitingListDomainError.InvalidStatusTransition("Cannot withdraw resolved entry", "error.cannot_withdraw_resolved_entry"))
        }

        entry.status = WaitingListStatus.WITHDRAWN
        waitingListEntryRepository.save(entry)
        
        recalculatePositions(leagueId)
        return Result.Success(Unit)
    }

    private fun recalculatePositions(leagueId: UUID) {
        val remaining = waitingListEntryRepository.findByLeagueIdAndStatusOrderByPositionAscWithLock(leagueId, WaitingListStatus.WAITING)
        remaining.forEachIndexed { index, entry ->
            entry.position = index + 1
            waitingListEntryRepository.save(entry)
        }
    }
}

@Component
class PromoteEntryUseCase(
    private val waitingListEntryRepository: WaitingListEntryRepository,
    private val leagueRepository: LeagueRepository,
    private val userRepository: UserRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val franchiseRepository: FranchiseRepository,
    private val createAndSendNotificationUseCase: CreateAndSendNotificationUseCase
) {
    @Transactional
    fun execute(leagueId: UUID, entryId: UUID, manual: Boolean = true): Result<WaitingListEntryResponse, WaitingListDomainError> {
        val entry = waitingListEntryRepository.findById(entryId).orElse(null)
            ?: return Result.Failure(WaitingListDomainError.EntryNotFound())
        
        if (entry.status != WaitingListStatus.WAITING) {
            return Result.Failure(WaitingListDomainError.InvalidStatusTransition("Entry is not in WAITING status"))
        }

        val league = leagueRepository.findById(leagueId).get()
        if (manual && league.waitingListMode == com.crichere.domain.league.enums.WaitingListMode.AUTO_PROMOTE) {
            return Result.Failure(WaitingListDomainError.AutoPromoteModeActive())
        }

        entry.status = WaitingListStatus.PROMOTED
        entry.promotedAt = Instant.now()
        waitingListEntryRepository.save(entry)

        // Create participant
        if (entry.type == WaitingListType.PLAYER) {
            leaguePlayerRepository.save(LeaguePlayer(
                leagueId = leagueId,
                userId = entry.userId,
                auctionEligible = true
            ))
        } else {
            val user = userRepository.findById(entry.userId).get()
            val existingFranchises = franchiseRepository.findByLeagueId(leagueId)
            val defaultPurse = existingFranchises.firstOrNull()?.totalPurse ?: 0
            
            franchiseRepository.save(Franchise(
                leagueId = leagueId,
                ownerId = entry.userId,
                name = "${user.name}'s Franchise",
                totalPurse = defaultPurse,
                remainingPurse = defaultPurse
            ))
        }

        // Notification logic
        createAndSendNotificationUseCase.execute(
            userId = entry.userId,
            type = NotificationType.WAITING_LIST_PROMOTED,
            title = "Promoted from Waiting List",
            body = "You have been promoted from the waiting list for ${league.name}.",
            payload = emptyMap()
        )
        
        recalculatePositions(leagueId)
        return Result.Success(mapToResponse(entry))
    }

    private fun recalculatePositions(leagueId: UUID) {
        val remaining = waitingListEntryRepository.findByLeagueIdAndStatusOrderByPositionAscWithLock(leagueId, WaitingListStatus.WAITING)
        remaining.forEachIndexed { index, entry ->
            entry.position = index + 1
            waitingListEntryRepository.save(entry)
        }
    }

    private fun mapToResponse(e: WaitingListEntry) = WaitingListEntryResponse(
        e.id, e.leagueId, e.userId, e.franchiseId, e.type, e.position, e.status, e.createdAt, e.promotedAt
    )
}

@Component
class PromoteNextEntryUseCase(
    private val waitingListEntryRepository: WaitingListEntryRepository,
    private val promoteEntryUseCase: PromoteEntryUseCase
) {
    @Transactional
    fun execute(leagueId: UUID): Result<Unit, WaitingListDomainError> {
        val firstEntry = waitingListEntryRepository.findFirstByLeagueIdAndStatusOrderByPositionAsc(leagueId, WaitingListStatus.WAITING).orElse(null)
        if (firstEntry != null) {
            val promoteResult = promoteEntryUseCase.execute(leagueId, firstEntry.id, false)
            if (promoteResult is Result.Failure) {
                return Result.Failure(promoteResult.error)
            }
        }
        return Result.Success(Unit)
    }
}
