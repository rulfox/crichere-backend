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
    private val redisTemplate: StringRedisTemplate,
    private val objectMapper: ObjectMapper
) {

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
        logAndBroadcast(auction.id, AuctionAction.AUCTION_STARTED, mapOf("startedAt" to auction.startedAt), actorId)
        return savedAuction
    }

    @Transactional
    fun pauseAuction(auctionId: UUID, reason: String?, actorId: UUID): Auction {
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        auction.status = AuctionStatus.PAUSED
        val savedAuction = auctionRepository.save(auction)
        logAndBroadcast(auction.id, AuctionAction.AUCTION_PAUSED, mapOf("reason" to reason), actorId)
        return savedAuction
    }

    @Transactional
    fun resumeAuction(auctionId: UUID, actorId: UUID): Auction {
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        auction.status = AuctionStatus.LIVE
        val savedAuction = auctionRepository.save(auction)
        logAndBroadcast(auction.id, AuctionAction.AUCTION_RESUMED, emptyMap(), actorId)
        return savedAuction
    }

    @Transactional
    fun completeAuction(auctionId: UUID, actorId: UUID): Auction {
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        auction.status = AuctionStatus.COMPLETED
        auction.completedAt = Instant.now()
        
        val playerStates = playerStateRepository.findByAuctionId(auction.id)
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
        val roundId = auction.currentRoundId ?: throw BusinessLogicException("No active round", "error.no_active_round")
        
        val playerId = if (leaguePlayerId == null) {
            // Randomly select AVAILABLE player
            val availablePlayers = playerStateRepository.findByAuctionId(auctionId).filter { it.state == PlayerAuctionStateValue.AVAILABLE }
            if (availablePlayers.isEmpty()) throw BusinessLogicException("No available players in pool", "error.empty_pool")
            availablePlayers.random().leaguePlayerId
        } else {
            leaguePlayerId
        }
        
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId)
            .orElseThrow { ResourceNotFoundException("Player not found in auction pool", "error.player_not_found") }
        
        if (playerState.state != PlayerAuctionStateValue.AVAILABLE) throw BusinessLogicException("Player is not AVAILABLE", "error.invalid_player_state")
        
        playerState.state = PlayerAuctionStateValue.UP_FOR_BIDDING
        playerState.currentHighestBid = null
        playerState.currentHighestBidderId = null
        
        auction.currentLeaguePlayerId = playerId
        auctionRepository.save(auction)
        
        val savedState = playerStateRepository.save(playerState)
        val player = leaguePlayerRepository.findById(playerId).get()
        logAndBroadcast(auctionId, AuctionAction.PLAYER_UP, mapOf(
            "leaguePlayerId" to playerId,
            "playerName" to player.userId.toString(), // This should probably be the user name, but we have user_id here. 
            "basePrice" to player.basePrice,
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
        if (currentBid == null) {
            if (bidAmount < player.basePrice) throw BusinessLogicException("Bid must be at least base price", "error.invalid_bid_amount")
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
        
        return playerState
    }

    @Transactional
    fun undoSold(auctionId: UUID, leaguePlayerId: UUID, reason: String, actorId: UUID): PlayerAuctionState {
        val auction = auctionRepository.findById(auctionId).orElseThrow { ResourceNotFoundException("Auction not found", "error.auction_not_found") }
        
        // Find last audit log entry for this player
        val logs = auctionAuditLogRepository.findByAuctionIdOrderBySequenceNumberAsc(auctionId)
        val lastLog = logs.lastOrNull { it.payload["leaguePlayerId"] == leaguePlayerId.toString() }
        
        if (lastLog == null || lastLog.action != AuctionAction.PLAYER_SOLD) {
            throw BusinessLogicException("Undo sold is only allowed if the last action for this player was PLAYER_SOLD", "error.undo_sold_not_last_action")
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
            roundId = auction.currentRoundId ?: UUID.randomUUID() // Should handle null better
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

    fun getAuctionSummary(auctionId: UUID): com.crichere.domain.auction.dto.AuctionSummaryResponse {
        val auction = getAuction(auctionId)
        if (auction.status != AuctionStatus.COMPLETED) throw BusinessLogicException("Summary only available for COMPLETED auctions", "error.invalid_auction_status")
        
        val playerStates = playerStateRepository.findByAuctionId(auctionId)
        val franchises = franchiseRepository.findByLeagueId(auction.leagueId)
        
        val soldPlayers = playerStates.filter { it.state == PlayerAuctionStateValue.SOLD || it.state == PlayerAuctionStateValue.FORCE_ASSIGNED }
        val highestSaleState = soldPlayers.maxByOrNull { it.finalPrice ?: 0 }
        
        val franchiseSummaries = franchises.map { f ->
            val fPlayers = franchisePlayerRepository.findByFranchiseId(f.id)
            com.crichere.domain.auction.dto.FranchiseSummary(
                f.id, f.name, fPlayers.size, fPlayers.sumOf { it.boughtPrice.toLong() }, 
                purseRepository.findByAuctionId(auctionId).find { it.franchiseId == f.id }?.currentAmount ?: 0
            )
        }
        
        return com.crichere.domain.auction.dto.AuctionSummaryResponse(
            totalPlayers = playerStates.size,
            totalSold = soldPlayers.size,
            totalUnsold = playerStates.count { it.state == PlayerAuctionStateValue.UNSOLD },
            totalWithdrawn = playerStates.count { it.state == PlayerAuctionStateValue.WITHDRAWN },
            totalSpent = soldPlayers.sumOf { (it.finalPrice ?: 0).toLong() },
            highestSale = highestSaleState?.let { s -> 
                com.crichere.domain.auction.dto.SaleSummary(
                    leaguePlayerRepository.findById(s.leaguePlayerId).get().userId.toString(), // Mocked name
                    franchiseRepository.findById(s.soldToFranchiseId!!).get().name,
                    s.finalPrice!!
                )
            },
            franchiseSummaries = franchiseSummaries
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
