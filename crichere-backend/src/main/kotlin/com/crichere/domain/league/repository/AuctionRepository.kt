package com.crichere.domain.league.repository

import com.crichere.domain.league.entity.Auction
import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface AuctionRepository : JpaRepository<Auction, UUID> {
    fun findByLeagueId(leagueId: UUID): Auction?
    fun findByPublicViewToken(token: String): Auction?
}
