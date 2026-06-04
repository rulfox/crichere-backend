package com.crichere.domain.auction.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.auction.dto.RoundConfigDto
import com.crichere.domain.auction.entity.AuctionRoundConfig
import com.crichere.domain.auction.entity.BidIncrementSlab
import com.crichere.domain.auction.entity.PlayerAuctionState
import com.crichere.domain.auction.enums.AuctionAction
import com.crichere.domain.auction.enums.PlayerAuctionStateValue
import com.crichere.domain.auction.enums.RoundStatus
import com.crichere.domain.auction.error.AuctionDomainError
import com.crichere.domain.auction.publisher.AuctionEventPublisher
import com.crichere.domain.auction.repository.*
import com.crichere.domain.league.enums.AuctionStatus
import com.crichere.domain.league.repository.AuctionRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.util.UUID

interface AddRoundUseCase {
    fun execute(auctionId: UUID, roundDto: RoundConfigDto): Result<AuctionRoundConfig, AuctionDomainError>
}

@Service
class AddRoundUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val slabRepository: BidIncrementSlabRepository
) : AddRoundUseCase {
    @Transactional
    override fun execute(auctionId: UUID, roundDto: RoundConfigDto): Result<AuctionRoundConfig, AuctionDomainError> {
        val auctionOpt = auctionRepository.findById(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()
        if (auction.status != AuctionStatus.DRAFT) return Result.Failure(AuctionDomainError.InvalidAuctionStatus)

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
        return Result.Success(round)
    }
}

interface UpdateRoundUseCase {
    fun execute(roundId: UUID, roundDto: RoundConfigDto): Result<AuctionRoundConfig, AuctionDomainError>
}

@Service
class UpdateRoundUseCaseImpl(
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val slabRepository: BidIncrementSlabRepository
) : UpdateRoundUseCase {
    @Transactional
    override fun execute(roundId: UUID, roundDto: RoundConfigDto): Result<AuctionRoundConfig, AuctionDomainError> {
        val roundOpt = roundConfigRepository.findById(roundId)
        if (roundOpt.isEmpty) return Result.Failure(AuctionDomainError.RoundNotFound(roundId))
        val round = roundOpt.get()
        if (round.status != RoundStatus.PENDING) return Result.Failure(AuctionDomainError.InvalidRoundStatus)

        round.name = roundDto.name
        round.currencyType = roundDto.currencyType
        round.purseAmount = roundDto.purseAmount
        round.purseSource = roundDto.purseSource
        round.bidMode = roundDto.bidMode
        round.playerPoolSource = roundDto.playerPoolSource
        round.franchiseEligibilityRule = roundDto.franchiseEligibilityRule
        round.completionTrigger = roundDto.completionTrigger

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

        return Result.Success(roundConfigRepository.save(round))
    }
}

interface DeleteRoundUseCase {
    fun execute(roundId: UUID): Result<Unit, AuctionDomainError>
}

@Service
class DeleteRoundUseCaseImpl(
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val slabRepository: BidIncrementSlabRepository,
    private val categoryIncrementRepository: AuctionRoundCategoryIncrementRepository
) : DeleteRoundUseCase {
    @Transactional
    override fun execute(roundId: UUID): Result<Unit, AuctionDomainError> {
        val roundOpt = roundConfigRepository.findById(roundId)
        if (roundOpt.isEmpty) return Result.Failure(AuctionDomainError.RoundNotFound(roundId))
        val round = roundOpt.get()
        if (round.status != RoundStatus.PENDING) return Result.Failure(AuctionDomainError.InvalidRoundStatus)

        slabRepository.deleteAll(slabRepository.findByRoundIdOrderByFromAmountAsc(roundId))
        categoryIncrementRepository.deleteAll(categoryIncrementRepository.findByRoundId(roundId))
        roundConfigRepository.delete(round)
        return Result.Success(Unit)
    }
}

interface CompleteRoundUseCase {
    fun execute(auctionId: UUID, roundId: UUID, actorId: UUID): Result<AuctionRoundConfig, AuctionDomainError>
}

@Service
class CompleteRoundUseCaseImpl(
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val eventPublisher: AuctionEventPublisher
) : CompleteRoundUseCase {
    @Transactional
    override fun execute(auctionId: UUID, roundId: UUID, actorId: UUID): Result<AuctionRoundConfig, AuctionDomainError> {
        val roundOpt = roundConfigRepository.findById(roundId)
        if (roundOpt.isEmpty) return Result.Failure(AuctionDomainError.RoundNotFound(roundId))
        val round = roundOpt.get()
        
        round.status = RoundStatus.COMPLETED
        round.completedAt = Instant.now()
        
        val playerStates = playerStateRepository.findByAuctionId(auctionId)
        val soldCount = playerStates.count { it.state == PlayerAuctionStateValue.SOLD }
        val unsoldCount = playerStates.count { it.state == PlayerAuctionStateValue.UNSOLD }
        
        val savedRound = roundConfigRepository.save(round)
        eventPublisher.publish(auctionId, AuctionAction.ROUND_COMPLETED, mapOf(
            "roundId" to roundId,
            "soldCount" to soldCount,
            "unsoldCount" to unsoldCount
        ), actorId)
        
        return Result.Success(savedRound)
    }
}

interface UpdatePlayerPoolUseCase {
    fun execute(roundId: UUID, playerIds: List<UUID>): Result<Unit, AuctionDomainError>
}

@Service
class UpdatePlayerPoolUseCaseImpl(
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val poolPlayerRepository: AuctionRoundPoolPlayerRepository
) : UpdatePlayerPoolUseCase {
    @Transactional
    override fun execute(roundId: UUID, playerIds: List<UUID>): Result<Unit, AuctionDomainError> {
        val roundOpt = roundConfigRepository.findById(roundId)
        if (roundOpt.isEmpty) return Result.Failure(AuctionDomainError.RoundNotFound(roundId))
        val round = roundOpt.get()
        if (round.status != RoundStatus.PENDING) return Result.Failure(AuctionDomainError.InvalidRoundStatus)

        poolPlayerRepository.deleteByRoundId(roundId)
        val entities = playerIds.map { com.crichere.domain.auction.entity.AuctionRoundPoolPlayer(roundId = roundId, leaguePlayerId = it) }
        poolPlayerRepository.saveAll(entities)
        return Result.Success(Unit)
    }
}

interface WithdrawPlayerUseCase {
    fun execute(auctionId: UUID, leaguePlayerId: UUID, reason: String, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError>
}

@Service
class WithdrawPlayerUseCaseImpl(
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val auctionRepository: AuctionRepository,
    private val eventPublisher: AuctionEventPublisher
) : WithdrawPlayerUseCase {
    @Transactional
    override fun execute(auctionId: UUID, leaguePlayerId: UUID, reason: String, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError> {
        val playerStateOpt = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, leaguePlayerId)
        if (playerStateOpt.isEmpty) return Result.Failure(AuctionDomainError.PlayerNotFoundInPool)
        val playerState = playerStateOpt.get()
        
        if (playerState.state != PlayerAuctionStateValue.UP_FOR_BIDDING && playerState.state != PlayerAuctionStateValue.AVAILABLE) {
            return Result.Failure(AuctionDomainError.InvalidPlayerState)
        }
        
        playerState.state = PlayerAuctionStateValue.WITHDRAWN
        val savedState = playerStateRepository.save(playerState)
        
        val auctionOpt = auctionRepository.findById(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        if (auction.currentLeaguePlayerId == leaguePlayerId) {
            auction.currentLeaguePlayerId = null
            auction.timerStartedAt = null
            auction.timerDurationSeconds = null
            auctionRepository.save(auction)
            eventPublisher.publish(auctionId, AuctionAction.TIMER_STOPPED, emptyMap(), actorId)
        }
        
        eventPublisher.publish(auctionId, AuctionAction.PLAYER_WITHDRAWN, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "reason" to reason,
            "roundId" to auction.currentRoundId
        ), actorId)
        
        return Result.Success(savedState)
    }
}

interface DeleteAuctionUseCase {
    fun execute(auctionId: UUID): Result<Unit, AuctionDomainError>
}

@Service
class DeleteAuctionUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val slabRepository: BidIncrementSlabRepository
) : DeleteAuctionUseCase {
    @Transactional
    override fun execute(auctionId: UUID): Result<Unit, AuctionDomainError> {
        val auctionOpt = auctionRepository.findById(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()
        if (auction.status != AuctionStatus.DRAFT) return Result.Failure(AuctionDomainError.InvalidAuctionStatus)

        val rounds = roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId)
        rounds.forEach { r ->
            slabRepository.deleteAll(slabRepository.findByRoundIdOrderByFromAmountAsc(r.id))
        }
        roundConfigRepository.deleteAll(rounds)
        auctionRepository.delete(auction)
        return Result.Success(Unit)
    }
}

interface RegeneratePublicViewTokenUseCase {
    fun execute(auctionId: UUID): Result<com.crichere.domain.league.entity.Auction, AuctionDomainError>
}

@Service
class RegeneratePublicViewTokenUseCaseImpl(
    private val auctionRepository: AuctionRepository
) : RegeneratePublicViewTokenUseCase {
    @Transactional
    override fun execute(auctionId: UUID): Result<com.crichere.domain.league.entity.Auction, AuctionDomainError> {
        val auctionOpt = auctionRepository.findById(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()
        
        auction.publicViewToken = com.crichere.domain.league.entity.Auction.generateSecureToken()
        return Result.Success(auctionRepository.save(auction))
    }
}
