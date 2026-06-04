package com.crichere.domain.league.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.league.entity.Auction
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.enums.AuctionStatus
import com.crichere.domain.league.error.LeagueDomainError
import com.crichere.domain.league.repository.AuctionRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

interface InitializeAuctionUseCase {
    fun execute(league: League): Result<Auction, LeagueDomainError>
}

@Service
class InitializeAuctionUseCaseImpl(
    private val auctionRepository: AuctionRepository
) : InitializeAuctionUseCase {

    @Transactional
    override fun execute(league: League): Result<Auction, LeagueDomainError> {
        val existingAuction = auctionRepository.findByLeagueId(league.id)
        if (existingAuction != null) {
            return Result.Failure(LeagueDomainError.AuctionAlreadyInitialized)
        }

        val auction = auctionRepository.save(
            Auction(
                leagueId = league.id,
                status = AuctionStatus.DRAFT
            )
        )
        return Result.Success(auction)
    }
}
