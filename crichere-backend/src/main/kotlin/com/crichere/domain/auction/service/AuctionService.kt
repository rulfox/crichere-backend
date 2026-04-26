package com.crichere.domain.auction.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.InsufficientPurseException
import com.crichere.common.exception.ResourceNotFoundException
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
    private val bidRepository: BidRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val purseRepository: FranchisePurseStateRepository,
    private val franchiseRepository: FranchiseRepository,
    private val franchisePlayerRepository: FranchisePlayerRepository,
    private val auctionAuditLogRepository: AuctionAuditLogRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val userRepository: com.crichere.domain.auth.repository.UserRepository,
    private val leagueRepository: com.crichere.domain.league.repository.LeagueRepository,
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
        }
        
        return auction
    }

    @Transactional
    fun startAuction(auctionId: UUID, actorId: UUID): Auction {
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        if (auction.status != AuctionStatus.DRAFT) throw BusinessLogicException("Auction must be in DRAFT status to start", "error.invalid_auction_status")
        
        auction.status = AuctionStatus.LIVE
        auction.startedAt = Instant.now()
        
        // Initialize PlayerAuctionStates
        val players = leaguePlayerRepository.findByLeagueId(auction.leagueId)
        players.forEach { player ->
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
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        if (auction.status != AuctionStatus.LIVE) throw BusinessLogicException("Auction must be LIVE to pause", "error.invalid_auction_status")
        auction.status = AuctionStatus.PAUSED
        val savedAuction = auctionRepository.save(auction)
        logAndBroadcast(auction.id, AuctionAction.AUCTION_PAUSED, mapOf("reason" to reason), actorId)
        return savedAuction
    }

    @Transactional
    fun resumeAuction(auctionId: UUID, actorId: UUID): Auction {
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        if (auction.status != AuctionStatus.PAUSED) throw BusinessLogicException("Auction must be PAUSED to resume", "error.invalid_auction_status")
        auction.status = AuctionStatus.LIVE
        val savedAuction = auctionRepository.save(auction)
        logAndBroadcast(auction.id, AuctionAction.AUCTION_RESUMED, emptyMap(), actorId)
        return savedAuction
    }

    @Transactional
    fun completeAuction(auctionId: UUID, actorId: UUID): Auction {
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
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
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        
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
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        val league = leagueRepository.findById(auction.leagueId).get()
        val roundId = auction.currentRoundId ?: throw BusinessLogicException("No active round", "error.no_active_round")
        
        val playerId = when (league.playerOrderMode) {
            com.crichere.domain.league.enums.PlayerOrderMode.RANDOM -> {
                if (leaguePlayerId != null) throw BusinessLogicException("Manual selection not allowed in RANDOM mode", "error.manual_selection_disabled")
                val availablePlayers = playerStateRepository.findByAuctionId(auctionId).filter { it.state == PlayerAuctionStateValue.AVAILABLE }
                if (availablePlayers.isEmpty()) throw BusinessLogicException("No available players in pool", "error.empty_pool")
                availablePlayers.random().leaguePlayerId
            }
            com.crichere.domain.league.enums.PlayerOrderMode.FREE_PICK -> {
                leaguePlayerId ?: throw BusinessLogicException("Player selection required in FREE_PICK mode", "error.player_selection_required")
            }
            com.crichere.domain.league.enums.PlayerOrderMode.HYBRID -> {
                leaguePlayerId ?: run {
                    val availablePlayers = playerStateRepository.findByAuctionId(auctionId).filter { it.state == PlayerAuctionStateValue.AVAILABLE }
                    if (availablePlayers.isEmpty()) throw BusinessLogicException("No available players in pool", "error.empty_pool")
                    availablePlayers.random().leaguePlayerId
                }
            }
        }
        
        val player = leaguePlayerRepository.findById(playerId).get()
        if (!player.auctionEligible) throw BusinessLogicException("Player is not eligible for auction", "error.player_not_eligible")

        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId)
            .orElseThrow { ResourceNotFoundException("Player not found in auction pool", "error.player_not_found") }

        if (playerState.state != PlayerAuctionStateValue.AVAILABLE) throw BusinessLogicException("Player is not AVAILABLE", "error.invalid_player_state")

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
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        val playerId = auction.currentLeaguePlayerId ?: throw BusinessLogicException("No player currently up for bidding", "error.no_player_up")
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId).get()
        
        if (playerState.state != PlayerAuctionStateValue.UP_FOR_BIDDING) throw BusinessLogicException("Player is not in bidding state", "error.invalid_player_state")
        
        val roundId = auction.currentRoundId!!
        val purse = purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId) ?: throw ResourceNotFoundException("Franchise purse not found for this round", "error.purse_not_found")
        
        if (purse.currentAmount < bidAmount) throw InsufficientPurseException("Insufficient purse amount")
        
        val currentBid = playerState.currentHighestBid
        val player = leaguePlayerRepository.findById(playerId).get()
        val basePrice = leagueService.resolveBasePrice(player)
        if (currentBid == null) {
            if (bidAmount < basePrice) throw BusinessLogicException("Bid must be at least base price", "error.invalid_bid_amount")
        } else {
            if (bidAmount <= currentBid) throw BusinessLogicException("Bid must be higher than current highest bid", "error.invalid_bid_amount")
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
        
        return bid
    }

    @Transactional
    fun undoBid(auctionId: UUID, reason: String, actorId: UUID): PlayerAuctionState {
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        val playerId = auction.currentLeaguePlayerId ?: throw BusinessLogicException("No player currently up for bidding", "error.no_player_up")
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId).get()

        if (playerState.state != PlayerAuctionStateValue.UP_FOR_BIDDING) throw BusinessLogicException("Undo bid is only valid when player is UP_FOR_BIDDING", "error.invalid_player_state")

        val lastBid = bidRepository.findFirstByLeaguePlayerIdAndStatusOrderByBidAtDesc(playerId, BidStatus.ACTIVE)
            .orElseThrow { BusinessLogicException("No active bids to undo", "error.no_active_bids") }
        
        lastBid.status = BidStatus.UNDONE
        bidRepository.save(lastBid)
        
        val nextBid = bidRepository.findFirstByLeaguePlayerIdAndStatusOrderByBidAtDesc(playerId, BidStatus.ACTIVE)
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
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
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
        
        franchisePlayerRepository.save(FranchisePlayer(
            franchiseId = franchiseId,
            leaguePlayerId = leaguePlayerId,
            boughtPrice = finalPrice,
            roundId = roundId
        ))
        
        auction.currentLeaguePlayerId = null
        auctionRepository.save(auction)
        
        logAndBroadcast(auctionId, AuctionAction.PLAYER_SOLD, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "franchiseId" to franchiseId,
            "finalPrice" to finalPrice,
            "roundId" to roundId
        ), actorId)

        // Notify sold player and franchise owner
        val lp = leaguePlayerRepository.findById(leaguePlayerId).get()
        val franchise = franchiseRepository.findById(franchiseId).get()
        notificationService.notifyPlayerSold(lp.userId, franchise.name, finalPrice)
        notificationService.notifyPlayerSold(franchise.ownerId, franchise.name, finalPrice)
        
        return playerState
    }

    @Transactional
    fun undoSold(auctionId: UUID, leaguePlayerId: UUID, reason: String, actorId: UUID): PlayerAuctionState {
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        
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
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, leaguePlayerId).get()
        
        playerState.state = PlayerAuctionStateValue.UNSOLD
        playerStateRepository.save(playerState)
        
        auction.currentLeaguePlayerId = null
        auctionRepository.save(auction)
        
        logAndBroadcast(auctionId, AuctionAction.PLAYER_UNSOLD, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "roundId" to auction.currentRoundId
        ), actorId)
        
        return playerState
    }

    @Transactional
    fun preAssign(auctionId: UUID, leaguePlayerId: UUID, franchiseId: UUID, assignmentType: String, price: Int, actorId: UUID): PlayerAuctionState {
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
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
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
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

    fun getStateSnapshot(auctionId: UUID): com.crichere.domain.auction.dto.AuctionStateSnapshot {
        val auction = getAuction(auctionId)
        val round = auction.currentRoundId?.let { roundConfigRepository.findById(it).orElse(null) }
        val playerState = auction.currentLeaguePlayerId?.let { playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, it).orElse(null) }
        val purses = purseRepository.findByAuctionId(auctionId)
        val lastSeq = auctionAuditLogRepository.findMaxSequenceNumberByAuctionId(auctionId)
        
        return com.crichere.domain.auction.dto.AuctionStateSnapshot(
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
            currentPlayer = playerState?.let { p -> com.crichere.domain.auction.dto.PlayerAuctionStateResponse(
                p.id, p.auctionId, p.leaguePlayerId, p.state, p.currentHighestBid, p.currentHighestBidderId, p.finalPrice, p.soldToFranchiseId
            )},
            currentHighestBid = playerState?.currentHighestBid,
            currentHighestBidderId = playerState?.currentHighestBidderId,
            franchisePurseStates = purses.map { p -> com.crichere.domain.auction.dto.FranchisePurseStateResponse(
                p.id, p.franchiseId, p.roundId, p.currencyType, p.startingAmount, p.currentAmount, p.reservedAmount
            )},
            lastSequenceNumber = lastSeq
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
        
        return playerStates.filter { it.state == PlayerAuctionStateValue.AVAILABLE }
        // TODO: Apply round.playerPoolSource filters if necessary
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
            auctionRepository.save(auction)
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
        
        val soldPlayers = playerStates.filter { it.state == PlayerAuctionStateValue.SOLD || it.state == PlayerAuctionStateValue.FORCE_ASSIGNED }
        val highestSaleState = soldPlayers.maxByOrNull { it.finalPrice ?: 0 }
        
        val franchiseSummaries = franchises.map { f ->
            val fPlayers = franchisePlayerRepository.findByFranchiseId(f.id)
            com.crichere.domain.auction.dto.FranchiseSummary(
                f.id, f.name, fPlayers.size, fPlayers.sumOf { it.boughtPrice.toLong() }, 
                purseRepository.findByAuctionId(auctionId).find { it.franchiseId == f.id }?.currentAmount ?: 0,
                fPlayers.map { fp -> 
                    val lp = leaguePlayerRepository.findById(fp.leaguePlayerId).get()
                    com.crichere.domain.auction.dto.AuctionPlayerSummary(
                        playerName = userRepository.findById(lp.userId).get().name ?: "Unknown",
                        playerCategory = lp.category,
                        finalPrice = fp.boughtPrice,
                        assignmentType = "SOLD", // Should be derived from state
                        roundNumber = 1 // Should be derived from fp.roundId
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
        val purse = purseRepository.findByAuctionId(auctionId).find { it.franchiseId == franchiseId }
        
        val playerSummaries = fPlayers.map { fp ->
            val lp = leaguePlayerRepository.findById(fp.leaguePlayerId).get()
            com.crichere.domain.auction.dto.AuctionPlayerSummary(
                playerName = userRepository.findById(lp.userId).get().name ?: "Unknown",
                playerCategory = lp.category,
                finalPrice = fp.boughtPrice,
                assignmentType = "SOLD",
                roundNumber = 1
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
            remainingPurse = purse?.currentAmount ?: 0,
            categoryBreakdown = categoryBreakdown,
            players = playerSummaries
        )
    }

    fun getUnsoldPlayers(auctionId: UUID, pageable: org.springframework.data.domain.Pageable): com.crichere.domain.auction.dto.UnsoldPlayersResponse {
        val allStates = playerStateRepository.findByAuctionId(auctionId)
        val unsold = allStates.filter { it.state == PlayerAuctionStateValue.UNSOLD }
        
        val start = pageable.offset.toInt()
        val end = (start + pageable.pageSize).coerceAtMost(unsold.size)
        val paginated = if (start < unsold.size) unsold.subList(start, end) else emptyList()

        val summaries = paginated.map { s ->
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
            totalElements = unsold.size.toLong(),
            totalPages = if (pageable.pageSize > 0) (unsold.size + pageable.pageSize - 1) / pageable.pageSize else 0,
            pageNumber = pageable.pageNumber,
            pageSize = pageable.pageSize
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
        redisTemplate.convertAndSend("auction:$auctionId", json)
    }

    fun getAuditLogs(auctionId: UUID, fromSequence: Long?) = if (fromSequence != null) {
        auctionAuditLogRepository.findByAuctionIdAndSequenceNumberGreaterThanOrderBySequenceNumberAsc(auctionId, fromSequence)
    } else {
        auctionAuditLogRepository.findByAuctionIdOrderBySequenceNumberAsc(auctionId)
    }
}
