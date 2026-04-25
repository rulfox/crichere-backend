package com.crichere.domain.waitinglist.repository

import com.crichere.domain.waitinglist.entity.WaitingListEntry
import com.crichere.domain.waitinglist.enums.WaitingListStatus
import com.crichere.domain.waitinglist.enums.WaitingListType
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface WaitingListEntryRepository : JpaRepository<WaitingListEntry, UUID> {
    fun findByLeagueIdAndUserIdAndStatus(leagueId: UUID, userId: UUID, status: WaitingListStatus): Optional<WaitingListEntry>
    fun findByLeagueIdAndUserId(leagueId: UUID, userId: UUID): Optional<WaitingListEntry>
    
    fun findByLeagueIdOrderByPositionAsc(leagueId: UUID, pageable: Pageable): Page<WaitingListEntry>
    fun findByLeagueIdAndTypeOrderByPositionAsc(leagueId: UUID, type: WaitingListType, pageable: Pageable): Page<WaitingListEntry>
    fun findByLeagueIdAndStatusOrderByPositionAsc(leagueId: UUID, status: WaitingListStatus, pageable: Pageable): Page<WaitingListEntry>
    fun findByLeagueIdAndStatusAndTypeOrderByPositionAsc(leagueId: UUID, status: WaitingListStatus, type: WaitingListType, pageable: Pageable): Page<WaitingListEntry>
    
    fun findByLeagueIdAndStatusOrderByPositionAsc(leagueId: UUID, status: WaitingListStatus): List<WaitingListEntry>

    @Query("SELECT COALESCE(MAX(e.position), 0) FROM WaitingListEntry e WHERE e.leagueId = :leagueId")
    fun findMaxPositionByLeagueId(leagueId: UUID): Int

    fun findFirstByLeagueIdAndStatusOrderByPositionAsc(leagueId: UUID, status: WaitingListStatus): Optional<WaitingListEntry>
}
