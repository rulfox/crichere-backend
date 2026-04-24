package com.crichere.domain.auth.enums

enum class ProfileStatus {
    GHOST, CLAIMED, ACTIVE
}

enum class PlayingRole {
    BATTER, BOWLER, ALL_ROUNDER, WICKET_KEEPER
}

enum class BattingStyle {
    RIGHT_HAND, LEFT_HAND
}

enum class BowlingStyle {
    RIGHT_ARM, LEFT_ARM
}

enum class BowlingType {
    FAST, MEDIUM_FAST, MEDIUM, OFF_SPIN, LEG_SPIN, SLOW_LEFT_ARM, SLOW_LEFT_ARM_ORTHODOX
}

enum class ExperienceLevel {
    LOCAL, DISTRICT, STATE, NATIONAL
}

enum class LeagueRole {
    LEAGUE_ADMIN, AUCTIONEER
}
