package com.crichere.domain.admin.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.auth.entity.UserPlatformMembership
import com.crichere.domain.auth.repository.RefreshTokenRepository
import com.crichere.domain.auth.repository.UserPlatformMembershipRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.league.enums.LeagueStatus
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.domain.Specification
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Service
class PlatformAdminService(
    private val userRepository: UserRepository,
    private val leagueRepository: LeagueRepository,
    private val userPlatformMembershipRepository: UserPlatformMembershipRepository,
    private val refreshTokenRepository: RefreshTokenRepository
) {

    fun getUsers(profileStatus: ProfileStatus?, search: String?, pageable: Pageable): Page<com.crichere.domain.auth.entity.User> {
        // Simple search logic
        return if (search != null) {
            userRepository.findByNameContainingIgnoreCaseOrPhoneContaining(search, search, pageable)
        } else if (profileStatus != null) {
            userRepository.findByProfileStatus(profileStatus, pageable)
        } else {
            userRepository.findAll(pageable)
        }
    }

    @Transactional
    fun updateRole(userId: UUID, action: String, adminUserId: UUID): com.crichere.domain.auth.entity.User {
        val user = userRepository.findById(userId).orElseThrow { ResourceNotFoundException("User not found") }
        
        if (action == "ADD") {
            if (userPlatformMembershipRepository.findByUserId(userId) == null) {
                userPlatformMembershipRepository.save(UserPlatformMembership(userId = userId))
            }
        } else if (action == "REMOVE") {
            if (userId == adminUserId) {
                throw BusinessLogicException("Cannot remove own Platform Admin role", "error.cannot_remove_own_admin")
            }
            userPlatformMembershipRepository.findByUserId(userId)?.let {
                userPlatformMembershipRepository.delete(it)
            }
        }
        return user
    }

    @Transactional
    fun suspendUser(userId: UUID, suspended: Boolean, reason: String?): com.crichere.domain.auth.entity.User {
        val user = userRepository.findById(userId).orElseThrow { ResourceNotFoundException("User not found") }
        if (suspended && reason.isNullOrBlank()) {
             throw BusinessLogicException("Reason is required for suspension", "error.reason_required")
        }
        user.suspended = suspended
        user.suspensionReason = reason
        
        if (suspended) {
            val tokens = refreshTokenRepository.findAllByUserIdAndRevokedFalse(userId)
            tokens.forEach { it.revoked = true }
            refreshTokenRepository.saveAll(tokens)
        }
        
        return userRepository.save(user)
    }

    fun getLeagues(status: LeagueStatus?, search: String?, pageable: Pageable): Page<com.crichere.domain.league.entity.League> {
        return if (search != null) {
            leagueRepository.findByNameContainingIgnoreCase(search, pageable)
        } else if (status != null) {
            leagueRepository.findByStatus(status, pageable)
        } else {
            leagueRepository.findAll(pageable)
        }
    }

    @Transactional
    fun suspendLeague(leagueId: UUID, suspended: Boolean, reason: String?): com.crichere.domain.league.entity.League {
        val league = leagueRepository.findById(leagueId).orElseThrow { ResourceNotFoundException("League not found") }
        if (suspended && reason.isNullOrBlank()) {
             throw BusinessLogicException("Reason is required for suspension", "error.reason_required")
        }
        league.suspended = suspended
        league.suspensionReason = reason
        return leagueRepository.save(league)
    }

    fun getSubscriptions(pageable: Pageable): Page<com.crichere.domain.league.entity.League> {
        return leagueRepository.findAll(pageable)
    }
}
