package com.crichere.domain.auction.entity

import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "auction_round_category_increments")
class AuctionRoundCategoryIncrement(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val roundId: UUID,

    var category: String? = null,
    var tag: String? = null,

    @Column(nullable = false)
    var bidIncrement: Int,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now()
)
