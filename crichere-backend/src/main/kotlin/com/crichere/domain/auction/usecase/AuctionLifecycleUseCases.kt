package com.crichere.domain.auction.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.auction.dto.RoundConfigDto
import com.crichere.domain.auction.entity.AuctionRoundConfig
import com.crichere.domain.auction.entity.BidIncrementSlab
import com.crichere.domain.auction.entity.PlayerAuctionState
import com.crichere.domain.auction.enums.AuctionAction
import com.crichere.domain.auction.enums.PlayerAuctionStateValue
import com.crichere.domain.auction.error.AuctionDomainError
import com.crichere.domain.auction.event.AuctionStartedApplicationEvent
import com.crichere.domain.auction.publisher.AuctionEventPublisher
import com.crichere.domain.auction.repository.AuctionRoundConfigRepository
import com.crichere.domain.auction.repository.BidIncrementSlabRepository
import com.crichere.domain.auction.repository.PlayerAuctionStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.entity.Auction
import com.crichere.domain.league.enums.AuctionStatus
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.player.repository.LeaguePlayerRepository
import io.micrometer.core.instrument.MeterRegistry
import org.springframework.context.ApplicationEventPublisher
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.util.UUID

interface CreateAuctionUseCase {
    fun execute(leagueId: UUID, auctioneerId: UUID, rounds: List<RoundConfigDto>): Result<Auction, AuctionDomainError>
}

@Service
class CreateAuctionUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val slabRepository: BidIncrementSlabRepository
) : CreateAuctionUseCase {
    @Transactional
    override fun execute(leagueId: UUID, auctioneerId: UUID, rounds: List<RoundConfigDto>): Result<Auction, AuctionDomainError> {
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
        return Result.Success(auction)
    }
}

interface StartAuctionUseCase {
    fun execute(auctionId: UUID, actorId: UUID): Result<Auction, AuctionDomainError>
}

@Service
class StartAuctionUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val franchiseRepository: FranchiseRepository,
    private val leagueRepository: LeagueRepository,
    private val eventPublisher: AuctionEventPublisher,
    private val applicationEventPublisher: ApplicationEventPublisher,
    private val meterRegistry: MeterRegistry
) : StartAuctionUseCase {
    private val auctionStartedCounter = meterRegistry.counter("crichere.auction.started")

    @Transactional
    override fun execute(auctionId: UUID, actorId: UUID): Result<Auction, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        if (auction.status != AuctionStatus.DRAFT) return Result.Failure(AuctionDomainError.InvalidAuctionStatus)
        
        auction.status = AuctionStatus.LIVE
        auction.startedAt = Instant.now()
        
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
        eventPublisher.publish(auction.id, AuctionAction.AUCTION_STARTED, mapOf("startedAt" to auction.startedAt), actorId)

        val franchiseOwners = franchiseRepository.findByLeagueId(auction.leagueId).map { it.ownerId }
        val league = leagueRepository.findById(auction.leagueId).get()
        
        applicationEventPublisher.publishEvent(
            AuctionStartedApplicationEvent(auction.id, league.id, league.name, franchiseOwners)
        )

        return Result.Success(savedAuction)
    }
}

interface PauseAuctionUseCase {
    fun execute(auctionId: UUID, reason: String?, actorId: UUID): Result<Auction, AuctionDomainError>
}

@Service
class PauseAuctionUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val eventPublisher: AuctionEventPublisher
) : PauseAuctionUseCase {
    @Transactional
    override fun execute(auctionId: UUID, reason: String?, actorId: UUID): Result<Auction, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        if (auction.status != AuctionStatus.LIVE) return Result.Failure(AuctionDomainError.InvalidAuctionStatus)
        
        auction.status = AuctionStatus.PAUSED
        val savedAuction = auctionRepository.save(auction)
        eventPublisher.publish(auction.id, AuctionAction.AUCTION_PAUSED, mapOf("reason" to reason), actorId)
        return Result.Success(savedAuction)
    }
}

interface ResumeAuctionUseCase {
    fun execute(auctionId: UUID, actorId: UUID): Result<Auction, AuctionDomainError>
}

@Service
class ResumeAuctionUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val eventPublisher: AuctionEventPublisher
) : ResumeAuctionUseCase {
    @Transactional
    override fun execute(auctionId: UUID, actorId: UUID): Result<Auction, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        if (auction.status != AuctionStatus.PAUSED) return Result.Failure(AuctionDomainError.InvalidAuctionStatus)
        
        auction.status = AuctionStatus.LIVE
        val savedAuction = auctionRepository.save(auction)
        eventPublisher.publish(auction.id, AuctionAction.AUCTION_RESUMED, emptyMap(), actorId)
        return Result.Success(savedAuction)
    }
}

interface CompleteAuctionUseCase {
    fun execute(auctionId: UUID, actorId: UUID): Result<Auction, AuctionDomainError>
}

@Service
class CompleteAuctionUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val leagueRepository: LeagueRepository,
    private val eventPublisher: AuctionEventPublisher
) : CompleteAuctionUseCase {
    @Transactional
    override fun execute(auctionId: UUID, actorId: UUID): Result<Auction, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        if (auction.status != AuctionStatus.LIVE && auction.status != AuctionStatus.PAUSED) {
            return Result.Failure(AuctionDomainError.InvalidAuctionStatus)
        }
        
        val playerStates = playerStateRepository.findByAuctionId(auction.id)
        val league = leagueRepository.findById(auction.leagueId).get()
        
        if (league.mustSellAll) {
            val unsoldCount = playerStates.count { it.state == PlayerAuctionStateValue.UNSOLD || it.state == PlayerAuctionStateValue.AVAILABLE }
            if (unsoldCount > 0) return Result.Failure(AuctionDomainError.MustSellAllViolated)
        }

        auction.status = AuctionStatus.COMPLETED
        auction.completedAt = Instant.now()

        val totalSold = playerStates.count { it.state == PlayerAuctionStateValue.SOLD || it.state == PlayerAuctionStateValue.FORCE_ASSIGNED }
        val totalUnsold = playerStates.count { it.state == PlayerAuctionStateValue.UNSOLD }
        val totalSpent = playerStates.sumOf { it.finalPrice ?: 0 }
        
        val savedAuction = auctionRepository.save(auction)
        eventPublisher.publish(auction.id, AuctionAction.AUCTION_COMPLETED, mapOf(
            "totalSold" to totalSold,
            "totalUnsold" to totalUnsold,
            "totalSpent" to totalSpent,
            "completedAt" to auction.completedAt
        ), actorId)
        
        return Result.Success(savedAuction)
    }
}

interface CancelAuctionUseCase {
    fun execute(auctionId: UUID, reason: String?, actorId: UUID): Result<Auction, AuctionDomainError>
}

@Service
class CancelAuctionUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val eventPublisher: AuctionEventPublisher
) : CancelAuctionUseCase {
    @Transactional
    override fun execute(auctionId: UUID, reason: String?, actorId: UUID): Result<Auction, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        if (auction.status == AuctionStatus.COMPLETED || auction.status == AuctionStatus.CANCELLED) {
            return Result.Failure(AuctionDomainError.InvalidAuctionStatus)
        }
        
        auction.status = AuctionStatus.CANCELLED
        auction.completedAt = Instant.now()
        auction.timerStartedAt = null
        auction.timerDurationSeconds = null
        val saved = auctionRepository.save(auction)
        eventPublisher.publish(auctionId, AuctionAction.AUCTION_CANCELLED, mapOf("reason" to reason), actorId)
        
        return Result.Success(saved)
    }
}
