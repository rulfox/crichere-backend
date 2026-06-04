package com.crichere.domain.league.error

import com.crichere.common.domain.DomainError
import com.crichere.domain.league.enums.LeagueStatus

/**
 * Errors specific to the League domain.
 */
sealed class LeagueDomainError : DomainError {
    
    data class LeagueNotFound(val id: java.util.UUID) : LeagueDomainError() {
        override val message = "League not found with id: $id"
        override val messageKey = "error.league_not_found"
    }

    data class InvalidStatusTransition(val current: LeagueStatus, val next: LeagueStatus) : LeagueDomainError() {
        override val message = "Invalid status transition from $current to $next"
        override val messageKey = "error.invalid_status_transition"
    }

    object AuctionAlreadyInitialized : LeagueDomainError() {
        override val message = "Auction already initialized for this league"
        override val messageKey = "error.auction_already_initialized"
    }

    object InvalidLeagueStatusForPriceUpdate : LeagueDomainError() {
        override val message = "Cannot update prices after auction initialization"
        override val messageKey = "error.invalid_league_status"
    }

    data class PlayerNotFound(val playerId: java.util.UUID) : LeagueDomainError() {
        override val message = "Player not found with id: $playerId"
        override val messageKey = "error.player_not_found"
    }

    object PlayerNotInLeague : LeagueDomainError() {
        override val message = "Player does not belong to this league"
        override val messageKey = "error.player_not_in_league"
    }
}
