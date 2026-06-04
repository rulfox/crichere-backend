package com.crichere.domain.auth.usecase

import com.crichere.common.domain.Result
import com.crichere.common.provider.SmsProvider
import com.crichere.domain.auth.dto.ClaimProfileRequest
import com.crichere.domain.auth.entity.Otp
import com.crichere.domain.auth.entity.RefreshToken
import com.crichere.domain.auth.entity.User
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.auth.error.AuthDomainError
import com.crichere.domain.auth.repository.OtpRepository
import com.crichere.domain.auth.repository.RefreshTokenRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.security.JwtTokenProvider
import com.crichere.security.OtpRateLimiter
import com.crichere.security.TokenBlacklistService
import io.micrometer.core.instrument.MeterRegistry
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.time.temporal.ChronoUnit
import java.util.UUID
import kotlin.random.Random

interface SendOtpUseCase {
    fun execute(phone: String, ip: String?): Result<Unit, AuthDomainError>
}

interface VerifyOtpAndLoginUseCase {
    fun execute(phone: String, code: String, ip: String?): Result<Map<String, Any>, AuthDomainError>
}

interface RefreshAccessTokenUseCase {
    fun execute(token: String): Result<Map<String, String>, AuthDomainError>
}

interface LogoutUseCase {
    fun execute(userId: UUID, accessToken: String?): Result<Unit, AuthDomainError>
}

interface ClaimProfileUseCase {
    fun execute(userId: UUID, request: ClaimProfileRequest): Result<Unit, AuthDomainError>
}

@Service
class SendOtpUseCaseImpl(
    private val otpRateLimiter: OtpRateLimiter,
    private val otpRepository: OtpRepository,
    private val smsProvider: SmsProvider,
    private val meterRegistry: MeterRegistry
) : SendOtpUseCase {
    private val otpSentCounter = meterRegistry.counter("crichere.otp.sent")

    @Transactional
    override fun execute(phone: String, ip: String?): Result<Unit, AuthDomainError> {
        try {
            otpRateLimiter.checkSend(phone, ip)
        } catch (e: com.crichere.common.exception.BusinessLogicException) {
            return Result.Failure(AuthDomainError.OtpRateLimitExceeded(phone))
        }

        if (!phone.matches(Regex("^[6-9]\\d{9}$"))) {
            return Result.Failure(AuthDomainError.InvalidPhone)
        }

        val count = otpRepository.countByPhoneAndCreatedAtAfter(phone, Instant.now().minus(1, ChronoUnit.HOURS))
        if (count >= 5) {
            return Result.Failure(AuthDomainError.OtpRateLimitExceeded(phone))
        }

        val pendingOtps = otpRepository.findAllByPhoneAndIsVerifiedFalse(phone)
        pendingOtps.forEach { it.expiresAt = Instant.now() }
        otpRepository.saveAll(pendingOtps)

        val code = (100000 + Random.nextInt(900000)).toString()
        val expiresAt = Instant.now().plus(5, ChronoUnit.MINUTES)

        otpRepository.save(Otp(phone = phone, code = code, expiresAt = expiresAt))
        smsProvider.sendOtp(phone, code)
        otpSentCounter.increment()
        
        return Result.Success(Unit)
    }
}

