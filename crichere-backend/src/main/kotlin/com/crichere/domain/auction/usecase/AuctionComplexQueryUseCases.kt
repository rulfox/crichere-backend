package com.crichere.domain.auction.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.auction.dto.*
import com.crichere.domain.auction.entity.Bid
import com.crichere.domain.auction.entity.PlayerAuctionState
import com.crichere.domain.auction.enums.PlayerAuctionStateValue
import com.crichere.domain.auction.enums.PlayerPoolSource
import com.crichere.domain.auction.error.AuctionDomainError
import com.crichere.domain.auction.repository.*
import com.crichere.domain.franchise.repository.FranchisePurseStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.player.repository.LeaguePlayerRepository
import com.crichere.domain.auth.repository.UserRepository
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

interface AuctionComplexQueryUseCases {
    fun getStateSnapshot(auctionId: UUID): Result<AuctionStateSnapshot, AuctionDomainError>
    fun getPlayerPool(auctionId: UUID, roundId: UUID): Result<List<PlayerAuctionStateResponse>, AuctionDomainError>
    fun getBidHistory(auctionId: UUID, leaguePlayerId: UUID): Result<List<Bid>, AuctionDomainError>
    fun getDetailedAuctionSummary(auctionId: UUID): Result<AuctionSummaryResponse, AuctionDomainError>
    fun getFranchiseDetailedSummary(auctionId: UUID, franchiseId: UUID): Result<FranchiseDetailedSummaryResponse, AuctionDomainError>
    fun getUnsoldPlayers(auctionId: UUID, pageable: Pageable): Result<UnsoldPlayersResponse, AuctionDomainError>
}

