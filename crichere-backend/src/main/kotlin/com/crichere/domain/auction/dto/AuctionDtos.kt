package com.crichere.domain.auction.dto

import com.crichere.domain.auction.enums.*
import com.crichere.domain.league.enums.AuctionStatus
import java.time.Instant
import java.util.UUID

data class AuctionCreateRequest(
    val auctioneerId: UUID,
    val rounds: List<RoundConfigDto>
)

data class RoundConfigDto(
    val roundNumber: Int,
    val name: String?,
    val currencyType: CurrencyType,
    val purseAmount: Int?,
    val purseSource: PurseSource,
    val bidMode: BidMode,
    val playerPoolSource: PlayerPoolSource,
    val franchiseEligibilityRule: FranchiseEligibilityRule,
    val completionTrigger: CompletionTrigger,
    val bidIncrementSlabs: List<BidIncrementSlabDto>
)

data class BidIncrementSlabDto(
    val fromAmount: Int,
    val toAmount: Int?,
    val incrementBy: Int
)

data class AuctionResponse(
    val id: UUID,
    val leagueId: UUID,
    val auctioneerId: UUID?,
    val status: AuctionStatus,
    val currentRoundId: UUID?,
    val currentLeaguePlayerId: UUID?,
    val startedAt: Instant?,
    val completedAt: Instant?
)

data class AuctionStateSnapshot(
    val auctionStatus: AuctionStatus,
    val currentRound: RoundConfigDto?,
    val currentPlayer: PlayerAuctionStateResponse?,
    val currentHighestBid: Int?,
    val currentHighestBidderId: UUID?,
    val franchisePurseStates: List<FranchisePurseStateResponse>,
    val lastSequenceNumber: Long
)

data class PlayerAuctionStateResponse(
    val id: UUID,
    val auctionId: UUID,
    val leaguePlayerId: UUID,
    val state: PlayerAuctionStateValue,
    val currentHighestBid: Int?,
    val currentHighestBidderId: UUID?,
    val finalPrice: Int?,
    val soldToFranchiseId: UUID?
)

data class FranchisePurseStateResponse(
    val id: UUID,
    val franchiseId: UUID,
    val roundId: UUID?,
    val currencyType: CurrencyType?,
    val startingAmount: Int?,
    val currentAmount: Int,
    val reservedAmount: Int
)

data class BidRequest(
    val franchiseId: UUID,
    val bidAmount: Int
)

data class BidResponse(
    val id: UUID,
    val auctionId: UUID,
    val roundId: UUID,
    val leaguePlayerId: UUID,
    val franchiseId: UUID,
    val bidAmount: Int,
    val status: BidStatus,
    val recordedBy: UUID,
    val bidAt: Instant
)

data class PlayerSoldRequest(
    val leaguePlayerId: UUID,
    val franchiseId: UUID,
    val finalPrice: Int
)

data class UndoSoldRequest(
    val leaguePlayerId: UUID,
    val reason: String
)

data class PreAssignRequest(
    val leaguePlayerId: UUID,
    val franchiseId: UUID,
    val assignmentType: String, // CAPTAIN, ICON
    val price: Int = 0
)

data class ForceAssignRequest(
    val leaguePlayerId: UUID,
    val franchiseId: UUID,
    val price: Int = 0
)

data class AuditLogResponse(
    val id: UUID,
    val auctionId: UUID,
    val sequenceNumber: Long,
    val action: AuctionAction,
    val payload: Map<String, Any?>,
    val actorId: UUID?,
    val createdAt: Instant
)

data class AuctionSummaryResponse(
    val auctionId: UUID,
    val leagueId: UUID,
    val leagueName: String,
    val status: AuctionStatus,
    val startedAt: Instant?,
    val completedAt: Instant?,
    val totalPlayers: Int,
    val totalSold: Int,
    val totalUnsold: Int,
    val totalWithdrawn: Int,
    val totalSpent: Long,
    val highestSale: SaleSummary?,
    val franchiseSummaries: List<FranchiseSummary>
)

data class SaleSummary(
    val playerName: String,
    val franchiseName: String,
    val amount: Int
)

data class FranchiseSummary(
    val franchiseId: UUID,
    val franchiseName: String,
    val squadCount: Int,
    val totalSpent: Long,
    val remainingPurse: Int,
    val players: List<AuctionPlayerSummary> = emptyList()
)

data class AuctionPlayerSummary(
    val playerName: String,
    val playerCategory: String?,
    val playerTag: String? = null,
    val finalPrice: Int?,
    val assignmentType: String?, // SOLD, FORCE_ASSIGNED, PRE_ASSIGNED
    val roundNumber: Int?
)

data class FranchiseDetailedSummaryResponse(
    val franchiseId: UUID,
    val franchiseName: String,
    val squadCount: Int,
    val totalSpent: Long,
    val remainingPurse: Int,
    val categoryBreakdown: List<CategoryBreakdown>,
    val players: List<AuctionPlayerSummary>
)

data class CategoryBreakdown(
    val category: String,
    val count: Int,
    val totalSpent: Long
)

data class UnsoldPlayersResponse(
    val players: List<AuctionPlayerSummary>,
    val totalElements: Long,
    val totalPages: Int,
    val pageNumber: Int,
    val pageSize: Int
)
