package com.crichere.domain

import com.crichere.domain.auction.dto.*
import com.crichere.domain.auth.dto.ClaimProfileRequest
import com.crichere.domain.auth.dto.OtpSendRequest
import com.crichere.domain.auth.dto.OtpVerifyRequest
import com.crichere.domain.auth.entity.UserLeagueMembership
import com.crichere.domain.auth.enums.LeagueRole
import com.crichere.domain.auth.enums.PlayingRole
import com.crichere.domain.auth.repository.OtpRepository
import com.crichere.domain.auth.repository.UserLeagueMembershipRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.franchise.dto.FranchiseCreateRequest
import com.crichere.domain.franchise.dto.FranchiseInviteRequest
import com.crichere.domain.league.dto.CategoryPriceRequest
import com.crichere.domain.league.dto.LeagueCreateRequest
import com.crichere.domain.league.dto.LeagueStatusUpdateRequest
import com.crichere.domain.league.dto.TagPriceRequest
import com.crichere.domain.league.enums.LeagueStatus
import com.crichere.domain.league.enums.PlayerOrderMode
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.auction.repository.AuctionRoundConfigRepository
import com.crichere.domain.auction.enums.*
import org.junit.jupiter.api.*
import org.junit.jupiter.api.Assertions.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.boot.test.web.client.TestRestTemplate
import org.springframework.http.*
import org.springframework.test.context.ActiveProfiles
import org.springframework.test.context.DynamicPropertyRegistry
import org.springframework.test.context.DynamicPropertySource
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.junit.jupiter.Container
import org.testcontainers.junit.jupiter.Testcontainers
import java.util.*

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
@TestMethodOrder(MethodOrderer.OrderAnnotation::class)
@Testcontainers
@DisplayName("Full Auction Lifecycle Integration Test")
class FullAuctionLifecycleIntegrationTest {

