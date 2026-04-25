package com.crichere.domain.player.entity

import com.crichere.domain.player.enums.LeaguePlayerStatus
import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "league_players")
class LeaguePlayer(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val leagueId: UUID,

    @Column(nullable = false)
    val userId: UUID,

    @Column(name = "base_price_override")
    var basePriceOverride: Int? = null,

    var tag: String? = null,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var status: LeaguePlayerStatus = LeaguePlayerStatus.PENDING,

    var category: String? = null,

    @Column(name = "auction_eligible", nullable = false)
    var auctionEligible: Boolean = false,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now(),

    @Column(nullable = false)
    var updatedAt: Instant = Instant.now()
) {
    val basePrice: Int
        get() = basePriceOverride ?: 0

    @PreUpdate
    fun preUpdate() {
        updatedAt = Instant.now()
    }
}
