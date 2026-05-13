package com.crichere.domain.auction.dto

import com.crichere.domain.auction.enums.*
import com.crichere.domain.league.enums.AuctionStatus
import jakarta.validation.Valid
import jakarta.validation.constraints.*
import java.time.Instant
import java.util.UUID

data class AuctionCreateRequest(
    val auctioneerId: UUID,

    @field:NotEmpty
    @field:Valid
    val rounds: List<RoundConfigDto>
)

data class RoundConfigDto(
    @field:Positive
    val roundNumber: Int,

    @field:Size(max = 100)
    val name: String?,
    val currencyType: CurrencyType,
    val purseAmount: Int?,
    val purseSource: PurseSource,
    val bidMode: BidMode,
    val playerPoolSource: PlayerPoolSource,
    val franchiseEligibilityRule: FranchiseEligibilityRule,
    val completionTrigger: CompletionTrigger,
    val countdownSeconds: Int? = null,
    val antiSnipeSeconds: Int? = null,

    @field:NotEmpty
    @field:Valid
    val bidIncrementSlabs: List<BidIncrementSlabDto>
)

data class BidIncrementSlabDto(
    @field:PositiveOrZero
    val fromAmount: Int,
    val toAmount: Int?,

    @field:Positive
    val incrementBy: Int
)

data class CategoryIncrementRequest(
    val category: String? = null,
    val tag: String? = null,
    val bidIncrement: Int
)

data class CategoryIncrementResponse(
    val id: UUID,
    val roundId: UUID,
    val category: String?,
    val tag: String?,
    val bidIncrement: Int
)

data class AuctionResponse(
    val id: UUID,
    val leagueId: UUID,
    val auctioneerId: UUID?,
    val status: AuctionStatus,
    val currentRoundId: UUID?,
    val currentLeaguePlayerId: UUID?,
    val startedAt: Instant?,
    val completedAt: Instant?,
    val displayUrl: String? = null,
    val publicViewUrl: String? = null,
    val publicViewToken: String? = null
)

data class AuctionStateSnapshot(
    val leagueName: String,
    val auctionStatus: AuctionStatus,
    val currentRound: RoundConfigDto?,
    val currentPlayer: PlayerAuctionStateResponse?,
    val currentHighestBid: Int?,
    val currentHighestBidderId: UUID?,
    val franchisePurseStates: List<FranchisePurseStateResponse>,
    val timer: TimerStateResponse? = null,
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

    @field:Positive
    val bidAmount: Int
)

data class TimerStartRequest(
    val durationSeconds: Int? = null
)

data class TimerStateResponse(
    val isRunning: Boolean,
    val startedAt: Instant?,
    val durationSeconds: Int?,
    val remainingSeconds: Int?,
    val antiSnipeSeconds: Int
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

    @field:Positive
    val finalPrice: Int
)

data class UndoSoldRequest(
    val leaguePlayerId: UUID,

    @field:NotBlank
    @field:Size(max = 500)
    val reason: String
)

data class PreAssignRequest(
    val leaguePlayerId: UUID,
    val franchiseId: UUID,

    @field:NotBlank
    @field:Pattern(regexp = "CAPTAIN|ICON", message = "must be CAPTAIN or ICON")
    val assignmentType: String,

    @field:PositiveOrZero
    val price: Int = 0
)

data class ForceAssignRequest(
    val leaguePlayerId: UUID,
    val franchiseId: UUID,

    @field:PositiveOrZero
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
    val assignmentType: String?,
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