    @Autowired lateinit var restTemplate: TestRestTemplate
    @Autowired lateinit var userRepository: UserRepository
    @Autowired lateinit var otpRepository: OtpRepository
    @Autowired lateinit var userLeagueMembershipRepository: UserLeagueMembershipRepository
    @Autowired lateinit var auctionRepository: AuctionRepository
    @Autowired lateinit var roundConfigRepository: AuctionRoundConfigRepository

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
            registry.add("app.base-url") { "http://localhost:8080" }
        }

        private var adminToken: String? = null
        private var adminId: UUID? = null
        private var leagueId: UUID? = null
        private var franchiseId: UUID? = null
        private var auctionId: UUID? = null
        private var inviteToken: UUID? = null
        private var roundId: UUID? = null
        private var player1Id: UUID? = null
    }

    private fun getHeaders(token: String?): HttpHeaders {
        val headers = HttpHeaders()
        token?.let { headers.setBearerAuth(it) }
        return headers
    }

    @Test
    @Order(1)
    @DisplayName("1. Admin Signup and Login")
    fun adminSignup() {
        val phone = "9876543210"
        restTemplate.postForEntity("/auth/otp/send", OtpSendRequest(phone), Map::class.java)
        val otp = otpRepository.findTopByPhoneOrderByCreatedAtDesc(phone)!!
        
        val verifyRes = restTemplate.postForEntity("/auth/otp/verify", OtpVerifyRequest(phone, otp.code), Map::class.java)
        assertEquals(HttpStatus.OK, verifyRes.statusCode)
        
        val data = verifyRes.body?.get("data") as Map<*, *>
        adminToken = data["accessToken"] as String
        adminId = UUID.fromString(data["userId"] as String)

        val claimReq = ClaimProfileRequest(name = "Admin User", playingRole = PlayingRole.ALL_ROUNDER)
        val claimRes = restTemplate.exchange("/auth/claim-profile", HttpMethod.POST, HttpEntity(claimReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, claimRes.statusCode)
    }

    @Test
    @Order(2)
    @DisplayName("2. Create League and Configure Prices")
    fun createLeagueAndConfigPrices() {
        val createReq = LeagueCreateRequest(
            name = "E2E Test League",
            playerOrderMode = PlayerOrderMode.FREE_PICK
        )
        val createRes = restTemplate.exchange("/leagues", HttpMethod.POST, HttpEntity(createReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.CREATED, createRes.statusCode)
        val data = createRes.body?.get("data") as Map<*, *>
        leagueId = UUID.fromString(data["id"] as String)

        // Assign Roles to Admin
        userLeagueMembershipRepository.save(UserLeagueMembership(
            userId = adminId!!,
            leagueId = leagueId!!,
            role = LeagueRole.LEAGUE_ADMIN
        ))
        userLeagueMembershipRepository.save(UserLeagueMembership(
            userId = adminId!!,
            leagueId = leagueId!!,
            role = LeagueRole.AUCTIONEER
        ))

        val catReq = listOf(CategoryPriceRequest("BATTER", 1000), CategoryPriceRequest("BOWLER", 800))
        val catRes = restTemplate.exchange("/leagues/$leagueId/category-prices", HttpMethod.POST, HttpEntity(catReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, catRes.statusCode)

        val tagReq = listOf(TagPriceRequest("Star", 5000))
        val tagRes = restTemplate.exchange("/leagues/$leagueId/tag-prices", HttpMethod.POST, HttpEntity(tagReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, tagRes.statusCode)

        // Register a player
        val playerReq = com.crichere.domain.player.dto.PlayerRegisterRequest(
            leagueId = leagueId!!,
            userId = adminId!!, // Admin registers themselves as a player
            category = "BATTER"
        )
        val regRes = restTemplate.exchange("/players/register", HttpMethod.POST, HttpEntity(playerReq, getHeaders(adminToken)), Map::class.java)
        val playerData = regRes.body!!["data"] as Map<*, *>
        player1Id = UUID.fromString(playerData["id"] as String)

        // Mark eligible
        restTemplate.exchange("/leagues/$leagueId/players/$player1Id/eligible", HttpMethod.PATCH, HttpEntity(mapOf("eligible" to true), getHeaders(adminToken)), Map::class.java)
    }

    @Test
    @Order(3)
    @DisplayName("3. Create Franchise and Invite Owner")
    fun createFranchiseAndInvite() {
        val createReq = FranchiseCreateRequest(leagueId = leagueId!!, name = "E2E Team", ownerId = adminId!!, totalPurse = 100000)
        val createRes = restTemplate.exchange("/franchises", HttpMethod.POST, HttpEntity(createReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.CREATED, createRes.statusCode)
        val data = createRes.body?.get("data") as Map<*, *>
        franchiseId = UUID.fromString(data["id"] as String)

        val inviteReq = FranchiseInviteRequest(email = "owner@test.com")
        val inviteRes = restTemplate.exchange("/franchises/$franchiseId/invites", HttpMethod.POST, HttpEntity(inviteReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.CREATED, inviteRes.statusCode)
        val inviteData = inviteRes.body?.get("data") as Map<*, *>
        inviteToken = UUID.fromString(inviteData["token"] as String)
    }

    @Test
    @Order(4)
    @DisplayName("4. Validate and Accept Invite")
    fun validateAndAcceptInvite() {
        val valRes = restTemplate.getForEntity("/public/invites/validate?token=$inviteToken", Map::class.java)
        assertEquals(HttpStatus.OK, valRes.statusCode)

        val acceptRes = restTemplate.exchange("/franchises/accept", HttpMethod.POST, HttpEntity(mapOf("token" to inviteToken), getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, acceptRes.statusCode)
    }

    @Test
    @Order(5)
    @DisplayName("5. Initialize Auction and Configure Rounds")
    fun initAuctionAndConfigRounds() {
        // PATCH League status
        restTemplate.exchange("/leagues/$leagueId/status", HttpMethod.PATCH, HttpEntity(LeagueStatusUpdateRequest(LeagueStatus.OPEN), getHeaders(adminToken)), Map::class.java)
        val res = restTemplate.exchange("/leagues/$leagueId/status", HttpMethod.PATCH, HttpEntity(LeagueStatusUpdateRequest(LeagueStatus.AUCTION_INITIALIZED), getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, res.statusCode)

        auctionId = auctionRepository.findByLeagueId(leagueId!!)!!.id

        val roundReq = RoundConfigDto(
            roundNumber = 1,
            name = "Test Round",
            currencyType = CurrencyType.CASH,
            purseAmount = 50000,
            purseSource = PurseSource.FRESH,
            bidMode = BidMode.EACH_BID_RECORDED,
            playerPoolSource = PlayerPoolSource.ALL_REGISTERED,
            franchiseEligibilityRule = FranchiseEligibilityRule.ALL,
            completionTrigger = CompletionTrigger.AUCTIONEER_MANUAL,
            bidIncrementSlabs = listOf(BidIncrementSlabDto(0, null, 100))
        )
        val roundRes = restTemplate.exchange("/auctions/$auctionId/rounds", HttpMethod.POST, HttpEntity(roundReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.CREATED, roundRes.statusCode)
        
        roundId = roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId!!)[0].id
    }

    @Test
    @Order(6)
    @DisplayName("6. Configure Category Increments")
    fun configCategoryIncrements() {
        val incReq = listOf(CategoryIncrementRequest(category = "BATTER", bidIncrement = 500))
        val res = restTemplate.exchange("/auctions/$auctionId/rounds/$roundId/category-increments", HttpMethod.POST, HttpEntity(incReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, res.statusCode)
    }

    @Test
    @Order(7)
    @DisplayName("7. Start Auction, Start Timer, and Test Public Endpoints")
    fun startAuctionAndTestPublic() {
        val headers = getHeaders(adminToken)
        println("Headers for Method 7: $headers")
        
        val startRes = restTemplate.exchange("/auctions/$auctionId/start", HttpMethod.PATCH, HttpEntity(null, headers), Map::class.java)
        if (startRes.statusCode != HttpStatus.OK) {
            println("Start Auction Failed: ${startRes.statusCode} - ${startRes.body}")
        }
        assertEquals(HttpStatus.OK, startRes.statusCode)

        val roundStartRes = restTemplate.exchange("/auctions/$auctionId/rounds/$roundId/start", HttpMethod.PATCH, HttpEntity(null, headers), Map::class.java)
        assertEquals(HttpStatus.OK, roundStartRes.statusCode)

        val putPlayerRes = restTemplate.exchange("/auctions/$auctionId/player/put", HttpMethod.POST, HttpEntity(mapOf("leaguePlayerId" to player1Id), headers), Map::class.java)
        if (putPlayerRes.statusCode != HttpStatus.OK) {
            println("Put Player Failed: ${putPlayerRes.statusCode} - ${putPlayerRes.body}")
        }
        assertEquals(HttpStatus.OK, putPlayerRes.statusCode)
        
        val timerRes = restTemplate.exchange("/auctions/$auctionId/timer/start", HttpMethod.POST, HttpEntity(mapOf("durationSeconds" to 60), getHeaders(adminToken)), Map::class.java)
        if (timerRes.statusCode != HttpStatus.OK) {
            println("Start Timer Failed: ${timerRes.statusCode} - ${timerRes.body}")
        }
        assertEquals(HttpStatus.OK, timerRes.statusCode)
        
        val stateRes = restTemplate.exchange("/auctions/$auctionId/state", HttpMethod.GET, HttpEntity(null, getHeaders(adminToken)), Map::class.java)
        if (stateRes.statusCode != HttpStatus.OK) {
            println("Get State Failed: ${stateRes.statusCode} - ${stateRes.body}")
        }
        assertEquals(HttpStatus.OK, stateRes.statusCode)

        // Test public endpoints
        val auction = auctionRepository.findById(auctionId!!).get()
        val publicRes = restTemplate.getForEntity("/public/auctions/view/${auction.publicViewToken}", Map::class.java)
        assertEquals(HttpStatus.OK, publicRes.statusCode)
    }
}
