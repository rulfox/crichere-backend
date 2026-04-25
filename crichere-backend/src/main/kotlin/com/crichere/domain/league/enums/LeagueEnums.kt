package com.crichere.domain.league.enums

enum class LeagueStatus {
    DRAFT, OPEN, AUCTION_INITIALIZED, AUCTION_IN_PROGRESS, AUCTION_COMPLETED, COMPLETED
}

enum class AuctionStatus {
    DRAFT, LIVE, PAUSED, COMPLETED
}

enum class PlayerOrderMode {
    RANDOM, FREE_PICK, HYBRID
}

enum class WaitingListMode {
    AUTO_PROMOTE, ADMIN_PICKS
}
