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
interface AuctionRoundCategoryIncrementRepository : JpaRepository<AuctionRoundCategoryIncrement, UUID> {
    fun findByRoundId(roundId: UUID): List<AuctionRoundCategoryIncrement>
}

@Repository
interface BidRepository : JpaRepository<Bid, UUID> {
    fun findByLeaguePlayerIdAndAuctionIdOrderByBidAtDesc(leaguePlayerId: UUID, auctionId: UUID): List<Bid>
    fun findFirstByLeaguePlayerIdAndAuctionIdAndStatusOrderByBidAtDesc(leaguePlayerId: UUID, auctionId: UUID, status: BidStatus): Optional<Bid>
}

@Repository
interface PlayerAuctionStateRepository : JpaRepository<PlayerAuctionState, UUID> {
    fun findByAuctionIdAndLeaguePlayerId(auctionId: UUID, leaguePlayerId: UUID): Optional<PlayerAuctionState>
    fun findByAuctionId(auctionId: UUID): List<PlayerAuctionState>
    fun findByAuctionIdAndState(auctionId: UUID, state: com.crichere.domain.auction.enums.PlayerAuctionStateValue, pageable: org.springframework.data.domain.Pageable): org.springframework.data.domain.Page<PlayerAuctionState>

    @Query(
        "SELECT CASE WHEN COUNT(s) > 0 THEN true ELSE false END " +
        "FROM PlayerAuctionState s, com.crichere.domain.player.entity.LeaguePlayer lp " +
        "WHERE s.auctionId = :auctionId AND s.leaguePlayerId = lp.id AND lp.userId = :userId"
    )
    fun existsByAuctionIdAndUserId(auctionId: UUID, userId: UUID): Boolean
}

@Repository
interface AuctionAuditLogRepository : JpaRepository<AuctionAuditLog, UUID> {
    @Query("SELECT COALESCE(MAX(a.sequenceNumber), 0) FROM AuctionAuditLog a WHERE a.auctionId = :auctionId")
    fun findMaxSequenceNumberByAuctionId(auctionId: UUID): Long

    fun findByAuctionIdOrderBySequenceNumberAsc(auctionId: UUID): List<AuctionAuditLog>
    fun findByAuctionIdAndSequenceNumberGreaterThanOrderBySequenceNumberAsc(auctionId: UUID, sequenceNumber: Long): List<AuctionAuditLog>

    /**
     * Bulk-delete audit-log rows for auctions in a terminal state (COMPLETED/CANCELLED)
     * that completed before the cutoff. Returns the row count.
     */
    @org.springframework.data.jpa.repository.Modifying
    @Query(
        value = "DELETE FROM auction_audit_logs l " +
                "WHERE l.auction_id IN (" +
                "    SELECT a.id FROM auctions a " +
                "    WHERE a.status IN ('COMPLETED','CANCELLED') AND a.completed_at < :cutoff" +
                ")",
        nativeQuery = true
    )
    fun deleteCompletedBefore(@org.springframework.data.repository.query.Param("cutoff") cutoff: java.time.Instant): Int
}

@Repository
interface FranchisePlayerRepository : JpaRepository<FranchisePlayer, UUID> {
    fun findByLeaguePlayerId(leaguePlayerId: UUID): Optional<FranchisePlayer>
    fun deleteByLeaguePlayerId(leaguePlayerId: UUID)
    fun findByFranchiseId(franchiseId: UUID): List<FranchisePlayer>
}

@Repository
interface AuctionRoundPoolPlayerRepository : JpaRepository<AuctionRoundPoolPlayer, UUID> {
    fun findByRoundId(roundId: UUID): List<AuctionRoundPoolPlayer>
    fun deleteByRoundId(roundId: UUID)
}
