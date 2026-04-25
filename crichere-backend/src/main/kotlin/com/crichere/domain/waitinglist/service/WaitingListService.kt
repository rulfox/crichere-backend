package com.crichere.domain.waitinglist.service

import com.crichere.common.exception.AlreadyExistsException
import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.fee.service.FeeService
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
import com.crichere.domain.waitinglist.repository.WaitingListEntryRepository
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.util.*

@Service
class WaitingListService(
    private val waitingListEntryRepository: WaitingListEntryRepository,
    private val leagueRepository: LeagueRepository,
    private val userRepository: UserRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val franchiseRepository: FranchiseRepository,
    private val feeService: FeeService,
    private val notificationService: com.crichere.domain.notification.service.NotificationService
) {

    @Transactional
    fun addToWaitingList(leagueId: UUID, userId: UUID, request: WaitingListEntryCreateRequest): WaitingListEntryResponse {
        waitingListEntryRepository.findByLeagueIdAndUserIdAndStatus(leagueId, userId, WaitingListStatus.WAITING)
            .ifPresent { throw AlreadyExistsException("Already on waiting list", "error.already_on_waiting_list") }

        // Participant check
        if (leaguePlayerRepository.findByLeagueIdAndUserId(leagueId, userId) != null) {
             throw AlreadyExistsException("Already a player in this league", "error.already_league_participant")
        }
        if (franchiseRepository.findByLeagueId(leagueId).any { it.ownerId == userId }) {
             throw AlreadyExistsException("Already a franchise owner in this league", "error.already_league_participant")
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
            return mapToResponse(entry)
        } catch (e: DataIntegrityViolationException) {
            throw AlreadyExistsException("Position conflict due to concurrent request. Please try again.", "error.waiting_list_position_conflict")
        }
    }

    fun getWaitingList(leagueId: UUID, type: WaitingListType?, status: WaitingListStatus?, pageable: Pageable): Page<WaitingListEntryResponse> {
        val page = when {
            type != null && status != null -> waitingListEntryRepository.findByLeagueIdAndStatusAndTypeOrderByPositionAsc(leagueId, status, type, pageable)
            type != null -> waitingListEntryRepository.findByLeagueIdAndTypeOrderByPositionAsc(leagueId, type, pageable)
            status != null -> waitingListEntryRepository.findByLeagueIdAndStatusOrderByPositionAsc(leagueId, status, pageable)
            else -> waitingListEntryRepository.findByLeagueIdOrderByPositionAsc(leagueId, pageable)
        }
        return page.map { mapToResponse(it) }
    }

    fun getMyPosition(leagueId: UUID, userId: UUID): WaitingListEntryResponse {
        return waitingListEntryRepository.findByLeagueIdAndUserIdAndStatus(leagueId, userId, WaitingListStatus.WAITING)
            .map { mapToResponse(it) }
            .orElseThrow { ResourceNotFoundException("Not on waiting list", "error.not_on_waiting_list") }
    }

    @Transactional
    fun withdraw(leagueId: UUID, entryId: UUID, userId: UUID) {
        val entry = waitingListEntryRepository.findById(entryId)
            .orElseThrow { ResourceNotFoundException("Entry not found", "error.waiting_list_entry_not_found") }
        
        if (entry.userId != userId) {
             throw com.crichere.common.exception.UnauthorizedException("Cannot withdraw someone else's entry")
        }

        if (entry.status != WaitingListStatus.WAITING) {
            throw BusinessLogicException("Cannot withdraw resolved entry", "error.cannot_withdraw_resolved_entry")
        }

        entry.status = WaitingListStatus.WITHDRAWN
        waitingListEntryRepository.save(entry)
        
        recalculatePositions(leagueId)
    }

    @Transactional
    fun promoteEntry(leagueId: UUID, entryId: UUID, manual: Boolean = true): WaitingListEntryResponse {
        val entry = waitingListEntryRepository.findById(entryId)
            .orElseThrow { ResourceNotFoundException("Entry not found", "error.waiting_list_entry_not_found") }
        
        if (entry.status != WaitingListStatus.WAITING) {
            throw BusinessLogicException("Entry is not in WAITING status", "error.invalid_entry_status")
        }

        val league = leagueRepository.findById(leagueId).get()
        if (manual && league.waitingListMode == com.crichere.domain.league.enums.WaitingListMode.AUTO_PROMOTE) {
            throw BusinessLogicException("Auto-promote mode is active", "error.auto_promote_mode_active")
        }

        entry.status = WaitingListStatus.PROMOTED
        entry.promotedAt = Instant.now()
        waitingListEntryRepository.save(entry)

        // Create participant
        if (entry.type == WaitingListType.PLAYER) {
            leaguePlayerRepository.save(LeaguePlayer(
                leagueId = leagueId,
                userId = entry.userId
            ))
        } else {
            val user = userRepository.findById(entry.userId).get()
            franchiseRepository.save(Franchise(
                leagueId = leagueId,
                ownerId = entry.userId,
                name = "${user.name}'s Franchise"
            ))
        }

        // Notification logic
        notificationService.notifyWaitingListPromoted(entry.userId, league.name)
        
        recalculatePositions(leagueId)
        return mapToResponse(entry)
    }

    @Transactional
    fun promoteNext(leagueId: UUID) {
        waitingListEntryRepository.findFirstByLeagueIdAndStatusOrderByPositionAsc(leagueId, WaitingListStatus.WAITING)
            .ifPresent { promoteEntry(leagueId, it.id, false) }
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
