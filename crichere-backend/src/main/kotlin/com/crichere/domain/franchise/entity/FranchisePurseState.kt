package com.crichere.domain.franchise.entity

import com.crichere.domain.auction.enums.CurrencyType
import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(
    name = "franchise_purse_states",
    uniqueConstraints = [UniqueConstraint(columnNames = ["franchise_id", "round_id"])]
)
class FranchisePurseState(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val franchiseId: UUID,

    @Column(nullable = false)
    val auctionId: UUID,

    @Column(name = "round_id")
    var roundId: UUID? = null,

    @Enumerated(EnumType.STRING)
    var currencyType: CurrencyType? = null,

    var startingAmount: Int? = null,

    @Column(name = "current_amount", nullable = false)
    var currentAmount: Int,

    @Column(nullable = false)
    var reservedAmount: Int = 0,

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
}
