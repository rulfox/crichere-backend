package com.crichere.domain.auth.entity

import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "otps")
class Otp(
    @Id
    val id: UUID = UUID.randomUUID(),
    val phone: String,
    val code: String,
    var isVerified: Boolean = false,
    var attempts: Int = 0,
    val expiresAt: Instant,
    val createdAt: Instant = Instant.now()
)

@Entity
@Table(name = "refresh_tokens")
class RefreshToken(
    @Id
    val id: UUID = UUID.randomUUID(),
    @Column(unique = true, nullable = false)
    val token: String,
    val userId: UUID,
    val expiresAt: Instant,
    var revoked: Boolean = false,
    val createdAt: Instant = Instant.now()
)
