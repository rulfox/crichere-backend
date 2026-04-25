package com.crichere.domain.auction.entity

import com.crichere.domain.auction.enums.*
import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "auction_round_configs")
class AuctionRoundConfig(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val auctionId: UUID,

    @Column(nullable = false)
    val roundNumber: Int,

    @Column(length = 100)
    var name: String? = null,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var currencyType: CurrencyType,

    var purseAmount: Int? = null,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var purseSource: PurseSource,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var bidMode: BidMode,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var playerPoolSource: PlayerPoolSource,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var franchiseEligibilityRule: FranchiseEligibilityRule,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var completionTrigger: CompletionTrigger,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var status: RoundStatus = RoundStatus.PENDING,

    var startedAt: Instant? = null,
    var completedAt: Instant? = null,

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
