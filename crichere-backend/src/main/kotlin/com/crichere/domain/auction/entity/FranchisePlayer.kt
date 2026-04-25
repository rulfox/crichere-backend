package com.crichere.domain.auction.entity

import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "franchise_players")
class FranchisePlayer(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val franchiseId: UUID,

    @Column(nullable = false, unique = true)
    val leaguePlayerId: UUID,

    @Column(nullable = false)
    val boughtPrice: Int,

    @Column(nullable = false)
    val roundId: UUID,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now()
)
