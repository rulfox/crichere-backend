package com.crichere.security

import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.auth.repository.UserRepository
import org.springframework.security.core.userdetails.User
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.stereotype.Service
import java.util.*

@Service
class UserDetailsServiceImpl(private val userRepository: UserRepository) : UserDetailsService {

    override fun loadUserByUsername(username: String): UserDetails {
        val userId = try {
            UUID.fromString(username)
        } catch (e: IllegalArgumentException) {
            throw ResourceNotFoundException("Invalid user ID format", "error.invalid_user_id")
        }

        val user = userRepository.findById(userId).orElseThrow {
            ResourceNotFoundException("User not found", "error.user_not_found")
        }

        return User.builder()
            .username(user.id.toString())
            .password("") // OTP-only, no password
            .disabled(user.profileStatus == ProfileStatus.GHOST)
            .authorities(emptyList()) // Roles handled by custom AuthorizationService
            .build()
    }
}
