package com.crichere.domain.auth.repository

import com.crichere.domain.auth.entity.*
import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface UserPlatformMembershipRepository : JpaRepository<UserPlatformMembership, UUID> {
    fun findByUserId(userId: UUID): UserPlatformMembership?
}

interface UserLeagueMembershipRepository : JpaRepository<UserLeagueMembership, UUID> {
    fun findByUserIdAndLeagueId(userId: UUID, leagueId: UUID): UserLeagueMembership?
    fun findAllByUserId(userId: UUID): List<UserLeagueMembership>
}

interface UserFranchiseMembershipRepository : JpaRepository<UserFranchiseMembership, UUID> {
    fun findByUserIdAndFranchiseId(userId: UUID, franchiseId: UUID): UserFranchiseMembership?
    fun findAllByUserId(userId: UUID): List<UserFranchiseMembership>
}

interface OtpRepository : JpaRepository<Otp, UUID> {
    fun findTopByPhoneOrderByCreatedAtDesc(phone: String): Otp?
    fun findAllByPhoneAndIsVerifiedFalse(phone: String): List<Otp>
}

interface RefreshTokenRepository : JpaRepository<RefreshToken, UUID> {
    fun findByToken(token: String): RefreshToken?
    fun findAllByUserIdAndRevokedFalse(userId: UUID): List<RefreshToken>
}
