package com.crichere.domain.auction.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.auction.entity.Bid
import com.crichere.domain.auction.entity.PlayerAuctionState
import com.crichere.domain.auction.enums.AuctionAction
import com.crichere.domain.auction.enums.BidStatus
import com.crichere.domain.auction.enums.PlayerAuctionStateValue
import com.crichere.domain.auction.enums.PlayerPoolSource
import com.crichere.domain.auction.error.AuctionDomainError
import com.crichere.domain.auction.event.PlayerSoldApplicationEvent
import com.crichere.domain.auction.publisher.AuctionEventPublisher
import com.crichere.domain.auction.repository.*
import com.crichere.domain.auction.entity.FranchisePlayer
import com.crichere.domain.auction.repository.FranchisePlayerRepository
import com.crichere.domain.franchise.repository.FranchisePurseStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.enums.PlayerOrderMode
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.player.repository.LeaguePlayerRepository
import com.crichere.domain.auth.repository.UserRepository
import io.micrometer.core.instrument.MeterRegistry
import org.springframework.context.ApplicationEventPublisher
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Duration
import java.time.Instant
import java.util.UUID

interface PutPlayerUseCase {
    fun execute(auctionId: UUID, leaguePlayerId: UUID?, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError>
}

@Service
class PutPlayerUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val leagueRepository: LeagueRepository,
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val userRepository: UserRepository,
    private val eventPublisher: AuctionEventPublisher,
    private val resolveBasePriceQuery: com.crichere.domain.league.usecase.ResolveBasePriceQuery
) : PutPlayerUseCase {
    @Transactional
    override fun execute(auctionId: UUID, leaguePlayerId: UUID?, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        val league = leagueRepository.findById(auction.leagueId).get()
        val roundId = auction.currentRoundId ?: return Result.Failure(AuctionDomainError.NoActiveRound)
        val round = roundConfigRepository.findById(roundId).get()

        val availablePlayers = when (round.playerPoolSource) {
            PlayerPoolSource.ALL_REGISTERED -> playerStateRepository.findByAuctionId(auctionId).filter { it.state == PlayerAuctionStateValue.AVAILABLE }
            PlayerPoolSource.UNSOLD_PREVIOUS_ROUND, PlayerPoolSource.UNSOLD_ANY_PREVIOUS_ROUND -> 
                playerStateRepository.findByAuctionId(auctionId).filter { it.state == PlayerAuctionStateValue.UNSOLD }
            PlayerPoolSource.AUCTIONEER_CURATED -> playerStateRepository.findByAuctionId(auctionId).filter { it.state == PlayerAuctionStateValue.AVAILABLE }
        }
        
        val playerId = when (league.playerOrderMode) {
            PlayerOrderMode.RANDOM -> {
                if (leaguePlayerId != null) return Result.Failure(AuctionDomainError.ManualSelectionDisabled)
                if (availablePlayers.isEmpty()) return Result.Failure(AuctionDomainError.EmptyPool)
                availablePlayers.random().leaguePlayerId
            }
            PlayerOrderMode.FREE_PICK -> {
                leaguePlayerId ?: return Result.Failure(AuctionDomainError.PlayerSelectionRequired)
            }
            PlayerOrderMode.HYBRID -> {
                leaguePlayerId ?: run {
                    if (availablePlayers.isEmpty()) return Result.Failure(AuctionDomainError.EmptyPool)
                    availablePlayers.random().leaguePlayerId
                }
            }
        }
        
        val player = leaguePlayerRepository.findById(playerId).get()
        if (!player.auctionEligible) return Result.Failure(AuctionDomainError.PlayerNotEligible)

        val stateOpt = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId)
        if (stateOpt.isEmpty) return Result.Failure(AuctionDomainError.PlayerNotFoundInPool)
        val playerState = stateOpt.get()

        if (playerState.state != PlayerAuctionStateValue.AVAILABLE && playerState.state != PlayerAuctionStateValue.UNSOLD) {
            return Result.Failure(AuctionDomainError.InvalidPlayerState)
        }

        playerState.state = PlayerAuctionStateValue.UP_FOR_BIDDING
        playerState.roundId = roundId
        playerState.currentHighestBid = null
        playerState.currentHighestBidderId = null

        auction.currentLeaguePlayerId = playerId
        auctionRepository.save(auction)
        
        val savedState = playerStateRepository.save(playerState)
        val user = userRepository.findById(player.userId).get()
        val basePrice = resolveBasePriceQuery.execute(player)
        
        eventPublisher.publish(auctionId, AuctionAction.PLAYER_UP, mapOf(
            "leaguePlayerId" to playerId,
            "playerName" to (user.name ?: "Unknown"), 
            "basePrice" to basePrice,
            "roundId" to roundId
        ), actorId)
        
        return Result.Success(savedState)
    }
}

