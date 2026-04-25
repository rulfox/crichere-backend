package com.crichere.domain.league.entity

import com.crichere.domain.league.enums.LeagueStatus
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

    var logoUrl: String? = null,
    var bannerUrl: String? = null,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var status: LeagueStatus = LeagueStatus.DRAFT,

    @Column(nullable = false)
    val createdBy: UUID,

    @Column(name = "waiting_list_mode", nullable = false)
    var waitingListMode: String = "ADMIN_PICKS", // AUTO_PROMOTE, ADMIN_PICKS

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
