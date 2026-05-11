package com.crichere.domain.auth.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.InvalidOtpException
import com.crichere.common.provider.SmsProvider
import com.crichere.domain.auth.entity.Otp
import com.crichere.domain.auth.repository.OtpRepository
import io.mockk.*
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.junit5.MockKExtension
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import java.time.Instant
import java.time.temporal.ChronoUnit

@ExtendWith(MockKExtension::class)
@DisplayName("OtpService Unit Tests")
class OtpServiceTest {

    @MockK lateinit var otpRepository: OtpRepository
    @MockK lateinit var smsProvider: SmsProvider
    @MockK lateinit var meterRegistry: io.micrometer.core.instrument.MeterRegistry

    lateinit var otpService: OtpService

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)
        val counter = mockk<io.micrometer.core.instrument.Counter>(relaxed = true)
        every { meterRegistry.counter(any()) } returns counter
        
        otpService = OtpService(otpRepository, smsProvider, meterRegistry)
    }

    private val phone = "9876543210"

    @Test
    @DisplayName("sendOtp - rate limit exceeded")
    fun sendOtpRateLimitExceeded() {
        every { otpRepository.countByPhoneAndCreatedAtAfter(phone, any()) } returns 5

        val exception = assertThrows(BusinessLogicException::class.java) {
            otpService.generateAndSendOtp(phone)
        }
        assertEquals("error.otp_rate_limit_exceeded", exception.messageKey)
        verify(exactly = 0) { smsProvider.sendOtp(any(), any()) }
    }

    @Test
    @DisplayName("verifyOtp - correct code")
    fun verifyOtpCorrectCode() {
        val otp = Otp(phone = phone, code = "123456", expiresAt = Instant.now().plus(5, ChronoUnit.MINUTES))
        
        every { otpRepository.findTopByPhoneOrderByCreatedAtDesc(phone) } returns otp
        every { otpRepository.save(any()) } answers { firstArg() }

        val result = otpService.verifyOtp(phone, "123456")

        assertTrue(result)
        assertTrue(otp.isVerified)
        verify { otpRepository.save(otp) }
    }

    @Test
    @DisplayName("verifyOtp - wrong code")
    fun verifyOtpWrongCode() {
        val otp = Otp(phone = phone, code = "123456", expiresAt = Instant.now().plus(5, ChronoUnit.MINUTES), attempts = 0)
        
        every { otpRepository.findTopByPhoneOrderByCreatedAtDesc(phone) } returns otp
        every { otpRepository.save(any()) } answers { firstArg() }

        val exception = assertThrows(InvalidOtpException::class.java) {
            otpService.verifyOtp(phone, "999999")
        }
        assertEquals("error.invalid_otp_code", exception.messageKey)
        assertEquals(1, otp.attempts)
        verify { otpRepository.save(otp) }
    }

    @Test
    @DisplayName("verifyOtp - max attempts exceeded")
    fun verifyOtpMaxAttemptsExceeded() {
        val otp = Otp(phone = phone, code = "123456", expiresAt = Instant.now().plus(5, ChronoUnit.MINUTES), attempts = 3)
        
        every { otpRepository.findTopByPhoneOrderByCreatedAtDesc(phone) } returns otp

        val exception = assertThrows(InvalidOtpException::class.java) {
            otpService.verifyOtp(phone, "123456")
        }
        assertEquals("error.otp_max_attempts", exception.messageKey)
    }

    @Test
    @DisplayName("verifyOtp - expired OTP")
    fun verifyOtpExpired() {
        val otp = Otp(phone = phone, code = "123456", expiresAt = Instant.now().minus(1, ChronoUnit.MINUTES))
        
        every { otpRepository.findTopByPhoneOrderByCreatedAtDesc(phone) } returns otp

        val exception = assertThrows(InvalidOtpException::class.java) {
            otpService.verifyOtp(phone, "123456")
        }
        assertEquals("error.otp_expired", exception.messageKey)
    }
}
