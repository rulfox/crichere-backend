package com.crichere.domain.franchise.entity

import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "franchise_purse_states")
class FranchisePurseState(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val franchiseId: UUID,

    @Column(nullable = false)
    val auctionId: UUID,

    @Column(nullable = false)
    val roundNumber: Int,

    @Column(nullable = false)
    val initialPurse: Int,

    @Column(nullable = false)
    var remainingPurse: Int,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now()
)
