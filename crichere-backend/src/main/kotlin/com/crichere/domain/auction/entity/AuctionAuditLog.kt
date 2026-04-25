package com.crichere.domain.auction.entity

import com.crichere.domain.auction.enums.AuctionAction
import jakarta.persistence.*
import org.hibernate.annotations.JdbcTypeCode
import org.hibernate.type.SqlTypes
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "auction_audit_logs")
class AuctionAuditLog(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(nullable = false)
    val auctionId: UUID,

    @Column(nullable = false)
    val sequenceNumber: Long,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    val action: AuctionAction,

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(nullable = false, columnDefinition = "jsonb")
    val payload: Map<String, Any?>,

    @Column(name = "actor_id")
    val actorId: UUID? = null,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now()
)
