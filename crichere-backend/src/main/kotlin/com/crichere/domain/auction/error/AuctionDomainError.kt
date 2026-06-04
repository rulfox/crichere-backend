package com.crichere.domain.auction.error

import com.crichere.common.domain.DomainError
import java.util.UUID

sealed class AuctionDomainError : DomainError {
    
    data class AuctionNotFound(val id: UUID) : AuctionDomainError() {
        override val message = "Auction not found with id: $id"
        override val messageKey = "error.auction_not_found"
    }

    data class RoundNotFound(val id: UUID) : AuctionDomainError() {
        override val message = "Round not found with id: $id"
        override val messageKey = "error.round_not_found"
    }

    data class FranchiseNotFound(val id: UUID) : AuctionDomainError() {
        override val message = "Franchise not found with id: $id"
        override val messageKey = "error.franchise_not_found"
    }

    object InvalidAuctionStatus : AuctionDomainError() {
        override val message = "Invalid auction status for this operation"
        override val messageKey = "error.invalid_auction_status"
    }

    object InvalidRoundStatus : AuctionDomainError() {
        override val message = "Invalid round status for this operation"
        override val messageKey = "error.invalid_round_status"
    }

    object NoActiveRound : AuctionDomainError() {
        override val message = "No active round for this auction"
        override val messageKey = "error.no_active_round"
    }

    object MustSellAllViolated : AuctionDomainError() {
        override val message = "Cannot complete: Players still unsold. Disable mustSellAll or sell all players first."
        override val messageKey = "error.must_sell_all_violated"
    }

    object PlayerNotEligible : AuctionDomainError() {
        override val message = "Player is not eligible for auction"
        override val messageKey = "error.player_not_eligible"
    }

    object InvalidPlayerState : AuctionDomainError() {
        override val message = "Player is not in a valid state for this operation"
        override val messageKey = "error.invalid_player_state"
    }

    object EmptyPool : AuctionDomainError() {
        override val message = "No available players in current pool"
        override val messageKey = "error.empty_pool"
    }

    object PlayerSelectionRequired : AuctionDomainError() {
        override val message = "Player selection required in FREE_PICK mode"
        override val messageKey = "error.player_selection_required"
    }

    object ManualSelectionDisabled : AuctionDomainError() {
        override val message = "Manual selection not allowed in RANDOM mode"
        override val messageKey = "error.manual_selection_disabled"
    }

    object InsufficientPurse : AuctionDomainError() {
        override val message = "Insufficient purse amount"
        override val messageKey = "error.insufficient_purse"
    }

    data class InvalidBidAmount(val reason: String) : AuctionDomainError() {
        override val message = reason
        override val messageKey = "error.invalid_bid_amount"
    }

    object PurseNotFound : AuctionDomainError() {
        override val message = "Franchise purse not found for this round"
        override val messageKey = "error.purse_not_found"
    }

    object NoActiveTimer : AuctionDomainError() {
        override val message = "No active timer to extend"
        override val messageKey = "error.no_active_timer"
    }

    object NoPlayerUp : AuctionDomainError() {
        override val message = "No player currently up for bidding"
        override val messageKey = "error.no_player_up"
    }

    object NoActiveBids : AuctionDomainError() {
        override val message = "No active bids to undo"
        override val messageKey = "error.no_active_bids"
    }

    object UndoNotLastAction : AuctionDomainError() {
        override val message = "Cannot undo: other auction actions occurred after the sale"
        override val messageKey = "error.undo_sold_not_last_action"
    }

    object PlayerNotFoundInPool : AuctionDomainError() {
        override val message = "Player not found in auction pool"
        override val messageKey = "error.player_not_found"
    }
}
