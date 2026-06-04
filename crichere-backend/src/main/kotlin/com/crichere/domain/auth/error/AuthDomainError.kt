package com.crichere.domain.auth.error

import com.crichere.common.domain.DomainError
import org.springframework.http.HttpStatus
import java.util.UUID

sealed class AuthDomainError(
    override val message: String,
    override val messageKey: String?,
    val httpStatus: HttpStatus = HttpStatus.BAD_REQUEST
) : DomainError {
    class OtpRateLimitExceeded(phone: String) : AuthDomainError("Too many OTP requests for $phone", "error.otp_rate_limit_exceeded", HttpStatus.TOO_MANY_REQUESTS)
    class InvalidOtp(phone: String) : AuthDomainError("Invalid or expired OTP for $phone", "error.invalid_otp", HttpStatus.BAD_REQUEST)
    class InvalidToken(msg: String) : AuthDomainError(msg, "error.invalid_token", HttpStatus.UNAUTHORIZED)
    class TokenExpiredOrRevoked : AuthDomainError("Token expired or revoked", "error.token_expired", HttpStatus.UNAUTHORIZED)
    class UserNotFound(userId: UUID) : AuthDomainError("User $userId not found", "error.user_not_found", HttpStatus.NOT_FOUND)
    class ProfileAlreadyClaimed(userId: UUID) : AuthDomainError("Profile for user $userId already claimed", "error.profile_already_claimed", HttpStatus.BAD_REQUEST)
    object InvalidPhone : AuthDomainError("Invalid Indian mobile number", "error.invalid_phone", HttpStatus.BAD_REQUEST)
    object OtpNotFound : AuthDomainError("No OTP found for this phone", "error.otp_not_found", HttpStatus.NOT_FOUND)
    object OtpAlreadyVerified : AuthDomainError("OTP already used", "error.otp_already_verified", HttpStatus.BAD_REQUEST)
    object OtpExpired : AuthDomainError("OTP expired", "error.otp_expired", HttpStatus.BAD_REQUEST)
    object MaxAttemptsReached : AuthDomainError("Maximum verification attempts reached", "error.otp_max_attempts", HttpStatus.BAD_REQUEST)
    object InvalidOtpCode : AuthDomainError("Invalid OTP code", "error.invalid_otp_code", HttpStatus.BAD_REQUEST)
}
