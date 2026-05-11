package com.crichere.domain.league.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.auth.entity.UserLeagueMembership
import com.crichere.domain.auth.enums.LeagueRole
import com.crichere.domain.auth.repository.UserLeagueMembershipRepository
import com.crichere.domain.franchise.repository.FranchisePurseStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.entity.Auction
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.enums.AuctionStatus
import com.crichere.domain.league.enums.LeagueStatus
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.league.repository.LeagueCategoryBasePriceRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.league.repository.LeagueTagBasePriceRepository
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.repository.LeaguePlayerRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

@Service
class LeagueService(
    private val leagueRepository: LeagueRepository,
    private val auctionRepository: AuctionRepository,
    private val franchiseRepository: FranchiseRepository,
    private val franchisePurseStateRepository: FranchisePurseStateRepository,
    private val leagueCategoryBasePriceRepository: LeagueCategoryBasePriceRepository,
    private val leagueTagBasePriceRepository: LeagueTagBasePriceRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val userLeagueMembershipRepository: UserLeagueMembershipRepository
) {

    @Transactional
    fun createLeague(league: League): League {
        val savedLeague = leagueRepository.save(league)
        userLeagueMembershipRepository.save(
            UserLeagueMembership(
                userId = league.createdBy,
                leagueId = savedLeague.id,
                role = LeagueRole.LEAGUE_ADMIN,
                isPrimary = true
            )
        )
        return savedLeague
    }

    fun getLeagues(): List<League> {
        return leagueRepository.findAll()
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

        auctionRepository.save(
            Auction(
                leagueId = league.id,
                status = AuctionStatus.DRAFT
            )
        )
    }

    @Transactional
    fun updateCategoryPrices(leagueId: UUID, prices: List<com.crichere.domain.league.dto.CategoryPriceRequest>): List<com.crichere.domain.league.entity.LeagueCategoryBasePrice> {
        val league = getLeague(leagueId)
        if (league.status != LeagueStatus.DRAFT && league.status != LeagueStatus.OPEN) {
            throw BusinessLogicException("Cannot update prices after auction initialization", "error.invalid_league_status")
        }

        val existing = leagueCategoryBasePriceRepository.findByLeagueId(leagueId)
        leagueCategoryBasePriceRepository.deleteAll(existing)

        val newPrices = prices.map { 
            com.crichere.domain.league.entity.LeagueCategoryBasePrice(
                leagueId = leagueId,
                category = it.category,
                price = it.price
            )
        }
        return leagueCategoryBasePriceRepository.saveAll(newPrices)
    }

    fun getCategoryPrices(leagueId: UUID): List<com.crichere.domain.league.entity.LeagueCategoryBasePrice> {
        return leagueCategoryBasePriceRepository.findByLeagueId(leagueId)
    }

    @Transactional
    fun updateTagPrices(leagueId: UUID, prices: List<com.crichere.domain.league.dto.TagPriceRequest>): List<com.crichere.domain.league.entity.LeagueTagBasePrice> {
        val league = getLeague(leagueId)
        if (league.status != LeagueStatus.DRAFT && league.status != LeagueStatus.OPEN) {
            throw BusinessLogicException("Cannot update prices after auction initialization", "error.invalid_league_status")
        }

        val existing = leagueTagBasePriceRepository.findByLeagueId(leagueId)
        leagueTagBasePriceRepository.deleteAll(existing)

        val newPrices = prices.map { 
            com.crichere.domain.league.entity.LeagueTagBasePrice(
                leagueId = leagueId,
                tag = it.tag,
                price = it.price
            )
        }
        return leagueTagBasePriceRepository.saveAll(newPrices)
    }

    fun getTagPrices(leagueId: UUID): List<com.crichere.domain.league.entity.LeagueTagBasePrice> {
        return leagueTagBasePriceRepository.findByLeagueId(leagueId)
    }

    @Transactional(readOnly = true)
    fun resolveBasePrice(leaguePlayerId: UUID): Int {
        val player = leaguePlayerRepository.findById(leaguePlayerId)
            .orElseThrow { ResourceNotFoundException("League player not found", "error.league_player_not_found") }
        
        return resolveBasePrice(player)
    }

    fun resolveBasePrice(player: LeaguePlayer): Int {
        // Priority 1: basePriceOverride
        if (player.basePriceOverride != null) {
            return player.basePriceOverride!!
        }

        // Priority 2: LeagueTagBasePrice
        if (player.tag != null) {
            val tagPrice = leagueTagBasePriceRepository.findByLeagueIdAndTag(player.leagueId, player.tag!!)
            if (tagPrice != null) {
                return tagPrice.price
            }
        }

        // Priority 3: LeagueCategoryBasePrice
        if (player.category != null) {
            val categoryPrice = leagueCategoryBasePriceRepository.findByLeagueIdAndCategory(player.leagueId, player.category!!)
            if (categoryPrice != null) {
                return categoryPrice.price
            }
        }

        return 0
    }
}
