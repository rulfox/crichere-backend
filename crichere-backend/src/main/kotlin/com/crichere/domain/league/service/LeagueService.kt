package com.crichere.domain.league.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.franchise.entity.FranchisePurseState
import com.crichere.domain.franchise.repository.FranchisePurseStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.entity.Auction
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.enums.AuctionStatus
import com.crichere.domain.league.enums.LeagueStatus
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.league.repository.LeagueRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

@Service
class LeagueService(
    private val leagueRepository: LeagueRepository,
    private val auctionRepository: AuctionRepository,
    private val franchiseRepository: FranchiseRepository,
    private val franchisePurseStateRepository: FranchisePurseStateRepository
) {

    @Transactional
    fun createLeague(league: League): League {
        return leagueRepository.save(league)
    }

    fun getLeague(id: UUID): League {
        return leagueRepository.findById(id).orElseThrow {
            ResourceNotFoundException("League not found with id: $id")
        }
    }

    @Transactional
    fun updateLeagueStatus(leagueId: UUID, newStatus: LeagueStatus): League {
        val league = getLeague(leagueId)
        validateStatusTransition(league.status, newStatus)
        
        if (newStatus == LeagueStatus.AUCTION_INITIALIZED) {
            initializeAuction(league)
        }
        
        league.status = newStatus
        return leagueRepository.save(league)
    }

    private fun validateStatusTransition(current: LeagueStatus, next: LeagueStatus) {
        val isValid = when (current) {
            LeagueStatus.DRAFT -> next == LeagueStatus.OPEN
            LeagueStatus.OPEN -> next == LeagueStatus.AUCTION_INITIALIZED || next == LeagueStatus.DRAFT
            LeagueStatus.AUCTION_INITIALIZED -> next == LeagueStatus.AUCTION_IN_PROGRESS
            LeagueStatus.AUCTION_IN_PROGRESS -> next == LeagueStatus.AUCTION_COMPLETED
            LeagueStatus.AUCTION_COMPLETED -> next == LeagueStatus.COMPLETED
            LeagueStatus.COMPLETED -> false
        }
        
        if (!isValid) {
            throw BusinessLogicException(
                "Invalid status transition from $current to $next",
                "error.invalid_status_transition"
            )
        }
    }

    @Transactional
    fun initializeAuction(league: League) {
        val existingAuction = auctionRepository.findByLeagueId(league.id)
        if (existingAuction != null) {
            throw BusinessLogicException("Auction already initialized for this league", "error.auction_already_initialized")
        }

        val franchises = franchiseRepository.findByLeagueId(league.id)
        if (franchises.isEmpty()) {
            throw BusinessLogicException("Cannot initialize auction without franchises", "error.no_franchises")
        }

        val totalRounds = 1 // Default to 1 round for now, can be configurable
        val auction = auctionRepository.save(
            Auction(
                leagueId = league.id,
                status = AuctionStatus.PENDING,
                totalRounds = totalRounds
            )
        )

        // Create FranchisePurseState for each franchise for each round
        for (franchise in franchises) {
            for (round in 1..totalRounds) {
                franchisePurseStateRepository.save(
                    FranchisePurseState(
                        franchiseId = franchise.id,
                        auctionId = auction.id,
                        roundNumber = round,
                        initialPurse = franchise.totalPurse,
                        remainingPurse = franchise.totalPurse
                    )
                )
            }
        }
    }
}
