package com.crichere.domain.auction.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.auction.entity.PlayerAuctionState
import com.crichere.domain.auction.enums.AuctionAction
import com.crichere.domain.auction.enums.PlayerAuctionStateValue
import com.crichere.domain.auction.error.AuctionDomainError
import com.crichere.domain.auction.publisher.AuctionEventPublisher
import com.crichere.domain.auction.repository.PlayerAuctionStateRepository
import com.crichere.domain.auction.entity.FranchisePlayer
import com.crichere.domain.franchise.repository.FranchisePurseStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.auction.repository.FranchisePlayerRepository
import com.crichere.domain.league.repository.AuctionRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

interface PreAssignUseCase {
    fun execute(auctionId: UUID, leaguePlayerId: UUID, franchiseId: UUID, assignmentType: String, price: Int, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError>
}

@Service
class PreAssignUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val purseRepository: FranchisePurseStateRepository,
    private val franchisePlayerRepository: FranchisePlayerRepository,
    private val eventPublisher: AuctionEventPublisher
) : PreAssignUseCase {
    @Transactional
    override fun execute(auctionId: UUID, leaguePlayerId: UUID, franchiseId: UUID, assignmentType: String, price: Int, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        val stateOpt = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, leaguePlayerId)
        if (stateOpt.isEmpty) return Result.Failure(AuctionDomainError.PlayerNotFoundInPool)
        val playerState = stateOpt.get()
        
        if (playerState.state != PlayerAuctionStateValue.AVAILABLE) {
            return Result.Failure(AuctionDomainError.InvalidPlayerState)
        }
        
        playerState.state = PlayerAuctionStateValue.PRE_ASSIGNED
        playerState.roundId = auction.currentRoundId
        playerState.finalPrice = price
        playerState.soldToFranchiseId = franchiseId
        playerStateRepository.save(playerState)
        
        if (price > 0) {
            val roundId = auction.currentRoundId ?: return Result.Failure(AuctionDomainError.NoActiveRound)
            val purse = purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId)
                ?: return Result.Failure(AuctionDomainError.PurseNotFound)
            
            if (purse.currentAmount < price) return Result.Failure(AuctionDomainError.InsufficientPurse)
            purse.currentAmount -= price
            purseRepository.save(purse)
        }
        
        val currentRoundId = auction.currentRoundId ?: return Result.Failure(AuctionDomainError.NoActiveRound)
        
        franchisePlayerRepository.save(FranchisePlayer(
            franchiseId = franchiseId,
            leaguePlayerId = leaguePlayerId,
            boughtPrice = price,
            roundId = currentRoundId
        ))

        eventPublisher.publish(auctionId, AuctionAction.PLAYER_PRE_ASSIGNED, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "franchiseId" to franchiseId,
            "price" to price,
            "assignmentType" to assignmentType,
            "assignedBy" to actorId
        ), actorId)
        
        return Result.Success(playerState)
    }
}

interface ForceAssignUseCase {
    fun execute(auctionId: UUID, leaguePlayerId: UUID, franchiseId: UUID, price: Int, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError>
}

@Service
class ForceAssignUseCaseImpl(
    private val auctionRepository: AuctionRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val purseRepository: FranchisePurseStateRepository,
    private val franchiseRepository: FranchiseRepository,
    private val franchisePlayerRepository: FranchisePlayerRepository,
    private val eventPublisher: AuctionEventPublisher
) : ForceAssignUseCase {
    @Transactional
    override fun execute(auctionId: UUID, leaguePlayerId: UUID, franchiseId: UUID, price: Int, actorId: UUID): Result<PlayerAuctionState, AuctionDomainError> {
        val auctionOpt = auctionRepository.findByIdWithLock(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        val auction = auctionOpt.get()

        val playerState = playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, leaguePlayerId).get()
        
        if (playerState.state != PlayerAuctionStateValue.UNSOLD && playerState.state != PlayerAuctionStateValue.AVAILABLE) {
            return Result.Failure(AuctionDomainError.InvalidPlayerState)
        }
        
        playerState.state = PlayerAuctionStateValue.FORCE_ASSIGNED
        playerState.roundId = auction.currentRoundId
        playerState.finalPrice = price
        playerState.soldToFranchiseId = franchiseId
        playerStateRepository.save(playerState)
        
        if (price > 0) {
            val roundId = auction.currentRoundId ?: return Result.Failure(AuctionDomainError.NoActiveRound)
            val purse = purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId)
            if (purse != null) {
                purse.currentAmount -= price
                purseRepository.save(purse)
            }

            val franchise = franchiseRepository.findById(franchiseId).get()
            franchise.remainingPurse -= price
            franchiseRepository.save(franchise)
        }
        
        val currentRoundId = auction.currentRoundId ?: return Result.Failure(AuctionDomainError.NoActiveRound)
        
        franchisePlayerRepository.save(FranchisePlayer(
            franchiseId = franchiseId,
            leaguePlayerId = leaguePlayerId,
            boughtPrice = price,
            roundId = currentRoundId
        ))
        
        eventPublisher.publish(auctionId, AuctionAction.PLAYER_FORCE_ASSIGNED, mapOf(
            "leaguePlayerId" to leaguePlayerId,
            "franchiseId" to franchiseId,
            "price" to price,
            "assignedBy" to actorId
        ), actorId)
        
        return Result.Success(playerState)
    }
}
