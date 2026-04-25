package com.crichere.domain.forfeit.entity

import com.crichere.domain.forfeit.enums.FeeRefundDecision
import com.crichere.domain.forfeit.enums.ForfeitStatus
import com.crichere.domain.forfeit.enums.ForfeitType
import jakarta.persistence.*
import java.time.Instant
import java.util.*

@Entity
@Table(name = "forfeit_requests")
class ForfeitRequest(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(name = "league_id", nullable = false)
    val leagueId: UUID,

    @Column(name = "user_id", nullable = false)
    val userId: UUID,

    @Column(name = "franchise_id")
    val franchiseId: UUID? = null,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    val type: ForfeitType,

    @Column(nullable = false)
    val reason: String,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var status: ForfeitStatus = ForfeitStatus.PENDING,

    @Enumerated(EnumType.STRING)
    @Column(name = "fee_refund_decision")
    var feeRefundDecision: FeeRefundDecision? = null,

    @Column(name = "fee_refund_amount")
    var feeRefundAmount: Int? = null,

    @Column(name = "admin_notes")
    var adminNotes: String? = null,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now(),

    @Column(name = "resolved_at")
    var resolvedAt: Instant? = null
)
