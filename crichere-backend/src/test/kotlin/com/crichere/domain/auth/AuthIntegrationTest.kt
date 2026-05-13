package com.crichere.domain.auth

import com.crichere.domain.auth.dto.*
import com.crichere.domain.auth.entity.User
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.auth.enums.PlayingRole
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.auth.repository.OtpRepository
import com.crichere.common.provider.SmsProvider
import com.crichere.common.provider.PushProvider
import software.amazon.awssdk.services.s3.presigner.S3Presigner
import io.mockk.every
import io.mockk.mockk
import io.mockk.just
import io.mockk.runs
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.boot.test.context.TestConfiguration
import org.springframework.boot.test.web.client.TestRestTemplate
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Primary
import org.springframework.http.HttpEntity
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.test.context.DynamicPropertyRegistry
import org.springframework.test.context.DynamicPropertySource
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.containers.GenericContainer
import org.testcontainers.junit.jupiter.Container
import org.testcontainers.junit.jupiter.Testcontainers
import org.springframework.data.redis.core.StringRedisTemplate
import com.crichere.common.MockConfig
import org.springframework.context.annotation.Import
import java.util.*

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@Testcontainers
@Import(MockConfig::class)
@DisplayName("Authentication Integration Tests")
class AuthIntegrationTest {

    @Autowired
    lateinit var restTemplate: TestRestTemplate

    @Autowired
    lateinit var userRepository: UserRepository

    @Autowired
    lateinit var otpRepository: OtpRepository

    companion object {
        @Container
        val postgres = PostgreSQLContainer("postgres:16-alpine")
            .withDatabaseName("testdb")
            .withUsername("test")
            .withPassword("test")

        @Container
        val redis = GenericContainer("redis:7-alpine")
            .withExposedPorts(6379)

        @JvmStatic
        @DynamicPropertySource
        fun properties(registry: DynamicPropertyRegistry) {
            registry.add("spring.datasource.url", postgres::getJdbcUrl)
            registry.add("spring.datasource.username", postgres::getUsername)
            registry.add("spring.datasource.password", postgres::getPassword)
            registry.add("spring.data.redis.host", redis::getHost)
            registry.add("spring.data.redis.port") { redis.getMappedPort(6379) }
            registry.add("spring.flyway.clean-disabled") { "false" }
        }
    }

    @Autowired
    lateinit var smsProvider: SmsProvider

    @Test
    @DisplayName("Full OTP login and token flow")
    fun fullOtpFlow() {
        val phone = "9123456789"
        
        // 1. POST /auth/otp/send
        every { smsProvider.sendOtp(eq(phone), any()) } just runs
        
        val sendResponse = restTemplate.postForEntity("/auth/otp/send", OtpSendRequest(phone), Map::class.java)
        assertEquals(HttpStatus.OK, sendResponse.statusCode)

        // Find OTP in DB
        val otp = otpRepository.findTopByPhoneOrderByCreatedAtDesc(phone)
        assertNotNull(otp)
        val code = otp!!.code

        // 2. POST /auth/otp/verify
        val verifyResponse = restTemplate.postForEntity("/auth/otp/verify", OtpVerifyRequest(phone, code), Map::class.java)
        assertEquals(HttpStatus.OK, verifyResponse.statusCode)
        
        val body = verifyResponse.body?.get("data") as Map<String, Any>
        val accessToken = body["accessToken"] as String
        val refreshToken = body["refreshToken"] as String
        val userId = body["userId"] as String

        val user = userRepository.findById(UUID.fromString(userId)).get()
        assertEquals(ProfileStatus.ACTIVE, user.profileStatus)

        // 3. GET /auth/me
        val headers = HttpHeaders()
        headers.setBearerAuth(accessToken)
        val meResponse = restTemplate.exchange("/auth/me", org.springframework.http.HttpMethod.GET, HttpEntity<Nothing>(headers), Map::class.java)
        assertEquals(HttpStatus.OK, meResponse.statusCode)
        val meData = meResponse.body?.get("data") as Map<String, Any>
        assertEquals(phone, meData["phone"])

        // 4. POST /auth/logout
        val logoutResponse = restTemplate.postForEntity("/auth/logout", HttpEntity<Nothing>(headers), Map::class.java)
        assertEquals(HttpStatus.OK, logoutResponse.statusCode)

        // 5. POST /auth/token/refresh with revoked token
        val refreshResponse = restTemplate.postForEntity("/auth/token/refresh", TokenRefreshRequest(refreshToken), Map::class.java)
        assertEquals(HttpStatus.UNAUTHORIZED, refreshResponse.statusCode)
    }

    @Test
    @DisplayName("Ghost profile claim flow")
    fun ghostProfileClaimFlow() {
        val phone = "9988776655"
        val ghostUser = userRepository.save(User(phone = phone, profileStatus = ProfileStatus.GHOST))

        // 1. Send OTP
        every { smsProvider.sendOtp(eq(phone), any()) } just runs
        restTemplate.postForEntity("/auth/otp/send", OtpSendRequest(phone), Map::class.java)
        val code = otpRepository.findTopByPhoneOrderByCreatedAtDesc(phone)!!.code

        // 2. Verify OTP to get token
        val verifyResponse = restTemplate.postForEntity("/auth/otp/verify", OtpVerifyRequest(phone, code), Map::class.java)
        val accessToken = (verifyResponse.body?.get("data") as Map<String, Any>)["accessToken"] as String

        // 3. Claim profile
        val headers = HttpHeaders()
        headers.setBearerAuth(accessToken)
        headers.contentType = MediaType.APPLICATION_JSON
        val claimRequest = ClaimProfileRequest(name = "Ghost Player", playingRole = PlayingRole.ALL_ROUNDER)
        val claimResponse = restTemplate.postForEntity("/auth/claim-profile", HttpEntity(claimRequest, headers), Map::class.java)
        
        assertEquals(HttpStatus.OK, claimResponse.statusCode)

        val updatedUser = userRepository.findById(ghostUser.id).get()
        assertEquals(ProfileStatus.ACTIVE, updatedUser.profileStatus)
        assertEquals("Ghost Player", updatedUser.name)
        assertNotNull(updatedUser.claimedAt)
    }
}
