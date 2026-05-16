package com.crichere.security

import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.auth.repository.UserLeagueMembershipRepository
import com.crichere.domain.auth.repository.UserPlatformMembershipRepository
import com.crichere.domain.auth.repository.UserRepository
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.User
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.stereotype.Service
import java.util.*

@Service
class UserDetailsServiceImpl(
    private val userRepository: UserRepository,
    private val userLeagueMembershipRepository: UserLeagueMembershipRepository,
    private val userPlatformMembershipRepository: UserPlatformMembershipRepository,
    private val franchiseRepository: com.crichere.domain.franchise.repository.FranchiseRepository
) : UserDetailsService {

    override fun loadUserByUsername(username: String): UserDetails {
        val userId = try {
            UUID.fromString(username)
        } catch (e: IllegalArgumentException) {
            throw ResourceNotFoundException("Invalid user ID format", "error.invalid_user_id")
        }

        val user = userRepository.findById(userId).orElseThrow {
            ResourceNotFoundException("User not found", "error.user_not_found")
        }

        val authorities = mutableListOf<SimpleGrantedAuthority>()
        
        val leagueMemberships = userLeagueMembershipRepository.findAllByUserId(userId)
        leagueMemberships.forEach { membership ->
            // Add generic role for broad checks (if still needed) and scoped role for precise checks
            authorities.add(SimpleGrantedAuthority("ROLE_${membership.role.name}"))
            authorities.add(SimpleGrantedAuthority("ROLE_${membership.role.name}_${membership.leagueId}"))
        }

        val franchises = franchiseRepository.findByOwnerId(userId)
        if (franchises.isNotEmpty()) {
            authorities.add(SimpleGrantedAuthority("ROLE_FRANCHISE_OWNER"))
            franchises.forEach { f ->
                authorities.add(SimpleGrantedAuthority("ROLE_FRANCHISE_OWNER_${f.id}"))
            }
        }

        val platformMembership = userPlatformMembershipRepository.findByUserId(userId)
        if (platformMembership != null) {
            authorities.add(SimpleGrantedAuthority("ROLE_PLATFORM_ADMIN"))
        }

        return User.builder()
            .username(user.id.toString())
            .password("") // OTP-only, no password
            .disabled(user.suspended)
            .authorities(authorities)
            .build()
    }
}
