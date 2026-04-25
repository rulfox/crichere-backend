package com.crichere.domain.fee.entity

import com.crichere.domain.fee.enums.PaymentMode
import jakarta.persistence.*
import java.time.Instant
import java.util.*

@Entity
@Table(name = "fee_payments")
class FeePayment(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(name = "obligation_id", nullable = false)
    val obligationId: UUID,

    @Column(nullable = false)
    val amount: Int,

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_mode", nullable = false)
    val paymentMode: PaymentMode,

    val notes: String? = null,

    @Column(name = "recorded_by", nullable = false)
    val recordedBy: UUID,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now()
)
