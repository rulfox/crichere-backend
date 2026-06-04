package com.crichere.domain.admin.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.admin.error.AdminDomainError
import com.crichere.domain.auth.entity.User
import com.crichere.domain.auth.entity.UserLeagueMembership
import com.crichere.domain.auth.entity.UserPlatformMembership
import com.crichere.domain.auth.enums.LeagueRole
import com.crichere.domain.auth.repository.RefreshTokenRepository
import com.crichere.domain.auth.repository.UserLeagueMembershipRepository
import com.crichere.domain.auth.repository.UserPlatformMembershipRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.repository.LeagueRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

interface UpdateRoleUseCase {
    fun execute(userId: UUID, action: String, adminUserId: UUID): Result<User, AdminDomainError>
}

@Service
class UpdateRoleUseCaseImpl(
    private val userRepository: UserRepository,
    private val userPlatformMembershipRepository: UserPlatformMembershipRepository
) : UpdateRoleUseCase {
    @Transactional
    override fun execute(userId: UUID, action: String, adminUserId: UUID): Result<User, AdminDomainError> {
        val userOpt = userRepository.findById(userId)
        if (userOpt.isEmpty) return Result.Failure(AdminDomainError.UserNotFound(userId))
        val user = userOpt.get()

        if (action == "ADD") {
            if (userPlatformMembershipRepository.findByUserId(userId) == null) {
                userPlatformMembershipRepository.save(UserPlatformMembership(userId = userId))
            }
        } else if (action == "REMOVE") {
            if (userId == adminUserId) {
                return Result.Failure(AdminDomainError.CannotRemoveOwnRole)
            }
            userPlatformMembershipRepository.findByUserId(userId)?.let {
                userPlatformMembershipRepository.delete(it)
            }
        }
        return Result.Success(user)
    }
}

interface UpdateLeagueRoleUseCase {
    fun execute(leagueId: UUID, userId: UUID, role: LeagueRole, action: String): Result<Unit, AdminDomainError>
}

@Service
class UpdateLeagueRoleUseCaseImpl(
    private val userLeagueMembershipRepository: UserLeagueMembershipRepository
) : UpdateLeagueRoleUseCase {
    @Transactional
    override fun execute(leagueId: UUID, userId: UUID, role: LeagueRole, action: String): Result<Unit, AdminDomainError> {
        if (action == "ADD") {
            val existing = userLeagueMembershipRepository.findByUserIdAndLeagueId(userId, leagueId)
            if (existing == null) {
                userLeagueMembershipRepository.save(UserLeagueMembership(
                    userId = userId,
                    leagueId = leagueId,
                    role = role
                ))
            } else {
                existing.role = role
                userLeagueMembershipRepository.save(existing)
            }
        } else if (action == "REMOVE") {
            userLeagueMembershipRepository.findByUserIdAndLeagueId(userId, leagueId)?.let {
                userLeagueMembershipRepository.delete(it)
            }
        }
        return Result.Success(Unit)
    }
}

interface SuspendUserUseCase {
    fun execute(userId: UUID, suspended: Boolean, reason: String?): Result<User, AdminDomainError>
}

@Service
class SuspendUserUseCaseImpl(
    private val userRepository: UserRepository,
    private val refreshTokenRepository: RefreshTokenRepository
) : SuspendUserUseCase {
    @Transactional
    override fun execute(userId: UUID, suspended: Boolean, reason: String?): Result<User, AdminDomainError> {
        val userOpt = userRepository.findById(userId)
        if (userOpt.isEmpty) return Result.Failure(AdminDomainError.UserNotFound(userId))
        val user = userOpt.get()

        if (suspended && reason.isNullOrBlank()) {
            return Result.Failure(AdminDomainError.SuspensionReasonRequired)
        }
        
        user.suspended = suspended
        user.suspensionReason = reason
        
        if (suspended) {
            val tokens = refreshTokenRepository.findAllByUserIdAndRevokedFalse(userId)
            tokens.forEach { it.revoked = true }
            refreshTokenRepository.saveAll(tokens)
        }
        
        return Result.Success(userRepository.save(user))
    }
}

interface SuspendLeagueUseCase {
    fun execute(leagueId: UUID, suspended: Boolean, reason: String?): Result<League, AdminDomainError>
}

@Service
class SuspendLeagueUseCaseImpl(
    private val leagueRepository: LeagueRepository
) : SuspendLeagueUseCase {
    @Transactional
    override fun execute(leagueId: UUID, suspended: Boolean, reason: String?): Result<League, AdminDomainError> {
        val leagueOpt = leagueRepository.findById(leagueId)
        if (leagueOpt.isEmpty) return Result.Failure(AdminDomainError.LeagueNotFound(leagueId))
        val league = leagueOpt.get()

        if (suspended && reason.isNullOrBlank()) {
            return Result.Failure(AdminDomainError.SuspensionReasonRequired)
        }
        
        league.suspended = suspended
        league.suspensionReason = reason
        return Result.Success(leagueRepository.save(league))
    }
}
