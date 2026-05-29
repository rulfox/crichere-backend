package com.crichere.domain.auction.enums

enum class CurrencyType {
    POINTS, CASH
}

enum class PurseSource {
    FRESH, CARRY_OVER
}

enum class BidMode {
    FINAL_BID_ONLY, EACH_BID_RECORDED
}

enum class PlayerPoolSource {
    ALL_REGISTERED, UNSOLD_PREVIOUS_ROUND, UNSOLD_ANY_PREVIOUS_ROUND, AUCTIONEER_CURATED
}

enum class FranchiseEligibilityRule {
    ALL, REMAINING_PURSE_GREATER_THAN_ZERO
}

enum class CompletionTrigger {
    PLAYER_POOL_EXHAUSTED, ALL_PURSE_EXHAUSTED, AUCTIONEER_MANUAL
}

enum class RoundStatus {
    PENDING, LIVE, COMPLETED
}

enum class BidStatus {
    ACTIVE, UNDONE
}

enum class PlayerAuctionStateValue {
    AVAILABLE, UP_FOR_BIDDING, SOLD, UNSOLD, WITHDRAWN, FORCE_ASSIGNED, PRE_ASSIGNED
}

enum class AuctionAction {
    PLAYER_UP, 
    BID_PLACED, 
    BID_UNDONE, 
    PLAYER_SOLD, 
    SOLD_REVERTED, 
    PLAYER_UNSOLD, 
    PLAYER_WITHDRAWN, 
    PLAYER_FORCE_ASSIGNED, 
    PLAYER_PRE_ASSIGNED, 
    ROUND_STARTED, 
    ROUND_COMPLETED, 
    AUCTION_STARTED, 
    AUCTION_PAUSED, 
    AUCTION_RESUMED, 
    AUCTION_COMPLETED,
    AUCTION_CANCELLED,
    TIMER_STARTED,
    TIMER_STOPPED,
    TIMER_RESET,
    TIMER_EXTENDED
}