interface PlaceBidUseCase {
    fun execute(auctionId: UUID, franchiseId: UUID, bidAmount: Int, actorId: UUID): Result<Bid, AuctionDomainError>
}

@Service
class PlaceBidUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val purseRepository: FranchisePurseStateRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val bidRepository: BidRepository,
    private val categoryIncrementRepository: AuctionRoundCategoryIncrementRepository,
    private val slabRepository: BidIncrementSlabRepository,
    private val eventPublisher: AuctionEventPublisher,
    private val resolveBasePriceQuery: com.crichere.domain.league.usecase.ResolveBasePriceQuery,
    private val meterRegistry: MeterRegistry
) : PlaceBidUseCase {
    private val bidPlacedCounter = meterRegistry.counter("crichere.auction.bids.placed")

    @Transactional
    override fun execute(auctionId: UUID, franchiseId: UUID, bidAmount: Int, actorId: UUID): Result<Bid, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        val playerId = auction.currentLeaguePlayerId ?: return Result.Failure(AuctionDomainError.NoPlayerUp)
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId).get()
        
        if (playerState.state != PlayerAuctionStateValue.UP_FOR_BIDDING) return Result.Failure(AuctionDomainError.InvalidPlayerState)
        
        val roundId = auction.currentRoundId!!
        val purse = purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId) 
            ?: return Result.Failure(AuctionDomainError.PurseNotFound)
        
        if (purse.currentAmount < bidAmount) return Result.Failure(AuctionDomainError.InsufficientPurse)
        
        val currentBid = playerState.currentHighestBid
        val player = leaguePlayerRepository.findById(playerId).get()
        val basePrice = resolveBasePriceQuery.execute(player)

        val minIncrement = resolveBidIncrement(roundId, player, currentBid ?: 0)

        if (currentBid == null) {
            if (bidAmount < basePrice) return Result.Failure(AuctionDomainError.InvalidBidAmount("Bid must be at least base price"))
        } else {
            if (bidAmount < currentBid + minIncrement) return Result.Failure(AuctionDomainError.InvalidBidAmount("Bid must be at least current highest bid + increment ($minIncrement)"))
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
        
        eventPublisher.publish(auctionId, AuctionAction.BID_PLACED, mapOf(
            "leaguePlayerId" to playerId,
            "franchiseId" to franchiseId,
            "bidAmount" to bidAmount,
            "previousHighestBid" to prevBid,
            "previousHighestBidder" to prevBidder
        ), actorId)

        // Anti-snipe logic
        if (auction.timerStartedAt != null && auction.timerDurationSeconds != null) {
            val now = Instant.now()
            val elapsed = Duration.between(auction.timerStartedAt, now).seconds
            val remaining = auction.timerDurationSeconds!! - elapsed
            val round = roundConfigRepository.findById(roundId).get()
            
            if (round.antiSnipeSeconds > 0 && remaining <= round.antiSnipeSeconds) {
                auction.timerStartedAt = now
                auction.timerDurationSeconds = round.antiSnipeSeconds
                auctionRepository.save(auction)
                eventPublisher.publish(auctionId, AuctionAction.TIMER_RESET, mapOf(
                    "newDurationSeconds" to round.antiSnipeSeconds,
                    "startedAt" to now,
                    "reason" to "ANTI_SNIPE",
                    "leaguePlayerId" to playerId
                ), actorId)
            }
        }
        
        return Result.Success(bid)
    }

    private fun resolveBidIncrement(roundId: UUID, player: com.crichere.domain.player.entity.LeaguePlayer, currentBid: Int = 0): Int {
        val categoryIncrements = categoryIncrementRepository.findByRoundId(roundId)
        if (player.tag != null) {
            val tagInc = categoryIncrements.find { it.tag == player.tag }
            if (tagInc != null) return tagInc.bidIncrement
        }
        if (player.category != null) {
            val catInc = categoryIncrements.find { it.category == player.category }
            if (catInc != null) return catInc.bidIncrement
        }
        val slabs = slabRepository.findByRoundIdOrderByFromAmountAsc(roundId)
        val slab = slabs.findLast { currentBid >= it.fromAmount && (it.toAmount == null || currentBid < it.toAmount!!) }
        return slab?.incrementBy ?: 500
    }
}

