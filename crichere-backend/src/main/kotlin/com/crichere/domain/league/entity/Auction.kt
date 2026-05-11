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

    @Column(nullable = false, unique = true)
    val leagueId: UUID,

    @Column(name = "auctioneer_id")
    var auctioneerId: UUID? = null,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var status: AuctionStatus = AuctionStatus.DRAFT,

    @Column(name = "current_round_id")
    var currentRoundId: UUID? = null,

    @Column(name = "current_league_player_id")
    var currentLeaguePlayerId: UUID? = null,

    var startedAt: Instant? = null,
    var completedAt: Instant? = null,

    var timerStartedAt: Instant? = null,
    var timerDurationSeconds: Int? = null,

    @Column(nullable = false, unique = true)
    var publicViewToken: String = generateSecureToken(),

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now(),

    @Column(nullable = false)
    var updatedAt: Instant = Instant.now(),

    @Version
    var version: Long = 0
) {
    @PreUpdate
    fun preUpdate() {
        updatedAt = Instant.now()
    }

    companion object {
        fun generateSecureToken(): String {
            val bytes = ByteArray(32)
            java.security.SecureRandom().nextBytes(bytes)
            return java.util.HexFormat.of().formatHex(bytes)
        }
    }
}
