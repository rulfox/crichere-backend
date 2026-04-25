package com.crichere.domain.auction.entity

import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "bid_increment_slabs")
class BidIncrementSlab(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val roundId: UUID,

    @Column(nullable = false)
    val fromAmount: Int,

    var toAmount: Int? = null,

    @Column(nullable = false)
    val incrementBy: Int,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now()
)
