package com.crichere.domain.auth.entity

import com.crichere.domain.auth.enums.*
import jakarta.persistence.*
import java.time.Instant
import java.time.LocalDate
import java.util.UUID

@Entity
@Table(name = "users")
class User(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(unique = true, nullable = false)
    val phone: String,

    var name: String? = null,

    @Column(unique = true)
    var email: String? = null,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var profileStatus: ProfileStatus = ProfileStatus.GHOST,

    var profilePhoto: String? = null,

    @Enumerated(EnumType.STRING)
    var playingRole: PlayingRole? = null,

    @Enumerated(EnumType.STRING)
    var battingStyle: BattingStyle? = null,

    @Enumerated(EnumType.STRING)
    var bowlingStyle: BowlingStyle? = null,

    @Enumerated(EnumType.STRING)
    var bowlingType: BowlingType? = null,

    @Enumerated(EnumType.STRING)
    var experienceLevel: ExperienceLevel? = null,

    var dateOfBirth: LocalDate? = null,
    var gender: String? = null,
    var city: String? = null,
    var state: String? = null,
    var jerseyNumber: Int? = null,
    val createdBy: UUID? = null,
    var claimedAt: Instant? = null,

    @Column(nullable = false)
    var suspended: Boolean = false,

    @Column(name = "suspension_reason")
    var suspensionReason: String? = null,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now()
)
