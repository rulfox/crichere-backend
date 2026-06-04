package com.crichere.domain.auction.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.auction.dto.CategoryIncrementRequest
import com.crichere.domain.auction.entity.AuctionRoundCategoryIncrement
import com.crichere.domain.auction.entity.AuctionRoundConfig
import com.crichere.domain.auction.enums.AuctionAction
import com.crichere.domain.auction.enums.PurseSource
import com.crichere.domain.auction.enums.RoundStatus
import com.crichere.domain.auction.error.AuctionDomainError
import com.crichere.domain.auction.publisher.AuctionEventPublisher
import com.crichere.domain.auction.repository.AuctionRoundCategoryIncrementRepository
import com.crichere.domain.auction.repository.AuctionRoundConfigRepository
import com.crichere.domain.franchise.entity.FranchisePurseState
import com.crichere.domain.franchise.repository.FranchisePurseStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.repository.AuctionRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.util.UUID

interface StartRoundUseCase {
    fun execute(auctionId: UUID, roundId: UUID, actorId: UUID): Result<AuctionRoundConfig, AuctionDomainError>
}

@Service
class StartRoundUseCaseImpl(
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val auctionRepository: AuctionRepository,
    private val franchiseRepository: FranchiseRepository,
    private val purseRepository: FranchisePurseStateRepository,
    private val eventPublisher: AuctionEventPublisher
) : StartRoundUseCase {
    @Transactional
    override fun execute(auctionId: UUID, roundId: UUID, actorId: UUID): Result<AuctionRoundConfig, AuctionDomainError> {
        val roundOpt = roundConfigRepository.findById(roundId)
        if (roundOpt.isEmpty) return Result.Failure(AuctionDomainError.RoundNotFound(roundId))
        val round = roundOpt.get()

        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()
        
        round.status = RoundStatus.LIVE
        round.startedAt = Instant.now()
        auction.currentRoundId = round.id
        
        // Purse logic
        val franchises = franchiseRepository.findByLeagueId(auction.leagueId)
        franchises.forEach { franchise ->
            val initialAmount = if (round.purseSource == PurseSource.FRESH) {
                round.purseAmount ?: franchise.totalPurse
            } else {
                val prevRounds = roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId)
                val currentIndex = prevRounds.indexOfFirst { it.id == roundId }
                if (currentIndex > 0) {
                    val prevRound = prevRounds[currentIndex - 1]
                    val prevPurse = purseRepository.findByFranchiseIdAndRoundId(franchise.id, prevRound.id)
                    prevPurse?.currentAmount ?: franchise.totalPurse
                } else {
                    franchise.totalPurse
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
        eventPublisher.publish(auctionId, AuctionAction.ROUND_STARTED, mapOf("roundId" to roundId, "roundNumber" to round.roundNumber), actorId)
        
        return Result.Success(savedRound)
    }
}

interface UpdateCategoryIncrementsUseCase {
    fun execute(roundId: UUID, increments: List<CategoryIncrementRequest>): Result<List<AuctionRoundCategoryIncrement>, AuctionDomainError>
}

@Service
class UpdateCategoryIncrementsUseCaseImpl(
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val categoryIncrementRepository: AuctionRoundCategoryIncrementRepository
) : UpdateCategoryIncrementsUseCase {
    @Transactional
    override fun execute(roundId: UUID, increments: List<CategoryIncrementRequest>): Result<List<AuctionRoundCategoryIncrement>, AuctionDomainError> {
        val roundOpt = roundConfigRepository.findById(roundId)
        if (roundOpt.isEmpty) return Result.Failure(AuctionDomainError.RoundNotFound(roundId))
        val round = roundOpt.get()

        if (round.status != RoundStatus.PENDING) return Result.Failure(AuctionDomainError.InvalidRoundStatus)

        val existing = categoryIncrementRepository.findByRoundId(roundId)
        categoryIncrementRepository.deleteAll(existing)

        val newIncrements = increments.map { 
            AuctionRoundCategoryIncrement(
                roundId = roundId,
                category = it.category,
                tag = it.tag,
                bidIncrement = it.bidIncrement
            )
        }
        return Result.Success(categoryIncrementRepository.saveAll(newIncrements))
    }
}
