package com.crichere.domain.auth.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.common.exception.UnauthorizedException
import com.crichere.domain.auth.dto.ClaimProfileRequest
import com.crichere.domain.auth.entity.RefreshToken
import com.crichere.domain.auth.entity.User
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.auth.repository.RefreshTokenRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.security.JwtTokenProvider
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.time.temporal.ChronoUnit
import java.util.UUID

@Service
class AuthService(
    private val otpService: OtpService,
    private val userRepository: UserRepository,
    private val refreshTokenRepository: RefreshTokenRepository,
    private val jwtTokenProvider: JwtTokenProvider,
    @Value("\${crichere.jwt.refresh-expiration-days}") private val refreshExpirationDays: Long
) {

    fun sendOtp(phone: String) {
        otpService.generateAndSendOtp(phone)
    }

    @Transactional
    fun verifyOtpAndLogin(phone: String, code: String): Map<String, Any> {
        otpService.verifyOtp(phone, code)

        var user = userRepository.findByPhone(phone)
        if (user == null) {
            user = User(phone = phone, profileStatus = ProfileStatus.ACTIVE)
            userRepository.save(user)
        }

        val accessToken = jwtTokenProvider.createToken(user.id.toString())
        val refreshToken = createRefreshToken(user.id)

        return mapOf(
            "accessToken" to accessToken,
            "refreshToken" to refreshToken.token,
            "userId" to user.id,
            "profileStatus" to user.profileStatus
        )
    }

    private fun createRefreshToken(userId: UUID): RefreshToken {
        val refreshToken = RefreshToken(
            token = UUID.randomUUID().toString(),
            userId = userId,
            expiresAt = Instant.now().plus(refreshExpirationDays, ChronoUnit.DAYS)
        )
        return refreshTokenRepository.save(refreshToken)
    }

    @Transactional
    fun refreshAccessToken(token: String): Map<String, String> {
        val refreshToken = refreshTokenRepository.findByToken(token)
            ?: throw UnauthorizedException("Invalid refresh token", "error.invalid_refresh_token")

        if (refreshToken.revoked || refreshToken.expiresAt.isBefore(Instant.now())) {
            throw UnauthorizedException("Refresh token expired or revoked", "error.refresh_token_invalid")
        }

        val user = userRepository.findById(refreshToken.userId).orElseThrow {
            ResourceNotFoundException("User not found", "error.user_not_found")
        }

        val newAccessToken = jwtTokenProvider.createToken(user.id.toString())
        return mapOf("accessToken" to newAccessToken)
    }

    @Transactional
    fun logout(userId: UUID) {
        val tokens = refreshTokenRepository.findAllByUserIdAndRevokedFalse(userId)
        tokens.forEach { it.revoked = true }
        refreshTokenRepository.saveAll(tokens)
    }

    @Transactional
    fun claimProfile(userId: UUID, request: ClaimProfileRequest) {
        val user = userRepository.findById(userId).orElseThrow {
            ResourceNotFoundException("User not found", "error.user_not_found")
        }

        if (user.profileStatus != ProfileStatus.GHOST) {
            throw BusinessLogicException("Profile already claimed", "error.profile_already_claimed")
        }

        user.name = request.name
        user.playingRole = request.playingRole
        user.profileStatus = ProfileStatus.ACTIVE
        user.claimedAt = Instant.now()

        userRepository.save(user)
        // LeaguePlayer records created during bulk import already reference this user's id,
        // so no relinking is needed — they become visible automatically on profile activation.
    }
}
