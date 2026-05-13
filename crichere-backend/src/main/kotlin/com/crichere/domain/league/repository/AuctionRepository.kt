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

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT a FROM Auction a WHERE a.id = :id")
    fun findByIdWithLock(id: UUID): Optional<Auction>
}