interface SellPlayerUseCase {
    fun execute(auctionId: UUID, leaguePlayerId: UUID, franchiseId: UUID, finalPrice: Int, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError>
}

@Service
class SellPlayerUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val purseRepository: FranchisePurseStateRepository,
    private val franchiseRepository: FranchiseRepository,
    private val franchisePlayerRepository: FranchisePlayerRepository,
    private val eventPublisher: AuctionEventPublisher,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val userRepository: UserRepository,
    private val applicationEventPublisher: ApplicationEventPublisher,
    private val meterRegistry: MeterRegistry
) : SellPlayerUseCase {
    private val playerSoldCounter = meterRegistry.counter("crichere.auction.players.sold")

    @Transactional
    override fun execute(auctionId: UUID, leaguePlayerId: UUID, franchiseId: UUID, finalPrice: Int, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, leaguePlayerId).get()
        
        if (playerState.state != PlayerAuctionStateValue.UP_FOR_BIDDING) return Result.Failure(AuctionDomainError.InvalidPlayerState)
        
        val roundId = auction.currentRoundId!!
        val purse = purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId) 
            ?: return Result.Failure(AuctionDomainError.PurseNotFound)
        
        if (purse.currentAmount < finalPrice) return Result.Failure(AuctionDomainError.InsufficientPurse)
        
        playerState.state = PlayerAuctionStateValue.SOLD
        playerState.roundId = roundId
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
        
        eventPublisher.publish(auctionId, AuctionAction.TIMER_STOPPED, emptyMap(), actorId)
        eventPublisher.publish(auctionId, AuctionAction.PLAYER_SOLD, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "franchiseId" to franchiseId,
            "finalPrice" to finalPrice,
            "roundId" to roundId
        ), actorId)

        val lp = leaguePlayerRepository.findById(leaguePlayerId).get()
        val playerUser = userRepository.findById(lp.userId).get()
        
        applicationEventPublisher.publishEvent(PlayerSoldApplicationEvent(
            auctionId = auctionId,
            leaguePlayerId = leaguePlayerId,
            userId = lp.userId,
            franchiseId = franchiseId,
            franchiseName = franchise.name,
            franchiseOwnerId = franchise.ownerId,
            finalPrice = finalPrice,
            playerName = playerUser.name ?: "a player"
        ))
        
        return Result.Success(playerState)
    }
}

