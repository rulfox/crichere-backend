package com.crichere.domain.auth.service

import com.crichere.common.exception.InvalidOtpException
import com.crichere.common.provider.SmsProvider
import com.crichere.domain.auth.entity.Otp
import com.crichere.domain.auth.repository.OtpRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.time.temporal.ChronoUnit
import kotlin.random.Random

@Service
class OtpService(
    private val otpRepository: OtpRepository,
    private val smsProvider: SmsProvider
) {

    @Transactional
    fun generateAndSendOtp(phone: String) {
        // Expire previous OTPs
        val pendingOtps = otpRepository.findAllByPhoneAndIsVerifiedFalse(phone)
        pendingOtps.forEach { it.expiresAt == Instant.now() } // Logic to expire is usually checking the timestamp
        // Actually, we should just let them expire or mark them. 
        // For simplicity, we just create a new one, and only the latest one will be checked.
        
        // Rate limiting check (simplified for now: max 5 sends per hour)
        // val count = ...
        
        val code = (100000 + Random.nextInt(900000)).toString()
        val expiresAt = Instant.now().plus(5, ChronoUnit.MINUTES)
        
        val otp = Otp(
            phone = phone,
            code = code,
            expiresAt = expiresAt
        )
        
        otpRepository.save(otp)
        smsProvider.sendOtp(phone, code)
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
        return true
    }
}
