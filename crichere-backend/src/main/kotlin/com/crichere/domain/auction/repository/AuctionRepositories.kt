package com.crichere.domain.auction.repository

import com.crichere.domain.auction.entity.*
import com.crichere.domain.auction.enums.BidStatus
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface AuctionRoundConfigRepository : JpaRepository<AuctionRoundConfig, UUID> {
    fun findByAuctionIdOrderByRoundNumberAsc(auctionId: UUID): List<AuctionRoundConfig>
}

@Repository
interface BidIncrementSlabRepository : JpaRepository<BidIncrementSlab, UUID> {
    fun findByRoundIdOrderByFromAmountAsc(roundId: UUID): List<BidIncrementSlab>
}

@Repository
interface BidRepository : JpaRepository<Bid, UUID> {
    fun findByLeaguePlayerIdAndAuctionIdOrderByBidAtDesc(leaguePlayerId: UUID, auctionId: UUID): List<Bid>
    fun findFirstByLeaguePlayerIdAndStatusOrderByBidAtDesc(leaguePlayerId: UUID, status: BidStatus): Optional<Bid>
}

@Repository
interface PlayerAuctionStateRepository : JpaRepository<PlayerAuctionState, UUID> {
    fun findByAuctionIdAndLeaguePlayerId(auctionId: UUID, leaguePlayerId: UUID): Optional<PlayerAuctionState>
    fun findByAuctionId(auctionId: UUID): List<PlayerAuctionState>
}

@Repository
interface AuctionAuditLogRepository : JpaRepository<AuctionAuditLog, UUID> {
    @Query("SELECT COALESCE(MAX(a.sequenceNumber), 0) FROM AuctionAuditLog a WHERE a.auctionId = :auctionId")
    fun findMaxSequenceNumberByAuctionId(auctionId: UUID): Long
    
    fun findByAuctionIdOrderBySequenceNumberAsc(auctionId: UUID): List<AuctionAuditLog>
    fun findByAuctionIdAndSequenceNumberGreaterThanOrderBySequenceNumberAsc(auctionId: UUID, sequenceNumber: Long): List<AuctionAuditLog>
}

@Repository
interface FranchisePlayerRepository : JpaRepository<FranchisePlayer, UUID> {
    fun findByLeaguePlayerId(leaguePlayerId: UUID): Optional<FranchisePlayer>
    fun deleteByLeaguePlayerId(leaguePlayerId: UUID)
    fun findByFranchiseId(franchiseId: UUID): List<FranchisePlayer>
}
