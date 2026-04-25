package com.crichere.domain.league.entity

import com.crichere.domain.league.enums.LeagueStatus
import com.crichere.domain.league.enums.WaitingListMode
import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "leagues")
class League(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    var name: String,

    var format: String? = null,
    
    @Column(name = "rules_url")
    var rulesUrl: String? = null,
    
    @Column(name = "must_sell_all", nullable = false)
    var mustSellAll: Boolean = false,
    
    @Enumerated(EnumType.STRING)
    @Column(name = "player_order_mode", nullable = false)
    var playerOrderMode: com.crichere.domain.league.enums.PlayerOrderMode = com.crichere.domain.league.enums.PlayerOrderMode.RANDOM,

    var logoUrl: String? = null,
    var bannerUrl: String? = null,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var status: LeagueStatus = LeagueStatus.DRAFT,

    @Column(nullable = false)
    val createdBy: UUID,

    @Enumerated(EnumType.STRING)
    @Column(name = "waiting_list_mode", nullable = false)
    var waitingListMode: WaitingListMode = WaitingListMode.ADMIN_PICKS,

    @Column(name = "plan_type")
    var planType: String? = null,

    @Column(name = "plan_expires_at")
    var planExpiresAt: Instant? = null,

    @Column(nullable = false)
    var suspended: Boolean = false,

    @Column(name = "suspension_reason")
    var suspensionReason: String? = null,

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
