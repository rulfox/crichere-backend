package com.crichere.domain.auction.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.InsufficientPurseException
import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.auction.dto.*
import com.crichere.domain.auction.entity.*
import com.crichere.domain.auction.enums.*
import com.crichere.domain.auction.repository.*
import com.crichere.domain.league.enums.AuctionStatus
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.player.repository.LeaguePlayerRepository
import com.crichere.domain.franchise.repository.FranchisePurseStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.entity.Auction
import com.crichere.domain.franchise.entity.FranchisePurseState
import org.springframework.data.redis.core.StringRedisTemplate
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import com.fasterxml.jackson.databind.ObjectMapper
import io.micrometer.core.instrument.MeterRegistry
import java.time.Instant
import java.util.*

@Service
class AuctionService(
    private val auctionRepository: AuctionRepository,
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val slabRepository: BidIncrementSlabRepository,
    private val categoryIncrementRepository: AuctionRoundCategoryIncrementRepository,
    private val bidRepository: BidRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val purseRepository: FranchisePurseStateRepository,
    private val franchiseRepository: FranchiseRepository,
    private val franchisePlayerRepository: FranchisePlayerRepository,
    private val auctionAuditLogRepository: AuctionAuditLogRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val userRepository: com.crichere.domain.auth.repository.UserRepository,
    private val leagueRepository: com.crichere.domain.league.repository.LeagueRepository,
    private val poolPlayerRepository: AuctionRoundPoolPlayerRepository,
    private val redisTemplate: StringRedisTemplate,
    private val objectMapper: ObjectMapper,
    private val notificationService: com.crichere.domain.notification.service.NotificationService,
    private val leagueService: com.crichere.domain.league.service.LeagueService,
    private val meterRegistry: MeterRegistry
) {
    private val auctionStartedCounter = meterRegistry.counter("crichere.auction.started")
    private val bidPlacedCounter = meterRegistry.counter("crichere.auction.bids.placed")
    private val playerSoldCounter = meterRegistry.counter("crichere.auction.players.sold")

    @Transactional
    fun createAuction(leagueId: UUID, auctioneerId: UUID, rounds: List<com.crichere.domain.auction.dto.RoundConfigDto>): Auction {
        val auction = auctionRepository.save(Auction(leagueId = leagueId, auctioneerId = auctioneerId, status = AuctionStatus.DRAFT))
        
        rounds.forEach { roundDto ->
            val round = roundConfigRepository.save(AuctionRoundConfig(
                auctionId = auction.id,
                roundNumber = roundDto.roundNumber,
                name = roundDto.name,
                currencyType = roundDto.currencyType,
                purseAmount = roundDto.purseAmount,
                purseSource = roundDto.purseSource,
                bidMode = roundDto.bidMode,
                playerPoolSource = roundDto.playerPoolSource,
                franchiseEligibilityRule = roundDto.franchiseEligibilityRule,
                completionTrigger = roundDto.completionTrigger,
                countdownSeconds = roundDto.countdownSeconds ?: 60,
                antiSnipeSeconds = roundDto.antiSnipeSeconds ?: 10
            ))
            
            roundDto.bidIncrementSlabs.forEach { slabDto ->
                slabRepository.save(BidIncrementSlab(
                    roundId = round.id,
                    fromAmount = slabDto.fromAmount,
                    toAmount = slabDto.toAmount,
                    incrementBy = slabDto.incrementBy
                ))
            }
        }
        
        return auction
    }

    @Transactional
    fun startAuction(auctionId: UUID, actorId: UUID): Auction {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        if (auction.status != AuctionStatus.DRAFT) throw BusinessLogicException("Auction must be in DRAFT status to start", "error.invalid_auction_status")
        
        auction.status = AuctionStatus.LIVE
        auction.startedAt = Instant.now()
        
        // Initialize PlayerAuctionStates if not already done
        val existingPlayers = playerStateRepository.findByAuctionId(auction.id).map { it.leaguePlayerId }.toSet()
        val players = leaguePlayerRepository.findByLeagueId(auction.leagueId)
        players.filter { it.id !in existingPlayers && it.auctionEligible }.forEach { player ->
            playerStateRepository.save(PlayerAuctionState(
                auctionId = auction.id,
                leaguePlayerId = player.id,
                state = PlayerAuctionStateValue.AVAILABLE
            ))
        }
        
        val savedAuction = auctionRepository.save(auction)
        auctionStartedCounter.increment()
        logAndBroadcast(auction.id, AuctionAction.AUCTION_STARTED, mapOf("startedAt" to auction.startedAt), actorId)

        // Notify franchise owners
        val franchiseOwners = franchiseRepository.findByLeagueId(auction.leagueId).map { it.ownerId }
        val league = leagueRepository.findById(auction.leagueId).get()
        notificationService.notifyAuctionStarted(franchiseOwners, auction.id, league.name)

        return savedAuction
    }

    @Transactional
    fun pauseAuction(auctionId: UUID, reason: String?, actorId: UUID): Auction {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        if (auction.status != AuctionStatus.LIVE) throw BusinessLogicException("Auction must be LIVE to pause", "error.invalid_auction_status")
        auction.status = AuctionStatus.PAUSED
        val savedAuction = auctionRepository.save(auction)
        logAndBroadcast(auction.id, AuctionAction.AUCTION_PAUSED, mapOf("reason" to reason), actorId)
        return savedAuction
    }

    @Transactional
    fun resumeAuction(auctionId: UUID, actorId: UUID): Auction {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        if (auction.status != AuctionStatus.PAUSED) throw BusinessLogicException("Auction must be PAUSED to resume", "error.invalid_auction_status")
        auction.status = AuctionStatus.LIVE
        val savedAuction = auctionRepository.save(auction)
        logAndBroadcast(auction.id, AuctionAction.AUCTION_RESUMED, emptyMap(), actorId)
        return savedAuction
    }

    @Transactional
    fun completeAuction(auctionId: UUID, actorId: UUID): Auction {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        val playerStates = playerStateRepository.findByAuctionId(auction.id)

        val league = leagueRepository.findById(auction.leagueId).get()
        if (league.mustSellAll) {
            val unsoldCount = playerStates.count { it.state == PlayerAuctionStateValue.UNSOLD || it.state == PlayerAuctionStateValue.AVAILABLE }
            if (unsoldCount > 0) throw BusinessLogicException("Cannot complete: $unsoldCount player(s) still unsold. Disable mustSellAll or sell all players first.", "error.must_sell_all_violated")
        }

        auction.status = AuctionStatus.COMPLETED
        auction.completedAt = Instant.now()

        val totalSold = playerStates.count { it.state == PlayerAuctionStateValue.SOLD || it.state == PlayerAuctionStateValue.FORCE_ASSIGNED }
        val totalUnsold = playerStates.count { it.state == PlayerAuctionStateValue.UNSOLD }
        val totalSpent = playerStates.sumOf { it.finalPrice ?: 0 }
        
        val savedAuction = auctionRepository.save(auction)
        logAndBroadcast(auction.id, AuctionAction.AUCTION_COMPLETED, mapOf(
            "totalSold" to totalSold,
            "totalUnsold" to totalUnsold,
            "totalSpent" to totalSpent,
            "completedAt" to auction.completedAt
        ), actorId)
        return savedAuction
    }

    @Transactional
    fun startRound(auctionId: UUID, roundId: UUID, actorId: UUID): AuctionRoundConfig {
        val round = roundConfigRepository.findById(roundId).orElseThrow { ResourceNotFoundException("Round not found", "error.round_not_found") }
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        
        round.status = RoundStatus.LIVE
        round.startedAt = Instant.now()
        auction.currentRoundId = round.id
        
        // Purse logic
        val franchises = franchiseRepository.findByLeagueId(auction.leagueId)
        franchises.forEach { franchise ->
            val initialAmount = if (round.purseSource == PurseSource.FRESH) {
                round.purseAmount ?: franchise.totalPurse
            } else {
                // Carry over from previous round
                val prevRounds = roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId)
                val currentIndex = prevRounds.indexOfFirst { it.id == roundId }
                if (currentIndex > 0) {
                    val prevRound = prevRounds[currentIndex - 1]
                    val prevPurse = purseRepository.findByFranchiseIdAndRoundId(franchise.id, prevRound.id)
                    prevPurse?.currentAmount ?: franchise.remainingPurse
                } else {
                    franchise.remainingPurse
                }
            }
            
            purseRepository.save(FranchisePurseState(
                franchiseId = franchise.id,
                auctionId = auction.id,
                roundId = round.id,
                currencyType = round.currencyType,
                startingAmount = initialAmount,
                currentAmount = initialAmount
            ))
        }
        
        auctionRepository.save(auction)
        val savedRound = roundConfigRepository.save(round)
        logAndBroadcast(auctionId, AuctionAction.ROUND_STARTED, mapOf("roundId" to roundId, "roundNumber" to round.roundNumber), actorId)
        return savedRound
    }

    @Transactional
    fun putPlayer(auctionId: UUID, leaguePlayerId: UUID?, actorId: UUID): PlayerAuctionState {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        val league = leagueRepository.findById(auction.leagueId).get()
        val roundId = auction.currentRoundId ?: throw BusinessLogicException("No active round", "error.no_active_round")
        val round = roundConfigRepository.findById(roundId).get()

        val availablePlayers = when (round.playerPoolSource) {
            PlayerPoolSource.ALL_REGISTERED -> playerStateRepository.findByAuctionId(auctionId).filter { it.state == PlayerAuctionStateValue.AVAILABLE }
            PlayerPoolSource.UNSOLD_PREVIOUS_ROUND, PlayerPoolSource.UNSOLD_ANY_PREVIOUS_ROUND -> 
                playerStateRepository.findByAuctionId(auctionId).filter { it.state == PlayerAuctionStateValue.UNSOLD }
            PlayerPoolSource.AUCTIONEER_CURATED -> playerStateRepository.findByAuctionId(auctionId).filter { it.state == PlayerAuctionStateValue.AVAILABLE }
        }
        
        val playerId = when (league.playerOrderMode) {
            com.crichere.domain.league.enums.PlayerOrderMode.RANDOM -> {
                if (leaguePlayerId != null) throw BusinessLogicException("Manual selection not allowed in RANDOM mode", "error.manual_selection_disabled")
                if (availablePlayers.isEmpty()) throw BusinessLogicException("No available players in current pool", "error.empty_pool")
                availablePlayers.random().leaguePlayerId
            }
            com.crichere.domain.league.enums.PlayerOrderMode.FREE_PICK -> {
                leaguePlayerId ?: throw BusinessLogicException("Player selection required in FREE_PICK mode", "error.player_selection_required")
            }
            com.crichere.domain.league.enums.PlayerOrderMode.HYBRID -> {
                leaguePlayerId ?: run {
                    if (availablePlayers.isEmpty()) throw BusinessLogicException("No available players in current pool", "error.empty_pool")
                    availablePlayers.random().leaguePlayerId
                }
            }
        }
        
        val player = leaguePlayerRepository.findById(playerId).get()
        if (!player.auctionEligible) throw BusinessLogicException("Player is not eligible for auction", "error.player_not_eligible")

        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId)
            .orElseThrow { ResourceNotFoundException("Player not found in auction pool", "error.player_not_found") }

        if (playerState.state != PlayerAuctionStateValue.AVAILABLE && playerState.state != PlayerAuctionStateValue.UNSOLD) {
            throw BusinessLogicException("Player is not in a valid state to be put up (must be AVAILABLE or UNSOLD)", "error.invalid_player_state")
        }

        playerState.state = PlayerAuctionStateValue.UP_FOR_BIDDING
        playerState.currentHighestBid = null
        playerState.currentHighestBidderId = null
        
        auction.currentLeaguePlayerId = playerId
        auctionRepository.save(auction)
        
        val savedState = playerStateRepository.save(playerState)
        val user = userRepository.findById(player.userId).get()
        val basePrice = leagueService.resolveBasePrice(player)
        logAndBroadcast(auctionId, AuctionAction.PLAYER_UP, mapOf(
            "leaguePlayerId" to playerId,
            "playerName" to (user.name ?: "Unknown"), 
            "basePrice" to basePrice,
            "roundId" to roundId
        ), actorId)
        
        return savedState
    }

    @Transactional
    fun placeBid(auctionId: UUID, franchiseId: UUID, bidAmount: Int, actorId: UUID): Bid {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        val playerId = auction.currentLeaguePlayerId ?: throw BusinessLogicException("No player currently up for bidding", "error.no_player_up")
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId).get()
        
        if (playerState.state != PlayerAuctionStateValue.UP_FOR_BIDDING) throw BusinessLogicException("Player is not in bidding state", "error.invalid_player_state")
        
        val roundId = auction.currentRoundId!!
        val purse = purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId) ?: throw ResourceNotFoundException("Franchise purse not found for this round", "error.purse_not_found")
        
        if (purse.currentAmount < bidAmount) throw InsufficientPurseException("Insufficient purse amount")
        
        val currentBid = playerState.currentHighestBid
        val player = leaguePlayerRepository.findById(playerId).get()
        val basePrice = leagueService.resolveBasePrice(player)

        val minIncrement = resolveBidIncrement(roundId, player, currentBid ?: 0)

        if (currentBid == null) {
            if (bidAmount < basePrice) throw BusinessLogicException("Bid must be at least base price", "error.invalid_bid_amount")
        } else {
            if (bidAmount < currentBid + minIncrement) throw BusinessLogicException("Bid must be at least current highest bid + increment ($minIncrement)", "error.invalid_bid_amount")
        }
        
        val bid = bidRepository.save(Bid(
            auctionId = auction.id,
            roundId = roundId,
            leaguePlayerId = playerId,
            franchiseId = franchiseId,
            bidAmount = bidAmount,
            recordedBy = actorId
        ))
        bidPlacedCounter.increment()
        
        val prevBid = playerState.currentHighestBid
        val prevBidder = playerState.currentHighestBidderId
        
        playerState.currentHighestBid = bidAmount
        playerState.currentHighestBidderId = franchiseId
        playerStateRepository.save(playerState)
        
        logAndBroadcast(auctionId, AuctionAction.BID_PLACED, mapOf(
            "leaguePlayerId" to playerId,
            "franchiseId" to franchiseId,
            "bidAmount" to bidAmount,
            "previousHighestBid" to prevBid,
            "previousHighestBidder" to prevBidder
        ), actorId)

        // Anti-snipe logic
        if (auction.timerStartedAt != null && auction.timerDurationSeconds != null) {
            val now = Instant.now()
            val elapsed = java.time.Duration.between(auction.timerStartedAt, now).seconds
            val remaining = auction.timerDurationSeconds!! - elapsed
            val round = roundConfigRepository.findById(roundId).get()
            
            if (round.antiSnipeSeconds > 0 && remaining <= round.antiSnipeSeconds) {
                auction.timerStartedAt = now
                auction.timerDurationSeconds = round.antiSnipeSeconds
                auctionRepository.save(auction)
                logAndBroadcast(auctionId, AuctionAction.TIMER_RESET, mapOf(
                    "newDurationSeconds" to round.antiSnipeSeconds,
                    "startedAt" to now,
                    "reason" to "ANTI_SNIPE",
                    "leaguePlayerId" to playerId
                ), actorId)
            }
        }
        
        return bid
    }

    /**
     * Starts the bid countdown timer for the current player.
     * Broadcasts TIMER_STARTED event to all clients.
     */
    @Transactional
    fun startTimer(auctionId: UUID, durationOverride: Int?, actorId: UUID): TimerStateResponse {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        if (auction.status != AuctionStatus.LIVE) throw BusinessLogicException("Auction must be LIVE to start timer", "error.invalid_auction_status")
        val playerId = auction.currentLeaguePlayerId ?: throw BusinessLogicException("No player currently up for bidding", "error.no_player_up")
        val roundId = auction.currentRoundId ?: throw BusinessLogicException("No active round", "error.no_active_round")
        val round = roundConfigRepository.findById(roundId).get()

        val duration = durationOverride ?: round.countdownSeconds
        auction.timerStartedAt = Instant.now()
        auction.timerDurationSeconds = duration
        auctionRepository.save(auction)

        logAndBroadcast(auctionId, AuctionAction.TIMER_STARTED, mapOf(
            "durationSeconds" to duration,
            "startedAt" to auction.timerStartedAt,
            "antiSnipeSeconds" to round.antiSnipeSeconds,
            "leaguePlayerId" to playerId
        ), actorId)

        return getTimerState(auction)
    }

    /**
     * Stops the running bid timer.
     */
    @Transactional
    fun stopTimer(auctionId: UUID, actorId: UUID) {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        auction.timerStartedAt = null
        auction.timerDurationSeconds = null
        auctionRepository.save(auction)

        logAndBroadcast(auctionId, AuctionAction.TIMER_STOPPED, emptyMap(), actorId)
    }

    /**
     * Calculates the current timer state including remaining seconds.
     */
    fun getTimerState(auctionId: UUID): TimerStateResponse {
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        return getTimerState(auction)
    }

    /**
     * Resolves the minimum bid increment for a player based on their tag or category.
     * Falls back to round-level slab config if no specific increment is found.
     */
    private fun resolveBidIncrement(roundId: UUID, player: com.crichere.domain.player.entity.LeaguePlayer, currentBid: Int = 0): Int {
        val categoryIncrements = categoryIncrementRepository.findByRoundId(roundId)
        
        // Priority 1: Tag-based increment
        if (player.tag != null) {
            val tagInc = categoryIncrements.find { it.tag == player.tag }
            if (tagInc != null) return tagInc.bidIncrement
        }

        // Priority 2: Category-based increment
        if (player.category != null) {
            val catInc = categoryIncrements.find { it.category == player.category }
            if (catInc != null) return catInc.bidIncrement
        }

        // Fallback: Slab-based increment
        val slabs = slabRepository.findByRoundIdOrderByFromAmountAsc(roundId)
        val slab = slabs.findLast { currentBid >= it.fromAmount && (it.toAmount == null || currentBid < it.toAmount!!) }
        return slab?.incrementBy ?: 500
    }

    /**
     * Updates category/tag specific bid increments for a round. Only allowed for PENDING rounds.
     */
    @Transactional
    fun updateCategoryIncrements(roundId: UUID, increments: List<com.crichere.domain.auction.dto.CategoryIncrementRequest>): List<com.crichere.domain.auction.entity.AuctionRoundCategoryIncrement> {
        val round = roundConfigRepository.findById(roundId).orElseThrow { ResourceNotFoundException("Round not found", "error.round_not_found") }
        if (round.status != RoundStatus.PENDING) throw BusinessLogicException("Only PENDING rounds can be updated", "error.invalid_round_status")

        val existing = categoryIncrementRepository.findByRoundId(roundId)
        categoryIncrementRepository.deleteAll(existing)

        val newIncrements = increments.map { 
            com.crichere.domain.auction.entity.AuctionRoundCategoryIncrement(
                roundId = roundId,
                category = it.category,
                tag = it.tag,
                bidIncrement = it.bidIncrement
            )
        }
        return categoryIncrementRepository.saveAll(newIncrements)
    }

    /**
     * Retrieves all category-specific bid increments for a round.
     */
    fun getCategoryIncrements(roundId: UUID): List<com.crichere.domain.auction.entity.AuctionRoundCategoryIncrement> {
        return categoryIncrementRepository.findByRoundId(roundId)
    }

    private fun getTimerState(auction: Auction): TimerStateResponse {
        val round = auction.currentRoundId?.let { roundConfigRepository.findById(it).orElse(null) }
        val antiSnipe = round?.antiSnipeSeconds ?: 10

        if (auction.timerStartedAt == null || auction.timerDurationSeconds == null) {
            return TimerStateResponse(false, null, null, null, antiSnipe)
        }

        val now = Instant.now()
        val elapsed = java.time.Duration.between(auction.timerStartedAt, now).seconds
        val remaining = (auction.timerDurationSeconds!!.toLong() - elapsed).toInt().coerceAtLeast(0)

        return TimerStateResponse(
            isRunning = true,
            startedAt = auction.timerStartedAt,
            durationSeconds = auction.timerDurationSeconds,
            remainingSeconds = remaining,
            antiSnipeSeconds = antiSnipe
        )
    }

    @Transactional
    fun undoBid(auctionId: UUID, reason: String, actorId: UUID): PlayerAuctionState {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        val playerId = auction.currentLeaguePlayerId ?: throw BusinessLogicException("No player currently up for bidding", "error.no_player_up")
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId).get()

        if (playerState.state != PlayerAuctionStateValue.UP_FOR_BIDDING) throw BusinessLogicException("Undo bid is only valid when player is UP_FOR_BIDDING", "error.invalid_player_state")

        val lastBid = bidRepository.findFirstByLeaguePlayerIdAndAuctionIdAndStatusOrderByBidAtDesc(playerId, auctionId, BidStatus.ACTIVE)
            .orElseThrow { BusinessLogicException("No active bids to undo", "error.no_active_bids") }
        
        lastBid.status = BidStatus.UNDONE
        bidRepository.save(lastBid)
        
        val nextBid = bidRepository.findFirstByLeaguePlayerIdAndAuctionIdAndStatusOrderByBidAtDesc(playerId, auctionId, BidStatus.ACTIVE)
        val undoneAmount = lastBid.bidAmount
        val undoneFranchiseId = lastBid.franchiseId
        
        playerState.currentHighestBid = nextBid.map { it.bidAmount }.orElse(null)
        playerState.currentHighestBidderId = nextBid.map { it.franchiseId }.orElse(null)
        val savedState = playerStateRepository.save(playerState)
        
        logAndBroadcast(auctionId, AuctionAction.BID_UNDONE, mapOf(
            "leaguePlayerId" to playerId,
            "undoneBidId" to lastBid.id,
            "undoneAmount" to undoneAmount,
            "undoneFranchiseId" to undoneFranchiseId,
            "newHighestBid" to playerState.currentHighestBid,
            "newHighestBidder" to playerState.currentHighestBidderId,
            "reason" to reason
        ), actorId)
        
        return savedState
    }

    @Transactional
    fun sellPlayer(auctionId: UUID, leaguePlayerId: UUID, franchiseId: UUID, finalPrice: Int, actorId: UUID): PlayerAuctionState {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, leaguePlayerId).get()
        
        if (playerState.state != PlayerAuctionStateValue.UP_FOR_BIDDING) throw BusinessLogicException("Player is not in bidding state", "error.invalid_player_state")
        
        val roundId = auction.currentRoundId!!
        val purse = purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId) ?: throw ResourceNotFoundException("Franchise purse not found", "error.purse_not_found")
        
        if (purse.currentAmount < finalPrice) throw InsufficientPurseException("Insufficient purse amount")
        
        playerState.state = PlayerAuctionStateValue.SOLD
        playerState.finalPrice = finalPrice
        playerState.soldToFranchiseId = franchiseId
        playerStateRepository.save(playerState)
        playerSoldCounter.increment()
        
        purse.currentAmount -= finalPrice
        purseRepository.save(purse)
        
        val franchise = franchiseRepository.findById(franchiseId).get()
        franchise.remainingPurse -= finalPrice
        franchiseRepository.save(franchise)
        
        franchisePlayerRepository.save(FranchisePlayer(
            franchiseId = franchiseId,
            leaguePlayerId = leaguePlayerId,
            boughtPrice = finalPrice,
            roundId = roundId
        ))
        
        auction.currentLeaguePlayerId = null
        auction.timerStartedAt = null
        auction.timerDurationSeconds = null
        auctionRepository.save(auction)
        
        logAndBroadcast(auctionId, AuctionAction.TIMER_STOPPED, emptyMap(), actorId)
        logAndBroadcast(auctionId, AuctionAction.PLAYER_SOLD, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "franchiseId" to franchiseId,
            "finalPrice" to finalPrice,
            "roundId" to roundId
        ), actorId)

        // Notify sold player and franchise owner
        val lp = leaguePlayerRepository.findById(leaguePlayerId).get()
        notificationService.notifyPlayerSold(lp.userId, franchise.name, finalPrice)
        notificationService.notifyPlayerSold(franchise.ownerId, franchise.name, finalPrice)
        
        return playerState
    }

    @Transactional
    fun undoSold(auctionId: UUID, leaguePlayerId: UUID, reason: String, actorId: UUID): PlayerAuctionState {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        
        // Find last audit log entry
        val logs = auctionAuditLogRepository.findByAuctionIdOrderBySequenceNumberAsc(auctionId)
        val lastLog = logs.lastOrNull()
        
        if (lastLog == null || lastLog.action != AuctionAction.PLAYER_SOLD || lastLog.payload["leaguePlayerId"] != leaguePlayerId.toString()) {
            throw BusinessLogicException("Undo sold is only allowed if the absolute last action in the audit log was PLAYER_SOLD for this player", "error.undo_sold_not_last_action")
        }
        
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, leaguePlayerId).get()
        val revertedFromFranchiseId = playerState.soldToFranchiseId!!
        val restoredAmount = playerState.finalPrice!!
        
        playerState.state = PlayerAuctionStateValue.UP_FOR_BIDDING
        playerState.finalPrice = null
        playerState.soldToFranchiseId = null
        playerStateRepository.save(playerState)
        
        val roundId = auction.currentRoundId!!
        val purse = purseRepository.findByFranchiseIdAndRoundId(revertedFromFranchiseId, roundId)!!
        purse.currentAmount += restoredAmount
        purseRepository.save(purse)
        
        val franchise = franchiseRepository.findById(revertedFromFranchiseId).get()
        franchise.remainingPurse += restoredAmount
        franchiseRepository.save(franchise)
        
        franchisePlayerRepository.deleteByLeaguePlayerId(leaguePlayerId)
        
        auction.currentLeaguePlayerId = leaguePlayerId
        auctionRepository.save(auction)
        
        logAndBroadcast(auctionId, AuctionAction.SOLD_REVERTED, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "revertedFromFranchiseId" to revertedFromFranchiseId,
            "restoredAmount" to restoredAmount,
            "reason" to reason
        ), actorId)
        
        return playerState
    }

    @Transactional
    fun unsoldPlayer(auctionId: UUID, leaguePlayerId: UUID, actorId: UUID): PlayerAuctionState {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, leaguePlayerId).get()
        
        playerState.state = PlayerAuctionStateValue.UNSOLD
        playerStateRepository.save(playerState)
        
        auction.currentLeaguePlayerId = null
        auction.timerStartedAt = null
        auction.timerDurationSeconds = null
        auctionRepository.save(auction)
        
        logAndBroadcast(auctionId, AuctionAction.TIMER_STOPPED, emptyMap(), actorId)
        logAndBroadcast(auctionId, AuctionAction.PLAYER_UNSOLD, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "roundId" to auction.currentRoundId
        ), actorId)
        
        return playerState
    }

    @Transactional
    fun preAssign(auctionId: UUID, leaguePlayerId: UUID, franchiseId: UUID, assignmentType: String, price: Int, actorId: UUID): PlayerAuctionState {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, leaguePlayerId)
            .orElseThrow { ResourceNotFoundException("Player not found in auction pool", "error.player_not_found") }
        
        if (playerState.state != PlayerAuctionStateValue.AVAILABLE) {
            throw BusinessLogicException("Player must be AVAILABLE for pre-assignment", "error.invalid_player_state")
        }
        
        playerState.state = PlayerAuctionStateValue.PRE_ASSIGNED
        playerState.finalPrice = price
        playerState.soldToFranchiseId = franchiseId
        playerStateRepository.save(playerState)
        
        if (price > 0) {
            val roundId = auction.currentRoundId ?: throw BusinessLogicException("No active round to deduct purse from", "error.no_active_round")
            val purse = purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId)
                ?: throw ResourceNotFoundException("Franchise purse not found for this round", "error.purse_not_found")
            
            if (purse.currentAmount < price) {
                 throw InsufficientPurseException("Insufficient purse for pre-assignment")
            }
            purse.currentAmount -= price
            purseRepository.save(purse)
        }
        
        franchisePlayerRepository.save(FranchisePlayer(
            franchiseId = franchiseId,
            leaguePlayerId = leaguePlayerId,
            boughtPrice = price,
            roundId = auction.currentRoundId ?: throw BusinessLogicException("No active round for pre-assignment", "error.no_active_round")
        ))

        logAndBroadcast(auctionId, AuctionAction.PLAYER_PRE_ASSIGNED, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "franchiseId" to franchiseId,
            "price" to price,
            "assignmentType" to assignmentType,
            "assignedBy" to actorId
        ), actorId)
        
        return playerState
    }

    @Transactional
    fun forceAssign(auctionId: UUID, leaguePlayerId: UUID, franchiseId: UUID, price: Int, actorId: UUID): PlayerAuctionState {
        val auction = auctionRepository.findByIdWithLock(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, leaguePlayerId).get()
        
        if (playerState.state != PlayerAuctionStateValue.UNSOLD && playerState.state != PlayerAuctionStateValue.AVAILABLE) {
            throw BusinessLogicException("Player must be UNSOLD or AVAILABLE for force assignment", "error.invalid_player_state")
        }
        
        playerState.state = PlayerAuctionStateValue.FORCE_ASSIGNED
        playerState.finalPrice = price
        playerState.soldToFranchiseId = franchiseId
        playerStateRepository.save(playerState)
        
        if (price > 0) {
            val roundId = auction.currentRoundId ?: throw BusinessLogicException("No active round", "error.no_active_round")
            val purse = purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId)
            if (purse != null) {
                purse.currentAmount -= price
                purseRepository.save(purse)
            }

            val franchise = franchiseRepository.findById(franchiseId).get()
            franchise.remainingPurse -= price
            franchiseRepository.save(franchise)
        }
        
        franchisePlayerRepository.save(FranchisePlayer(
            franchiseId = franchiseId,
            leaguePlayerId = leaguePlayerId,
            boughtPrice = price,
            roundId = auction.currentRoundId ?: throw BusinessLogicException("No active round for force assignment", "error.no_active_round")
        ))
        
        logAndBroadcast(auctionId, AuctionAction.PLAYER_FORCE_ASSIGNED, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "franchiseId" to franchiseId,
            "price" to price,
            "assignedBy" to actorId
        ), actorId)
        
        return playerState
    }

    fun getAuction(auctionId: UUID) = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }

    fun getAuctionByToken(token: String) = auctionRepository.findByPublicViewToken(token) ?: throw ResourceNotFoundException("Auction not found", "error.auction_not_found")

    fun getRounds(auctionId: UUID): List<AuctionRoundConfig> {
        return roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId)
    }

    fun getRound(roundId: UUID): AuctionRoundConfig {
        return roundConfigRepository.findById(roundId).orElseThrow { ResourceNotFoundException("Round not found", "error.round_not_found") }
    }

    fun getStateSnapshot(auctionId: UUID): com.crichere.domain.auction.dto.AuctionStateSnapshot {
        val auction = getAuction(auctionId)
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
        
        return com.crichere.domain.auction.dto.AuctionStateSnapshot(
            leagueName = league.name,
            auctionStatus = auction.status,
            currentRound = round?.let { r -> com.crichere.domain.auction.dto.RoundConfigDto(
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
                    com.crichere.domain.auction.dto.BidIncrementSlabDto(s.fromAmount, s.toAmount, s.incrementBy)
                }
            )},
            currentPlayer = playerState?.let { p -> mapToStateResponse(p) },
            currentHighestBid = playerState?.currentHighestBid,
            currentHighestBidderId = playerState?.currentHighestBidderId,
            franchisePurseStates = purses.map { p -> com.crichere.domain.auction.dto.FranchisePurseStateResponse(
                p.id, p.franchiseId, p.roundId, p.currencyType, p.startingAmount, p.currentAmount, p.reservedAmount
            )},
            timer = getTimerState(auction),
            lastSequenceNumber = lastSeq
        )
    }

    fun mapToStateResponse(s: PlayerAuctionState): PlayerAuctionStateResponse {
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
            basePrice = leagueService.resolveBasePrice(lp),
            playerPhoto = user.profilePhoto
        )
    }

    @Transactional
    fun addRound(auctionId: UUID, roundDto: com.crichere.domain.auction.dto.RoundConfigDto): AuctionRoundConfig {
        val auction = getAuction(auctionId)
        if (auction.status != AuctionStatus.DRAFT) throw BusinessLogicException("Rounds can only be added to a DRAFT auction", "error.invalid_auction_status")
        
        val round = roundConfigRepository.save(AuctionRoundConfig(
            auctionId = auction.id,
            roundNumber = roundDto.roundNumber,
            name = roundDto.name,
            currencyType = roundDto.currencyType,
            purseAmount = roundDto.purseAmount,
            purseSource = roundDto.purseSource,
            bidMode = roundDto.bidMode,
            playerPoolSource = roundDto.playerPoolSource,
            franchiseEligibilityRule = roundDto.franchiseEligibilityRule,
            completionTrigger = roundDto.completionTrigger
        ))
        
        roundDto.bidIncrementSlabs.forEach { slabDto ->
            slabRepository.save(BidIncrementSlab(
                roundId = round.id,
                fromAmount = slabDto.fromAmount,
                toAmount = slabDto.toAmount,
                incrementBy = slabDto.incrementBy
            ))
        }
        return round
    }

    @Transactional
    fun updateRound(roundId: UUID, roundDto: com.crichere.domain.auction.dto.RoundConfigDto): AuctionRoundConfig {
        val round = roundConfigRepository.findById(roundId).orElseThrow { ResourceNotFoundException("Round not found", "error.round_not_found") }
        if (round.status != RoundStatus.PENDING) throw BusinessLogicException("Only PENDING rounds can be updated", "error.invalid_round_status")
        
        round.name = roundDto.name
        round.currencyType = roundDto.currencyType
        round.purseAmount = roundDto.purseAmount
        round.purseSource = roundDto.purseSource
        round.bidMode = roundDto.bidMode
        round.playerPoolSource = roundDto.playerPoolSource
        round.franchiseEligibilityRule = roundDto.franchiseEligibilityRule
        round.completionTrigger = roundDto.completionTrigger
        
        // Update slabs: simple approach, delete and recreate
        val existingSlabs = slabRepository.findByRoundIdOrderByFromAmountAsc(roundId)
        slabRepository.deleteAll(existingSlabs)
        roundDto.bidIncrementSlabs.forEach { slabDto ->
            slabRepository.save(BidIncrementSlab(
                roundId = round.id,
                fromAmount = slabDto.fromAmount,
                toAmount = slabDto.toAmount,
                incrementBy = slabDto.incrementBy
            ))
        }
        
        return roundConfigRepository.save(round)
    }

    @Transactional
    fun deleteRound(roundId: UUID) {
        val round = roundConfigRepository.findById(roundId).orElseThrow { ResourceNotFoundException("Round not found", "error.round_not_found") }
        if (round.status != RoundStatus.PENDING) throw BusinessLogicException("Only PENDING rounds can be deleted", "error.invalid_round_status")
        
        slabRepository.deleteAll(slabRepository.findByRoundIdOrderByFromAmountAsc(roundId))
        categoryIncrementRepository.deleteAll(categoryIncrementRepository.findByRoundId(roundId))
        roundConfigRepository.delete(round)
    }

    @Transactional
    fun completeRound(auctionId: UUID, roundId: UUID, actorId: UUID): AuctionRoundConfig {
        val round = roundConfigRepository.findById(roundId).orElseThrow { ResourceNotFoundException("Round not found", "error.round_not_found") }
        round.status = RoundStatus.COMPLETED
        round.completedAt = Instant.now()
        
        val playerStates = playerStateRepository.findByAuctionId(auctionId)
        // This is a bit simplified, but filters based on round would be better if we had roundId in PlayerAuctionState
        val soldCount = playerStates.count { it.state == PlayerAuctionStateValue.SOLD }
        val unsoldCount = playerStates.count { it.state == PlayerAuctionStateValue.UNSOLD }
        
        val savedRound = roundConfigRepository.save(round)
        logAndBroadcast(auctionId, AuctionAction.ROUND_COMPLETED, mapOf(
            "roundId" to roundId,
            "soldCount" to soldCount,
            "unsoldCount" to unsoldCount
        ), actorId)
        return savedRound
    }

    fun getPlayerPool(auctionId: UUID, roundId: UUID): List<PlayerAuctionState> {
        val round = roundConfigRepository.findById(roundId).orElseThrow { ResourceNotFoundException("Round not found", "error.round_not_found") }
        val playerStates = playerStateRepository.findByAuctionId(auctionId)
        
        return when (round.playerPoolSource) {
            PlayerPoolSource.ALL_REGISTERED -> playerStates.filter { it.state == PlayerAuctionStateValue.AVAILABLE }
            PlayerPoolSource.UNSOLD_PREVIOUS_ROUND -> {
                 // Logic to only pick unsold from the immediately preceding round
                 val prevRounds = roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId)
                 val currentIndex = prevRounds.indexOfFirst { it.id == roundId }
                 if (currentIndex > 0) {
                     val prevRoundId = prevRounds[currentIndex - 1].id
                     // Assuming for now it filters all unsold if we don't have per-round state.
                     playerStates.filter { it.state == PlayerAuctionStateValue.UNSOLD }
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
    }

    @Transactional
    fun updatePlayerPool(roundId: UUID, playerIds: List<UUID>) {
        val round = roundConfigRepository.findById(roundId).orElseThrow { ResourceNotFoundException("Round not found", "error.round_not_found") }
        if (round.status != RoundStatus.PENDING) throw BusinessLogicException("Can only update pool for PENDING rounds", "error.invalid_round_status")
        
        poolPlayerRepository.deleteByRoundId(roundId)
        val entities = playerIds.map { AuctionRoundPoolPlayer(roundId = roundId, leaguePlayerId = it) }
        poolPlayerRepository.saveAll(entities)
    }

    @Transactional
    fun withdrawPlayer(auctionId: UUID, leaguePlayerId: UUID, reason: String, actorId: UUID): PlayerAuctionState {
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, leaguePlayerId)
            .orElseThrow { ResourceNotFoundException("Player not found in auction pool", "error.player_not_found") }
        
        if (playerState.state != PlayerAuctionStateValue.UP_FOR_BIDDING && playerState.state != PlayerAuctionStateValue.AVAILABLE) {
            throw BusinessLogicException("Player must be UP_FOR_BIDDING or AVAILABLE to withdraw", "error.invalid_player_state")
        }
        
        playerState.state = PlayerAuctionStateValue.WITHDRAWN
        val savedState = playerStateRepository.save(playerState)
        
        val auction = getAuction(auctionId)
        if (auction.currentLeaguePlayerId == leaguePlayerId) {
            auction.currentLeaguePlayerId = null
            auction.timerStartedAt = null
            auction.timerDurationSeconds = null
            auctionRepository.save(auction)
            logAndBroadcast(auctionId, AuctionAction.TIMER_STOPPED, emptyMap(), actorId)
        }
        
        logAndBroadcast(auctionId, AuctionAction.PLAYER_WITHDRAWN, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "reason" to reason,
            "roundId" to auction.currentRoundId
        ), actorId)
        
        return savedState
    }

    fun getBidHistory(auctionId: UUID, leaguePlayerId: UUID): List<Bid> {
        return bidRepository.findByLeaguePlayerIdAndAuctionIdOrderByBidAtDesc(leaguePlayerId, auctionId)
    }

    fun getDetailedAuctionSummary(auctionId: UUID): com.crichere.domain.auction.dto.AuctionSummaryResponse {
        val auction = getAuction(auctionId)
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
            com.crichere.domain.auction.dto.FranchiseSummary(
                f.id, f.name, fPlayers.size, fPlayers.sumOf { it.boughtPrice.toLong() }, 
                purse?.currentAmount ?: f.remainingPurse,
                fPlayers.map { fp -> 
                    val lp = leaguePlayerRepository.findById(fp.leaguePlayerId).get()
                    val pState = playerStates.find { it.leaguePlayerId == fp.leaguePlayerId }
                    val round = rounds.find { it.id == fp.roundId }
                    com.crichere.domain.auction.dto.AuctionPlayerSummary(
                        playerName = userRepository.findById(lp.userId).get().name ?: "Unknown",
                        playerCategory = lp.category,
                        finalPrice = fp.boughtPrice,
                        assignmentType = pState?.state?.name ?: "SOLD",
                        roundNumber = round?.roundNumber ?: 1
                    )
                }
            )
        }
        
        return com.crichere.domain.auction.dto.AuctionSummaryResponse(
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
                com.crichere.domain.auction.dto.SaleSummary(
                    userRepository.findById(leaguePlayerRepository.findById(s.leaguePlayerId).get().userId).get().name ?: "Unknown",
                    franchiseRepository.findById(s.soldToFranchiseId!!).get().name,
                    s.finalPrice!!
                )
            },
            franchiseSummaries = franchiseSummaries
        )
    }

    fun getFranchiseDetailedSummary(auctionId: UUID, franchiseId: UUID): com.crichere.domain.auction.dto.FranchiseDetailedSummaryResponse {
        val franchise = franchiseRepository.findById(franchiseId).orElseThrow { ResourceNotFoundException("Franchise not found", "error.franchise_not_found") }
        val fPlayers = franchisePlayerRepository.findByFranchiseId(franchiseId)
        val rounds = roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId)
        val auction = getAuction(auctionId)
        val currentRoundId = auction.currentRoundId ?: rounds.lastOrNull()?.id
        val purse = if (currentRoundId != null) purseRepository.findByFranchiseIdAndRoundId(franchiseId, currentRoundId) else null
        
        val playerSummaries = fPlayers.map { fp ->
            val lp = leaguePlayerRepository.findById(fp.leaguePlayerId).get()
            val pState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, fp.leaguePlayerId).orElse(null)
            val round = rounds.find { it.id == fp.roundId }
            com.crichere.domain.auction.dto.AuctionPlayerSummary(
                playerName = userRepository.findById(lp.userId).get().name ?: "Unknown",
                playerCategory = lp.category,
                finalPrice = fp.boughtPrice,
                assignmentType = pState?.state?.name ?: "SOLD",
                roundNumber = round?.roundNumber ?: 1
            )
        }

        val categoryBreakdown = playerSummaries.groupBy { it.playerCategory ?: "Unknown" }.map { (cat, list) ->
            com.crichere.domain.auction.dto.CategoryBreakdown(cat, list.size, list.sumOf { (it.finalPrice ?: 0).toLong() })
        }

        return com.crichere.domain.auction.dto.FranchiseDetailedSummaryResponse(
            franchiseId = franchise.id,
            franchiseName = franchise.name,
            squadCount = fPlayers.size,
            totalSpent = fPlayers.sumOf { it.boughtPrice.toLong() },
            remainingPurse = purse?.currentAmount ?: franchise.remainingPurse,
            categoryBreakdown = categoryBreakdown,
            players = playerSummaries
        )
    }

    fun getUnsoldPlayers(auctionId: UUID, pageable: org.springframework.data.domain.Pageable): com.crichere.domain.auction.dto.UnsoldPlayersResponse {
        val unsoldPage = playerStateRepository.findByAuctionIdAndState(auctionId, PlayerAuctionStateValue.UNSOLD, pageable)
        
        val summaries = unsoldPage.content.map { s ->
            val lp = leaguePlayerRepository.findById(s.leaguePlayerId).get()
            com.crichere.domain.auction.dto.AuctionPlayerSummary(
                playerName = userRepository.findById(lp.userId).get().name ?: "Unknown",
                playerCategory = lp.category,
                finalPrice = null,
                assignmentType = null,
                roundNumber = null
            )
        }

        return com.crichere.domain.auction.dto.UnsoldPlayersResponse(
            players = summaries,
            totalElements = unsoldPage.totalElements,
            totalPages = unsoldPage.totalPages,
            pageNumber = unsoldPage.number,
            pageSize = unsoldPage.size
        )
    }

    @Transactional
    fun deleteAuction(auctionId: UUID) {
        val auction = getAuction(auctionId)
        if (auction.status != AuctionStatus.DRAFT) throw BusinessLogicException("Only DRAFT auctions can be deleted", "error.auction_already_started")
        
        val rounds = roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId)
        rounds.forEach { r ->
            slabRepository.deleteAll(slabRepository.findByRoundIdOrderByFromAmountAsc(r.id))
        }
        roundConfigRepository.deleteAll(rounds)
        auctionRepository.delete(auction)
    }

    @Transactional
    fun regeneratePublicViewToken(auctionId: UUID): Auction {
        val auction = getAuction(auctionId)
        auction.publicViewToken = Auction.generateSecureToken()
        return auctionRepository.save(auction)
    }

    @Transactional
    fun logAndBroadcast(auctionId: UUID, action: AuctionAction, payload: Map<String, Any?>, actorId: UUID?) {
        val maxSeq = auctionAuditLogRepository.findMaxSequenceNumberByAuctionId(auctionId)
        val auditLog = auctionAuditLogRepository.save(AuctionAuditLog(
            auctionId = auctionId,
            sequenceNumber = maxSeq + 1,
            action = action,
            payload = payload,
            actorId = actorId
        ))
        
        val event = mapOf(
            "id" to auditLog.sequenceNumber,
            "event" to action.name,
            "data" to payload
        )
        val json = objectMapper.writeValueAsString(event)
        
        if (org.springframework.transaction.support.TransactionSynchronizationManager.isActualTransactionActive()) {
            org.springframework.transaction.support.TransactionSynchronizationManager.registerSynchronization(
                object : org.springframework.transaction.support.TransactionSynchronization {
                    override fun afterCommit() {
                        redisTemplate.convertAndSend("auction:$auctionId", json)
                    }
                }
            )
        } else {
            redisTemplate.convertAndSend("auction:$auctionId", json)
        }
    }

    fun getAuditLogs(auctionId: UUID, fromSequence: Long?) = if (fromSequence != null) {
        auctionAuditLogRepository.findByAuctionIdAndSequenceNumberGreaterThanOrderBySequenceNumberAsc(auctionId, fromSequence)
    } else {
        auctionAuditLogRepository.findByAuctionIdOrderBySequenceNumberAsc(auctionId)
    }
}
