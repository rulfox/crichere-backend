package com.crichere.security

import com.crichere.domain.auction.repository.PlayerAuctionStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.repository.AuctionRepository
import org.springframework.security.core.Authentication
import org.springframework.stereotype.Component
import java.util.*

/**
 * Centralized scoped-authorization checks for auction endpoints.
 * Exposed in SpEL as `@auctionAuth.canManage(...)` / `@auctionAuth.canView(...)`.
 */
@Component("auctionAuth")
class AuctionAuthorization(
    private val auctionRepository: AuctionRepository,
    private val franchiseRepository: FranchiseRepository,
    private val playerStateRepository: PlayerAuctionStateRepository
) {

    /**
     * True if the caller can mutate this auction: PLATFORM_ADMIN, LEAGUE_ADMIN scoped
     * to the parent league, or the auctioneer assigned to this auction.
     */
    fun canManage(auctionId: UUID, auth: Authentication?): Boolean {
        if (auth == null) return false
        val authorities = auth.authorities.map { it.authority }.toSet()
        if ("ROLE_PLATFORM_ADMIN" in authorities) return true
        val auction = auctionRepository.findById(auctionId).orElse(null) ?: return false
        if ("ROLE_LEAGUE_ADMIN_${auction.leagueId}" in authorities) return true
        val userId = runCatching { UUID.fromString(auth.name) }.getOrNull() ?: return false
        if (auction.auctioneerId == userId) return true
        return false
    }

    /**
     * True if the caller can read live state of this auction: management roles,
     * any franchise owner participating in the parent league, or any player
     * registered in the auction's player pool.
     */
    fun canView(auctionId: UUID, auth: Authentication?): Boolean {
        if (auth == null) return false
        if (canManage(auctionId, auth)) return true
        val authorities = auth.authorities.map { it.authority }.toSet()
        val auction = auctionRepository.findById(auctionId).orElse(null) ?: return false
        val franchises = franchiseRepository.findByLeagueId(auction.leagueId)
        if (franchises.any { "ROLE_FRANCHISE_OWNER_${it.id}" in authorities }) return true
        val userId = runCatching { UUID.fromString(auth.name) }.getOrNull() ?: return false
        // Allow registered players in this auction's pool
        return playerStateRepository.existsByAuctionIdAndUserId(auctionId, userId)
    }
}
