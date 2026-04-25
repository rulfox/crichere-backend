package com.crichere.domain.league.entity

import jakarta.persistence.*
import java.util.UUID

@Entity
@Table(name = "league_category_base_prices")
class LeagueCategoryBasePrice(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val leagueId: UUID,

    @Column(nullable = false)
    val category: String,

    @Column(nullable = false)
    val price: Int
)

@Entity
@Table(name = "league_tag_base_prices")
class LeagueTagBasePrice(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val leagueId: UUID,

    @Column(nullable = false)
    val tag: String,

    @Column(nullable = false)
    val price: Int
)
