package com.crichere.domain.auction.entity

import com.crichere.domain.auction.enums.PlayerAuctionStateValue
import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "player_auction_states")
class PlayerAuctionState(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val auctionId: UUID,

    @Column(nullable = false)
    val leaguePlayerId: UUID,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var state: PlayerAuctionStateValue = PlayerAuctionStateValue.AVAILABLE,

    var currentHighestBid: Int? = null,
    var currentHighestBidderId: UUID? = null,
    var finalPrice: Int? = null,
    var soldToFranchiseId: UUID? = null,

    @Column(nullable = false)
    var updatedAt: Instant = Instant.now()
) {
    @PreUpdate
    fun preUpdate() {
        updatedAt = Instant.now()
    }
}