@Service
class VerifyOtpAndLoginUseCaseImpl(
    private val otpRateLimiter: OtpRateLimiter,
    private val otpRepository: OtpRepository,
    private val userRepository: UserRepository,
    private val refreshTokenRepository: RefreshTokenRepository,
    private val jwtTokenProvider: JwtTokenProvider,
    private val meterRegistry: MeterRegistry,
    @param:Value("\${crichere.jwt.refresh-expiration-days}") private val refreshExpirationDays: Long
) : VerifyOtpAndLoginUseCase {
    private val otpVerifiedCounter = meterRegistry.counter("crichere.otp.verified")

    @Transactional
    override fun execute(phone: String, code: String, ip: String?): Result<Map<String, Any>, AuthDomainError> {
        try {
            otpRateLimiter.checkVerify(phone, ip)
        } catch (e: com.crichere.common.exception.BusinessLogicException) {
            return Result.Failure(AuthDomainError.OtpRateLimitExceeded(phone))
        }

        val otp = otpRepository.findTopByPhoneOrderByCreatedAtDesc(phone)
            ?: return Result.Failure(AuthDomainError.OtpNotFound)

        if (otp.isVerified) return Result.Failure(AuthDomainError.OtpAlreadyVerified)
        if (otp.expiresAt.isBefore(Instant.now())) return Result.Failure(AuthDomainError.OtpExpired)
        if (otp.attempts >= 3) return Result.Failure(AuthDomainError.MaxAttemptsReached)

        if (otp.code != code) {
            otp.attempts += 1
            otpRepository.save(otp)
            return Result.Failure(AuthDomainError.InvalidOtpCode)
        }

        otp.isVerified = true
        otpRepository.save(otp)
        otpVerifiedCounter.increment()

        var user = userRepository.findByPhone(phone)
        if (user == null) {
            user = User(phone = phone, profileStatus = ProfileStatus.GHOST)
            userRepository.save(user)
        }

        val accessToken = jwtTokenProvider.createToken(user.id.toString())
        val refreshToken = createRefreshToken(user.id)

        return Result.Success(mapOf(
            "accessToken" to accessToken,
            "refreshToken" to refreshToken.token,
            "userId" to user.id,
            "profileStatus" to user.profileStatus
        ))
    }

    private fun createRefreshToken(userId: UUID): RefreshToken {
        val refreshToken = RefreshToken(
            token = UUID.randomUUID().toString(),
            userId = userId,
            expiresAt = Instant.now().plus(refreshExpirationDays, ChronoUnit.DAYS)
        )
        return refreshTokenRepository.save(refreshToken)
    }
}

@Service
class RefreshAccessTokenUseCaseImpl(
    private val refreshTokenRepository: RefreshTokenRepository,
    private val userRepository: UserRepository,
    private val jwtTokenProvider: JwtTokenProvider
) : RefreshAccessTokenUseCase {
    
    @Transactional
    override fun execute(token: String): Result<Map<String, String>, AuthDomainError> {
        val refreshToken = refreshTokenRepository.findByToken(token)
            ?: return Result.Failure(AuthDomainError.InvalidToken("Invalid refresh token"))

        if (refreshToken.revoked || refreshToken.expiresAt.isBefore(Instant.now())) {
            return Result.Failure(AuthDomainError.TokenExpiredOrRevoked())
        }

        val userOpt = userRepository.findById(refreshToken.userId)
        if (userOpt.isEmpty) {
            return Result.Failure(AuthDomainError.UserNotFound(refreshToken.userId))
        }

        val newAccessToken = jwtTokenProvider.createToken(userOpt.get().id.toString())
        return Result.Success(mapOf("accessToken" to newAccessToken))
    }
}

@Service
class LogoutUseCaseImpl(
    private val refreshTokenRepository: RefreshTokenRepository,
    private val jwtTokenProvider: JwtTokenProvider,
    private val tokenBlacklistService: TokenBlacklistService
) : LogoutUseCase {
    
    @Transactional
    override fun execute(userId: UUID, accessToken: String?): Result<Unit, AuthDomainError> {
        val tokens = refreshTokenRepository.findAllByUserIdAndRevokedFalse(userId)
        tokens.forEach { it.revoked = true }
        refreshTokenRepository.saveAll(tokens)

        if (accessToken != null && jwtTokenProvider.validateToken(accessToken)) {
            tokenBlacklistService.blacklist(accessToken, jwtTokenProvider.getExpiration(accessToken))
        }
        
        return Result.Success(Unit)
    }
}

@Service
class ClaimProfileUseCaseImpl(
    private val userRepository: UserRepository
) : ClaimProfileUseCase {
    
    @Transactional
    override fun execute(userId: UUID, request: ClaimProfileRequest): Result<Unit, AuthDomainError> {
        val userOpt = userRepository.findById(userId)
        if (userOpt.isEmpty) {
            return Result.Failure(AuthDomainError.UserNotFound(userId))
        }
        
        val user = userOpt.get()
        if (user.claimedAt != null) {
            return Result.Failure(AuthDomainError.ProfileAlreadyClaimed(userId))
        }

        user.name = request.name
        user.playingRole = request.playingRole
        user.profileStatus = ProfileStatus.ACTIVE
        user.claimedAt = Instant.now()

        userRepository.save(user)
        return Result.Success(Unit)
    }
}
