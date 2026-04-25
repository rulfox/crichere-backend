package com.crichere.domain.notification.entity

import com.crichere.domain.notification.enums.Platform
import jakarta.persistence.*
import java.time.Instant
import java.util.*

@Entity
@Table(
    name = "device_tokens",
    uniqueConstraints = [UniqueConstraint(columnNames = ["user_id", "token"])]
)
class DeviceToken(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(name = "user_id", nullable = false)
    val userId: UUID,

    @Column(nullable = false, length = 500)
    val token: String,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    val platform: Platform,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now()
)
