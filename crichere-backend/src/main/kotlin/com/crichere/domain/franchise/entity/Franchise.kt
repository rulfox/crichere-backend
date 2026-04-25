package com.crichere.domain.franchise.entity

import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "franchises")
class Franchise(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val leagueId: UUID,

    @Column(nullable = false)
    var name: String,

    var logoUrl: String? = null,

    @Column(nullable = false)
    var ownerId: UUID,

    @Column(nullable = false)
    var totalPurse: Int = 0,

    @Column(nullable = false)
    var remainingPurse: Int = 0,

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
