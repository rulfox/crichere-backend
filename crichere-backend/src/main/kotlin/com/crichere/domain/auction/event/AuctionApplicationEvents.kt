package com.crichere.domain.auction.event

import java.util.UUID

data class AuctionStartedApplicationEvent(
    val auctionId: UUID,
    val leagueId: UUID,
    val leagueName: String,
    val franchiseOwnerIds: List<UUID>
)

data class PlayerSoldApplicationEvent(
    val auctionId: UUID,
    val leaguePlayerId: UUID,
    val userId: UUID,
    val franchiseId: UUID,
    val franchiseName: String,
    val franchiseOwnerId: UUID,
    val finalPrice: Int,
    val playerName: String
)