interface UndoBidUseCase {
    fun execute(auctionId: UUID, reason: String, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError>
}

@Service
class UndoBidUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val bidRepository: BidRepository,
    private val eventPublisher: AuctionEventPublisher
) : UndoBidUseCase {
    @Transactional
    override fun execute(auctionId: UUID, reason: String, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        val playerId = auction.currentLeaguePlayerId ?: return Result.Failure(AuctionDomainError.NoPlayerUp)
        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId).get()

        if (playerState.state != PlayerAuctionStateValue.UP_FOR_BIDDING) return Result.Failure(AuctionDomainError.InvalidPlayerState)

        val lastBidOpt = bidRepository.findFirstByLeaguePlayerIdAndAuctionIdAndStatusOrderByBidAtDesc(playerId, auctionId, BidStatus.ACTIVE)
        if (lastBidOpt.isEmpty) return Result.Failure(AuctionDomainError.NoActiveBids)
        val lastBid = lastBidOpt.get()
        
        lastBid.status = BidStatus.UNDONE
        bidRepository.save(lastBid)
        
        val nextBid = bidRepository.findFirstByLeaguePlayerIdAndAuctionIdAndStatusOrderByBidAtDesc(playerId, auctionId, BidStatus.ACTIVE)
        val undoneAmount = lastBid.bidAmount
        val undoneFranchiseId = lastBid.franchiseId
        
        playerState.currentHighestBid = nextBid.map { it.bidAmount }.orElse(null)
        playerState.currentHighestBidderId = nextBid.map { it.franchiseId }.orElse(null)
        val savedState = playerStateRepository.save(playerState)
        
        eventPublisher.publish(auctionId, AuctionAction.BID_UNDONE, mapOf(
            "leaguePlayerId" to playerId,
            "undoneBidId" to lastBid.id,
            "undoneAmount" to undoneAmount,
            "undoneFranchiseId" to undoneFranchiseId,
            "newHighestBid" to playerState.currentHighestBid,
            "newHighestBidder" to playerState.currentHighestBidderId,
            "reason" to reason
        ), actorId)
        
        return Result.Success(savedState)
    }
}

interface UndoSoldUseCase {
    fun execute(auctionId: UUID, leaguePlayerId: UUID, reason: String, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError>
}

@Service
class UndoSoldUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val purseRepository: FranchisePurseStateRepository,
    private val franchiseRepository: FranchiseRepository,
    private val franchisePlayerRepository: FranchisePlayerRepository,
    private val auctionAuditLogRepository: AuctionAuditLogRepository,
    private val eventPublisher: AuctionEventPublisher
) : UndoSoldUseCase {
    @Transactional
    override fun execute(auctionId: UUID, leaguePlayerId: UUID, reason: String, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()
        
        val logs = auctionAuditLogRepository.findByAuctionIdOrderBySequenceNumberAsc(auctionId)
        val lastSoldIndex = logs.indexOfLast { it.action == AuctionAction.PLAYER_SOLD }
        val lastSold = logs.getOrNull(lastSoldIndex)
        val payloadPlayerId = lastSold?.payload?.get("leaguePlayerId")?.toString()
        if (lastSold == null || payloadPlayerId != leaguePlayerId.toString()) {
            return Result.Failure(AuctionDomainError.UndoNotLastAction)
        }
        val intervening = logs.subList(lastSoldIndex + 1, logs.size)
            .any { it.action !in setOf(AuctionAction.TIMER_STARTED, AuctionAction.TIMER_STOPPED, AuctionAction.TIMER_RESET) }
        if (intervening) {
            return Result.Failure(AuctionDomainError.UndoNotLastAction)
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
        
        eventPublisher.publish(auctionId, AuctionAction.SOLD_REVERTED, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "revertedFromFranchiseId" to revertedFromFranchiseId,
            "restoredAmount" to restoredAmount,
            "reason" to reason
        ), actorId)
        
        return Result.Success(playerState)
    }
}

interface UnsoldPlayerUseCase {
    fun execute(auctionId: UUID, leaguePlayerId: UUID, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError>
}

@Service
class UnsoldPlayerUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val eventPublisher: AuctionEventPublisher
) : UnsoldPlayerUseCase {
    @Transactional
    override fun execute(auctionId: UUID, leaguePlayerId: UUID, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, leaguePlayerId).get()
        
        playerState.state = PlayerAuctionStateValue.UNSOLD
        playerState.roundId = auction.currentRoundId ?: playerState.roundId
        playerStateRepository.save(playerState)

        auction.currentLeaguePlayerId = null
        auction.timerStartedAt = null
        auction.timerDurationSeconds = null
        auctionRepository.save(auction)
        
        eventPublisher.publish(auctionId, AuctionAction.TIMER_STOPPED, emptyMap(), actorId)
        eventPublisher.publish(auctionId, AuctionAction.PLAYER_UNSOLD, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "roundId" to auction.currentRoundId
        ), actorId)
        
        return Result.Success(playerState)
    }
}
