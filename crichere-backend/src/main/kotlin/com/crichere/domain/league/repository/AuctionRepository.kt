package com.crichere.domain.league.repository

import com.crichere.domain.league.entity.Auction
import jakarta.persistence.LockModeType
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Lock
import org.springframework.data.jpa.repository.Query
import java.util.*

interface AuctionRepository : JpaRepository<Auction, UUID> {
    fun findByLeagueId(leagueId: UUID): Auction?
    fun findByPublicViewToken(token: String): Auction?
    fun findAllByLeagueId(leagueId: UUID): List<Auction>
    fun findAllByLeagueIdIn(leagueIds: Collection<UUID>): List<Auction>

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT a FROM Auction a WHERE a.id = :id")
    fun findByIdWithLock(id: UUID): Optional<Auction>

    /**
     * Live auctions whose countdown timer is currently active. The expiry decision is
     * made in code (Instant arithmetic) so this just narrows the candidate set.
     */
    @Query(
        "SELECT a FROM Auction a WHERE a.status = com.crichere.domain.league.enums.AuctionStatus.LIVE " +
        "AND a.timerStartedAt IS NOT NULL AND a.timerDurationSeconds IS NOT NULL " +
        "AND a.currentLeaguePlayerId IS NOT NULL"
    )
    fun findAllWithActiveTimer(): List<Auction>
}
