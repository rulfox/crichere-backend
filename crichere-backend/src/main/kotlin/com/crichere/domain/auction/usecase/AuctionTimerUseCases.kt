package com.crichere.domain.auction.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.auction.dto.TimerStateResponse
import com.crichere.domain.auction.enums.AuctionAction
import com.crichere.domain.auction.error.AuctionDomainError
import com.crichere.domain.auction.publisher.AuctionEventPublisher
import com.crichere.domain.auction.repository.AuctionRoundConfigRepository
import com.crichere.domain.league.entity.Auction
import com.crichere.domain.league.enums.AuctionStatus
import com.crichere.domain.league.repository.AuctionRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Duration
import java.time.Instant
import java.util.UUID

interface StartTimerUseCase {
    fun execute(auctionId: UUID, durationOverride: Int?, actorId: UUID): Result<TimerStateResponse, AuctionDomainError>
}

@Service
class StartTimerUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val eventPublisher: AuctionEventPublisher,
    private val getTimerStateQuery: GetTimerStateQuery
) : StartTimerUseCase {
    @Transactional
    override fun execute(auctionId: UUID, durationOverride: Int?, actorId: UUID): Result<TimerStateResponse, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        if (auction.status != AuctionStatus.LIVE) return Result.Failure(AuctionDomainError.InvalidAuctionStatus)
        val playerId = auction.currentLeaguePlayerId ?: return Result.Failure(AuctionDomainError.NoPlayerUp)
        val roundId = auction.currentRoundId ?: return Result.Failure(AuctionDomainError.NoActiveRound)
        
        val roundOpt = roundConfigRepository.findById(roundId)
        if (roundOpt.isEmpty) return Result.Failure(AuctionDomainError.RoundNotFound(roundId))
        val round = roundOpt.get()

        val duration = durationOverride ?: round.countdownSeconds
        auction.timerStartedAt = Instant.now()
        auction.timerDurationSeconds = duration
        auctionRepository.save(auction)

        eventPublisher.publish(auctionId, AuctionAction.TIMER_STARTED, mapOf(
            "durationSeconds" to duration,
            "startedAt" to auction.timerStartedAt,
            "antiSnipeSeconds" to round.antiSnipeSeconds,
            "leaguePlayerId" to playerId
        ), actorId)

        return getTimerStateQuery.execute(auction)
    }
}

interface StopTimerUseCase {
    fun execute(auctionId: UUID, actorId: UUID): Result<Unit, AuctionDomainError>
}

@Service
class StopTimerUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val eventPublisher: AuctionEventPublisher
) : StopTimerUseCase {
    @Transactional
    override fun execute(auctionId: UUID, actorId: UUID): Result<Unit, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        auction.timerStartedAt = null
        auction.timerDurationSeconds = null
        auctionRepository.save(auction)

        eventPublisher.publish(auctionId, AuctionAction.TIMER_STOPPED, emptyMap(), actorId)
        return Result.Success(Unit)
    }
}

interface ExtendTimerUseCase {
    fun execute(auctionId: UUID, additionalSeconds: Int, actorId: UUID): Result<TimerStateResponse, AuctionDomainError>
}

@Service
class ExtendTimerUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val eventPublisher: AuctionEventPublisher,
    private val getTimerStateQuery: GetTimerStateQuery
) : ExtendTimerUseCase {
    @Transactional
    override fun execute(auctionId: UUID, additionalSeconds: Int, actorId: UUID): Result<TimerStateResponse, AuctionDomainError> {
        require(additionalSeconds > 0) { "additionalSeconds must be positive" }
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        if (auction.timerStartedAt == null || auction.timerDurationSeconds == null) {
            return Result.Failure(AuctionDomainError.NoActiveTimer)
        }
        auction.timerDurationSeconds = auction.timerDurationSeconds!! + additionalSeconds
        auctionRepository.save(auction)
        
        eventPublisher.publish(auctionId, AuctionAction.TIMER_EXTENDED, mapOf(
            "addedSeconds" to additionalSeconds,
            "newDurationSeconds" to auction.timerDurationSeconds
        ), actorId)
        
        return getTimerStateQuery.execute(auction)
    }
}

interface GetTimerStateQuery {
    fun execute(auctionId: UUID): Result<TimerStateResponse, AuctionDomainError>
    fun execute(auction: Auction): Result<TimerStateResponse, AuctionDomainError>
}

@Service
class GetTimerStateQueryImpl(
    private val auctionRepository: AuctionRepository,
    private val roundConfigRepository: AuctionRoundConfigRepository
) : GetTimerStateQuery {

    @Transactional(readOnly = true)
    override fun execute(auctionId: UUID): Result<TimerStateResponse, AuctionDomainError> {
        val auctionOpt = auctionRepository.findById(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        return execute(auctionOpt.get())
    }

    override fun execute(auction: Auction): Result<TimerStateResponse, AuctionDomainError> {
        val round = auction.currentRoundId?.let { roundConfigRepository.findById(it).orElse(null) }
        val antiSnipe = round?.antiSnipeSeconds ?: 10

        if (auction.timerStartedAt == null || auction.timerDurationSeconds == null) {
            return Result.Success(TimerStateResponse(false, null, null, null, antiSnipe))
        }

        val now = Instant.now()
        val elapsed = Duration.between(auction.timerStartedAt, now).seconds
        val remaining = (auction.timerDurationSeconds!!.toLong() - elapsed).toInt().coerceAtLeast(0)

        return Result.Success(TimerStateResponse(
            isRunning = true,
            startedAt = auction.timerStartedAt,
            durationSeconds = auction.timerDurationSeconds,
            remainingSeconds = remaining,
            antiSnipeSeconds = antiSnipe
        ))
    }
}
