package com.crichere.domain.auction.entity

import com.crichere.domain.auction.enums.BidStatus
import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "bids")
class Bid(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val auctionId: UUID,

    @Column(nullable = false)
    val roundId: UUID,

    @Column(nullable = false)
    val leaguePlayerId: UUID,

    @Column(nullable = false)
    val franchiseId: UUID,

    @Column(nullable = false)
    val bidAmount: Int,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var status: BidStatus = BidStatus.ACTIVE,

    @Column(nullable = false)
    val recordedBy: UUID,

    @Column(nullable = false)
    val bidAt: Instant = Instant.now()
)
