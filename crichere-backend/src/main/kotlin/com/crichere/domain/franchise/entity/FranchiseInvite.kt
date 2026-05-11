package com.crichere.domain.franchise.entity

import com.crichere.domain.franchise.enums.FranchiseInviteStatus
import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "franchise_invites")
class FranchiseInvite(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val franchiseId: UUID,

    @Column(nullable = false)
    val email: String,

    @Column(nullable = false, unique = true)
    val token: UUID = UUID.randomUUID(),

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var status: FranchiseInviteStatus = FranchiseInviteStatus.SENT,

    @Column(name = "accepted_by_user_id")
    var acceptedByUserId: UUID? = null,

    var acceptedAt: Instant? = null,

    @Column(nullable = false)
    var maxUses: Int = 1,

    @Column(nullable = false)
    var useCount: Int = 0,

    @Column(nullable = false)
    val expiresAt: Instant,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now()
)
