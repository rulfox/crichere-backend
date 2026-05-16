package com.crichere.domain.auction.entity

import jakarta.persistence.*
import java.util.UUID

@Entity
@Table(name = "auction_round_pool_players")
class AuctionRoundPoolPlayer(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val roundId: UUID,

    @Column(nullable = false)
    val leaguePlayerId: UUID
)