@Service
class AuctionComplexQueryUseCasesImpl(
    private val auctionRepository: AuctionRepository,
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val slabRepository: BidIncrementSlabRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val purseRepository: FranchisePurseStateRepository,
    private val franchiseRepository: FranchiseRepository,
    private val franchisePlayerRepository: FranchisePlayerRepository,
    private val auctionAuditLogRepository: AuctionAuditLogRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val userRepository: UserRepository,
    private val leagueRepository: LeagueRepository,
    private val poolPlayerRepository: AuctionRoundPoolPlayerRepository,
    private val bidRepository: BidRepository,
    private val resolveBasePriceQuery: com.crichere.domain.league.usecase.ResolveBasePriceQuery,
    private val getTimerStateQuery: GetTimerStateQuery
) : AuctionComplexQueryUseCases {

    private fun mapToStateResponse(s: PlayerAuctionState): PlayerAuctionStateResponse {
        val lp = leaguePlayerRepository.findById(s.leaguePlayerId).get()
        val user = userRepository.findById(lp.userId).get()
        return PlayerAuctionStateResponse(
            id = s.id,
            auctionId = s.auctionId,
            leaguePlayerId = s.leaguePlayerId,
            state = s.state,
            currentHighestBid = s.currentHighestBid,
            currentHighestBidderId = s.currentHighestBidderId,
            finalPrice = s.finalPrice,
            soldToFranchiseId = s.soldToFranchiseId,
            playerName = user.name ?: "Unknown",
            playerCategory = lp.category,
            basePrice = resolveBasePriceQuery.execute(lp),
            playerPhoto = user.profilePhoto
        )
    }

    @Transactional(readOnly = true)
    override fun getStateSnapshot(auctionId: UUID): Result<AuctionStateSnapshot, AuctionDomainError> {
        val auction = auctionRepository.findById(auctionId).orElse(null) 
            ?: return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val league = leagueRepository.findById(auction.leagueId).get()
        val round = auction.currentRoundId?.let { roundConfigRepository.findById(it).orElse(null) }
        val playerState = auction.currentLeaguePlayerId?.let { playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, it).orElse(null) }
        
        val currentRoundIdForPurse = auction.currentRoundId ?: roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId).lastOrNull()?.id
        val purses = if (currentRoundIdForPurse != null) {
            purseRepository.findByAuctionId(auctionId).filter { it.roundId == currentRoundIdForPurse }
        } else {
            emptyList()
        }
        
        val lastSeq = auctionAuditLogRepository.findMaxSequenceNumberByAuctionId(auctionId)
        
        val timerResult = getTimerStateQuery.execute(auction)
        val timerState = if (timerResult is Result.Success) timerResult.data else TimerStateResponse(false, null, null, null, 10)

        val snapshot = AuctionStateSnapshot(
            leagueName = league.name,
            auctionStatus = auction.status,
            currentRound = round?.let { r -> RoundConfigDto(
                roundNumber = r.roundNumber,
                name = r.name,
                currencyType = r.currencyType,
                purseAmount = r.purseAmount,
                purseSource = r.purseSource,
                bidMode = r.bidMode,
                playerPoolSource = r.playerPoolSource,
                franchiseEligibilityRule = r.franchiseEligibilityRule,
                completionTrigger = r.completionTrigger,
                bidIncrementSlabs = slabRepository.findByRoundIdOrderByFromAmountAsc(r.id).map { s -> 
                    BidIncrementSlabDto(s.fromAmount, s.toAmount, s.incrementBy)
                }
            )},
            currentPlayer = playerState?.let { p -> mapToStateResponse(p) },
            currentHighestBid = playerState?.currentHighestBid,
            currentHighestBidderId = playerState?.currentHighestBidderId,
            franchisePurseStates = run {
                val franchiseById = franchiseRepository.findByLeagueId(auction.leagueId).associateBy { it.id }
                purses.map { p ->
                    val f = franchiseById[p.franchiseId]
                    FranchisePurseStateResponse(
                        p.id, p.franchiseId, p.roundId, p.currencyType, p.startingAmount, p.currentAmount, p.reservedAmount,
                        franchiseName = f?.name, franchiseLogoUrl = f?.logoUrl
                    )
                }
            },
            timer = timerState,
            lastSequenceNumber = lastSeq
        )
        return Result.Success(snapshot)
    }

    @Transactional(readOnly = true)
    override fun getPlayerPool(auctionId: UUID, roundId: UUID): Result<List<PlayerAuctionStateResponse>, AuctionDomainError> {
        val roundOpt = roundConfigRepository.findById(roundId)
        if (roundOpt.isEmpty) return Result.Failure(AuctionDomainError.RoundNotFound(roundId))
        val round = roundOpt.get()
        val playerStates = playerStateRepository.findByAuctionId(auctionId)
        
        val filtered = when (round.playerPoolSource) {
            PlayerPoolSource.ALL_REGISTERED -> playerStates.filter { it.state == PlayerAuctionStateValue.AVAILABLE }
            PlayerPoolSource.UNSOLD_PREVIOUS_ROUND -> {
                val prevRounds = roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId)
                val currentIndex = prevRounds.indexOfFirst { it.id == roundId }
                if (currentIndex > 0) {
                    val prevRoundId = prevRounds[currentIndex - 1].id
                    playerStates.filter { it.state == PlayerAuctionStateValue.UNSOLD && it.roundId == prevRoundId }
                } else {
                    emptyList()
                }
            }
            PlayerPoolSource.UNSOLD_ANY_PREVIOUS_ROUND -> 
                playerStates.filter { it.state == PlayerAuctionStateValue.UNSOLD }
            PlayerPoolSource.AUCTIONEER_CURATED -> {
                val curatedIds = poolPlayerRepository.findByRoundId(roundId).map { it.leaguePlayerId }.toSet()
                playerStates.filter { it.leaguePlayerId in curatedIds && (it.state == PlayerAuctionStateValue.AVAILABLE || it.state == PlayerAuctionStateValue.UNSOLD) }
            }
        }
        return Result.Success(filtered.map { mapToStateResponse(it) })
    }

    @Transactional(readOnly = true)
    override fun getBidHistory(auctionId: UUID, leaguePlayerId: UUID): Result<List<Bid>, AuctionDomainError> {
        return Result.Success(bidRepository.findByLeaguePlayerIdAndAuctionIdOrderByBidAtDesc(leaguePlayerId, auctionId))
    }

    @Transactional(readOnly = true)
    override fun getDetailedAuctionSummary(auctionId: UUID): Result<AuctionSummaryResponse, AuctionDomainError> {
        val auctionOpt = auctionRepository.findById(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()
        
        val league = leagueRepository.findById(auction.leagueId).get()
        val playerStates = playerStateRepository.findByAuctionId(auctionId)
        val franchises = franchiseRepository.findByLeagueId(auction.leagueId)
        val rounds = roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId)
        val currentRoundId = auction.currentRoundId ?: rounds.lastOrNull()?.id
        
        val soldPlayers = playerStates.filter { it.state == PlayerAuctionStateValue.SOLD || it.state == PlayerAuctionStateValue.FORCE_ASSIGNED || it.state == PlayerAuctionStateValue.PRE_ASSIGNED }
        val highestSaleState = soldPlayers.maxByOrNull { it.finalPrice ?: 0 }
        
        val franchiseSummaries = franchises.map { f ->
            val fPlayers = franchisePlayerRepository.findByFranchiseId(f.id)
            val purse = if (currentRoundId != null) purseRepository.findByFranchiseIdAndRoundId(f.id, currentRoundId) else null
            FranchiseSummary(
                f.id, f.name, fPlayers.size, fPlayers.sumOf { it.boughtPrice.toLong() }, 
                purse?.currentAmount ?: f.remainingPurse,
                fPlayers.map { fp -> 
                    val lp = leaguePlayerRepository.findById(fp.leaguePlayerId).get()
                    val pState = playerStates.find { it.leaguePlayerId == fp.leaguePlayerId }
                    val round = rounds.find { it.id == fp.roundId }
                    AuctionPlayerSummary(
                        playerName = userRepository.findById(lp.userId).get().name ?: "Unknown",
                        playerCategory = lp.category,
                        finalPrice = fp.boughtPrice,
                        assignmentType = pState?.state?.name ?: "SOLD",
                        roundNumber = round?.roundNumber ?: 1
                    )
                }
            )
        }
        
        val summary = AuctionSummaryResponse(
            auctionId = auction.id,
            leagueId = league.id,
            leagueName = league.name,
            status = auction.status,
            startedAt = auction.startedAt,
            completedAt = auction.completedAt,
            totalPlayers = playerStates.size,
            totalSold = soldPlayers.size,
            totalUnsold = playerStates.count { it.state == PlayerAuctionStateValue.UNSOLD },
            totalWithdrawn = playerStates.count { it.state == PlayerAuctionStateValue.WITHDRAWN },
            totalSpent = soldPlayers.sumOf { (it.finalPrice ?: 0).toLong() },
            highestSale = highestSaleState?.let { s -> 
                SaleSummary(
                    userRepository.findById(leaguePlayerRepository.findById(s.leaguePlayerId).get().userId).get().name ?: "Unknown",
                    franchiseRepository.findById(s.soldToFranchiseId!!).get().name,
                    s.finalPrice!!
                )
            },
            franchiseSummaries = franchiseSummaries
        )
        return Result.Success(summary)
    }

    @Transactional(readOnly = true)
    override fun getFranchiseDetailedSummary(auctionId: UUID, franchiseId: UUID): Result<FranchiseDetailedSummaryResponse, AuctionDomainError> {
        val franchiseOpt = franchiseRepository.findById(franchiseId)
        if (franchiseOpt.isEmpty) return Result.Failure(AuctionDomainError.FranchiseNotFound(franchiseId))
        val franchise = franchiseOpt.get()
        
        val auctionOpt = auctionRepository.findById(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        val fPlayers = franchisePlayerRepository.findByFranchiseId(franchiseId)
        val rounds = roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId)
        val currentRoundId = auction.currentRoundId ?: rounds.lastOrNull()?.id
        val purse = if (currentRoundId != null) purseRepository.findByFranchiseIdAndRoundId(franchiseId, currentRoundId) else null
        
        val playerSummaries = fPlayers.map { fp ->
            val lp = leaguePlayerRepository.findById(fp.leaguePlayerId).get()
            val pState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, fp.leaguePlayerId).orElse(null)
            val round = rounds.find { it.id == fp.roundId }
            AuctionPlayerSummary(
                playerName = userRepository.findById(lp.userId).get().name ?: "Unknown",
                playerCategory = lp.category,
                finalPrice = fp.boughtPrice,
                assignmentType = pState?.state?.name ?: "SOLD",
                roundNumber = round?.roundNumber ?: 1
            )
        }

        val categoryBreakdown = playerSummaries.groupBy { it.playerCategory ?: "Unknown" }.map { (cat, list) ->
            CategoryBreakdown(cat, list.size, list.sumOf { (it.finalPrice ?: 0).toLong() })
        }

        val response = FranchiseDetailedSummaryResponse(
            franchiseId = franchise.id,
            franchiseName = franchise.name,
            squadCount = fPlayers.size,
            totalSpent = fPlayers.sumOf { it.boughtPrice.toLong() },
            remainingPurse = purse?.currentAmount ?: franchise.remainingPurse,
            categoryBreakdown = categoryBreakdown,
            players = playerSummaries
        )
        return Result.Success(response)
    }

    @Transactional(readOnly = true)
    override fun getUnsoldPlayers(auctionId: UUID, pageable: Pageable): Result<UnsoldPlayersResponse, AuctionDomainError> {
        val unsoldPage = playerStateRepository.findByAuctionIdAndState(auctionId, PlayerAuctionStateValue.UNSOLD, pageable)
        
        val summaries = unsoldPage.content.map { s ->
            val lp = leaguePlayerRepository.findById(s.leaguePlayerId).get()
            AuctionPlayerSummary(
                playerName = userRepository.findById(lp.userId).get().name ?: "Unknown",
                playerCategory = lp.category,
                finalPrice = null,
                assignmentType = null,
                roundNumber = null
            )
        }

        val response = UnsoldPlayersResponse(
            players = summaries,
            totalElements = unsoldPage.totalElements,
            totalPages = unsoldPage.totalPages,
            pageNumber = unsoldPage.number,
            pageSize = unsoldPage.size
        )
        return Result.Success(response)
    }
}
