package com.crichere.domain.fee.entity

import com.crichere.domain.fee.enums.FeeStatus
import com.crichere.domain.fee.enums.FeeType
import jakarta.persistence.*
import java.time.Instant
import java.util.*

@Entity
@Table(
    name = "fee_obligations",
    uniqueConstraints = [UniqueConstraint(columnNames = ["league_id", "user_id", "fee_type"])]
)
class FeeObligation(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(name = "league_id", nullable = false)
    val leagueId: UUID,

    @Column(name = "user_id", nullable = false)
    val userId: UUID,

    @Column(name = "franchise_id")
    val franchiseId: UUID? = null,

    @Enumerated(EnumType.STRING)
    @Column(name = "fee_type", nullable = false)
    val feeType: FeeType,

    @Column(name = "total_amount", nullable = false)
    var totalAmount: Int,

    @Column(name = "minimum_to_register")
    var minimumToRegister: Int? = null,

    @Column(name = "paid_amount", nullable = false)
    var paidAmount: Int = 0,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var status: FeeStatus = FeeStatus.UNPAID,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now(),

    @Column(nullable = false)
    var updatedAt: Instant = Instant.now()
) {
    @PreUpdate
    fun preUpdate() {
        updatedAt = Instant.now()
    }

    fun recalculateStatus() {
        if (status == FeeStatus.WAIVED) return
        status = when {
            paidAmount <= 0 -> FeeStatus.UNPAID
            paidAmount < totalAmount -> FeeStatus.PARTIALLY_PAID
            else -> FeeStatus.PAID
        }
    }
}
