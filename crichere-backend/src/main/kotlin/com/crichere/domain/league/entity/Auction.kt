package com.crichere.domain.league.entity

import com.crichere.domain.league.enums.AuctionStatus
import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "auctions")
class Auction(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val leagueId: UUID,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var status: AuctionStatus = AuctionStatus.PENDING,

    @Column(nullable = false)
    var currentRound: Int = 1,

    @Column(nullable = false)
    var totalRounds: Int = 1,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now(),

    @Column(nullable = false)
    var updatedAt: Instant = Instant.now()
) {
    @PreUpdate
    fun preUpdate() {
        updatedAt = Instant.now()
    }
}
