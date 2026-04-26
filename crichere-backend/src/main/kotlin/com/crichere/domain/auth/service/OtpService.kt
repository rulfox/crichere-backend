package com.crichere.domain.auth.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.InvalidOtpException
import com.crichere.common.provider.SmsProvider
import com.crichere.domain.auth.entity.Otp
import com.crichere.domain.auth.repository.OtpRepository
import io.micrometer.core.instrument.MeterRegistry
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.time.temporal.ChronoUnit
import kotlin.random.Random

@Service
class OtpService(
    private val otpRepository: OtpRepository,
    private val smsProvider: SmsProvider,
    private val meterRegistry: MeterRegistry
) {
    private val otpSentCounter = meterRegistry.counter("crichere.otp.sent")
    private val otpVerifiedCounter = meterRegistry.counter("crichere.otp.verified")

    @Transactional
    fun generateAndSendOtp(phone: String) {
        if (!phone.matches(Regex("^[6-9]\\d{9}$"))) {
            throw BusinessLogicException("Invalid Indian mobile number", "error.invalid_phone")
        }

        // Rate limit check before any mutation: max 5 sends per hour
        val count = otpRepository.countByPhoneAndCreatedAtAfter(phone, Instant.now().minus(1, ChronoUnit.HOURS))
        if (count >= 5) {
            throw BusinessLogicException("Too many OTP requests. Please try again later.", "error.otp_rate_limit_exceeded")
        }

        // Expire all pending OTPs for this phone
        val pendingOtps = otpRepository.findAllByPhoneAndIsVerifiedFalse(phone)
        pendingOtps.forEach { it.expiresAt = Instant.now() }
        otpRepository.saveAll(pendingOtps)

        val code = (100000 + Random.nextInt(900000)).toString()
        val expiresAt = Instant.now().plus(5, ChronoUnit.MINUTES)

        otpRepository.save(Otp(phone = phone, code = code, expiresAt = expiresAt))
        smsProvider.sendOtp(phone, code)
        otpSentCounter.increment()
    }

    @Transactional
    fun verifyOtp(phone: String, code: String): Boolean {
        val otp = otpRepository.findTopByPhoneOrderByCreatedAtDesc(phone)
            ?: throw InvalidOtpException("No OTP found for this phone", "error.otp_not_found")

        if (otp.isVerified) {
            throw InvalidOtpException("OTP already used", "error.otp_already_verified")
        }

        if (otp.expiresAt.isBefore(Instant.now())) {
            throw InvalidOtpException("OTP expired", "error.otp_expired")
        }

        if (otp.attempts >= 3) {
            throw InvalidOtpException("Maximum verification attempts reached", "error.otp_max_attempts")
        }

        if (otp.code != code) {
            otp.attempts += 1
            otpRepository.save(otp)
            throw InvalidOtpException("Invalid OTP code", "error.invalid_otp_code")
        }

        otp.isVerified = true
        otpRepository.save(otp)
        otpVerifiedCounter.increment()
        return true
    }
}
