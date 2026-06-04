package com.crichere.domain.auction.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.auction.dto.AuctionStateSnapshot
import com.crichere.domain.auction.dto.BidIncrementSlabDto
import com.crichere.domain.auction.entity.*
import com.crichere.domain.auction.error.AuctionDomainError
import com.crichere.domain.auction.repository.*
import com.crichere.domain.franchise.repository.FranchisePurseStateRepository
import com.crichere.domain.league.entity.Auction
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.league.repository.LeagueRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

interface AuctionQueryUseCases {
    fun getAuction(auctionId: UUID): Result<Auction, AuctionDomainError>
    fun getAuctionByToken(token: String): Result<Auction, AuctionDomainError>
    fun getRounds(auctionId: UUID): Result<List<AuctionRoundConfig>, AuctionDomainError>
    fun getRound(roundId: UUID): Result<AuctionRoundConfig, AuctionDomainError>
    fun getRoundSlabs(roundId: UUID): Result<List<BidIncrementSlabDto>, AuctionDomainError>
    fun getCategoryIncrements(roundId: UUID): Result<List<AuctionRoundCategoryIncrement>, AuctionDomainError>
    fun getAuditLogs(auctionId: UUID): Result<List<AuctionAuditLog>, AuctionDomainError>
    fun getAuditLogsSince(auctionId: UUID, sequenceNumber: Long): Result<List<AuctionAuditLog>, AuctionDomainError>
}

@Service
class AuctionQueryUseCasesImpl(
    private val auctionRepository: AuctionRepository,
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val slabRepository: BidIncrementSlabRepository,
    private val categoryIncrementRepository: AuctionRoundCategoryIncrementRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val purseRepository: FranchisePurseStateRepository,
    private val auctionAuditLogRepository: AuctionAuditLogRepository,
    private val leagueRepository: LeagueRepository
) : AuctionQueryUseCases {

    @Transactional(readOnly = true)
    override fun getAuction(auctionId: UUID): Result<Auction, AuctionDomainError> {
        val auctionOpt = auctionRepository.findById(auctionId)
        if (auctionOpt.isEmpty) return Result.Failure(AuctionDomainError.AuctionNotFound(auctionId))
        return Result.Success(auctionOpt.get())
    }

    @Transactional(readOnly = true)
    override fun getAuctionByToken(token: String): Result<Auction, AuctionDomainError> {
        val auction = auctionRepository.findByPublicViewToken(token) 
            ?: return Result.Failure(AuctionDomainError.AuctionNotFound(UUID.randomUUID()))
        return Result.Success(auction)
    }

    @Transactional(readOnly = true)
    override fun getRounds(auctionId: UUID): Result<List<AuctionRoundConfig>, AuctionDomainError> {
        return Result.Success(roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId))
    }

    @Transactional(readOnly = true)
    override fun getRound(roundId: UUID): Result<AuctionRoundConfig, AuctionDomainError> {
        val roundOpt = roundConfigRepository.findById(roundId)
        if (roundOpt.isEmpty) return Result.Failure(AuctionDomainError.RoundNotFound(roundId))
        return Result.Success(roundOpt.get())
    }

    @Transactional(readOnly = true)
    override fun getRoundSlabs(roundId: UUID): Result<List<BidIncrementSlabDto>, AuctionDomainError> {
        return Result.Success(slabRepository.findByRoundIdOrderByFromAmountAsc(roundId).map { s ->
            BidIncrementSlabDto(s.fromAmount, s.toAmount, s.incrementBy)
        })
    }

    @Transactional(readOnly = true)
    override fun getCategoryIncrements(roundId: UUID): Result<List<AuctionRoundCategoryIncrement>, AuctionDomainError> {
        return Result.Success(categoryIncrementRepository.findByRoundId(roundId))
    }

    @Transactional(readOnly = true)
    override fun getAuditLogs(auctionId: UUID): Result<List<AuctionAuditLog>, AuctionDomainError> {
        return Result.Success(auctionAuditLogRepository.findByAuctionIdOrderBySequenceNumberAsc(auctionId))
    }

    @Transactional(readOnly = true)
    override fun getAuditLogsSince(auctionId: UUID, sequenceNumber: Long): Result<List<AuctionAuditLog>, AuctionDomainError> {
        return Result.Success(auctionAuditLogRepository.findByAuctionIdAndSequenceNumberGreaterThanOrderBySequenceNumberAsc(auctionId, sequenceNumber))
    }
}
