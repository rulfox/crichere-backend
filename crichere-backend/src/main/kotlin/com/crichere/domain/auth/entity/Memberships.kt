package com.crichere.domain.auth.entity

import com.crichere.domain.auth.enums.LeagueRole
import jakarta.persistence.*
import java.time.Instant
import java.util.UUID

@Entity
@Table(name = "user_platform_memberships")
class UserPlatformMembership(
    @Id
    val id: UUID = UUID.randomUUID(),
    val userId: UUID,
    val createdAt: Instant = Instant.now()
)

@Entity
@Table(name = "user_league_memberships")
class UserLeagueMembership(
    @Id
    val id: UUID = UUID.randomUUID(),
    val userId: UUID,
    val leagueId: UUID,
    @Enumerated(EnumType.STRING)
    val role: LeagueRole,
    val isPrimary: Boolean = false,
    val joinedAt: Instant = Instant.now()
)

@Entity
@Table(name = "user_franchise_memberships")
class UserFranchiseMembership(
    @Id
    val id: UUID = UUID.randomUUID(),
    val userId: UUID,
    val franchiseId: UUID,
    val joinedAt: Instant = Instant.now()
)
