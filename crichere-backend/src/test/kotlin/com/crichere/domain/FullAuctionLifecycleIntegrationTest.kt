package com.crichere.domain

import com.crichere.domain.auction.dto.*
import com.crichere.domain.auction.enums.*
import com.crichere.domain.auction.repository.*
import com.crichere.domain.auth.entity.*
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.auth.repository.*
import com.crichere.domain.franchise.dto.*
import com.crichere.domain.franchise.enums.FranchiseInviteStatus
import com.crichere.domain.franchise.repository.*
import com.crichere.domain.league.dto.*
import com.crichere.domain.league.enums.*
import com.crichere.domain.league.repository.*
import com.crichere.common.provider.SmsProvider
import com.crichere.common.provider.PushProvider
import com.crichere.security.JwtTokenProvider
import io.mockk.mockk
import org.junit.jupiter.api.*
import org.junit.jupiter.api.Assertions.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.boot.test.context.TestConfiguration
import org.springframework.boot.test.web.client.TestRestTemplate
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Primary
import org.springframework.http.*
import org.springframework.test.context.DynamicPropertyRegistry
import org.springframework.test.context.DynamicPropertySource
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.junit.jupiter.Container
import org.testcontainers.junit.jupiter.Testcontainers
import org.springframework.data.redis.core.StringRedisTemplate
import java.time.Instant
import java.util.*

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@Testcontainers
@DisplayName("Full Auction Lifecycle Integration Test")
@TestMethodOrder(MethodOrderer.OrderAnnotation::class)
class FullAuctionLifecycleIntegrationTest {

    @Autowired lateinit var restTemplate: TestRestTemplate
    @Autowired lateinit var userRepository: UserRepository
    @Autowired lateinit var leagueRepository: LeagueRepository
    @Autowired lateinit var auctionRepository: AuctionRepository
    @Autowired lateinit var roundConfigRepository: AuctionRoundConfigRepository
    @Autowired lateinit var jwtTokenProvider: JwtTokenProvider

    companion object {
        @Container
        val postgres = PostgreSQLContainer("postgres:16-alpine")
            .withDatabaseName("testdb")
            .withUsername("test")
            .withPassword("test")

        @JvmStatic
        @DynamicPropertySource
        fun properties(registry: DynamicPropertyRegistry) {
            registry.add("spring.datasource.url", postgres::getJdbcUrl)
            registry.add("spring.datasource.username", postgres::getUsername)
            registry.add("spring.datasource.password", postgres::getPassword)
            registry.add("app.base-url") { "http://localhost:8080" }
        }

        var adminId: UUID? = null
        var ownerId: UUID? = null
        var adminToken: String? = null
        var ownerToken: String? = null

        var leagueId: UUID? = null
        var franchiseId: UUID? = null
        var inviteToken: UUID? = null
        var auctionId: UUID? = null
        var roundId: UUID? = null
        var publicViewToken: String? = null
    }

    @TestConfiguration
    class TestConfig {
        @Bean @Primary fun smsProvider() = mockk<SmsProvider>(relaxed = true)
        @Bean @Primary fun pushProvider() = mockk<PushProvider>(relaxed = true)
        @Bean @Primary fun stringRedisTemplate() = mockk<StringRedisTemplate>(relaxed = true)
    }

    private fun getHeaders(token: String?): HttpHeaders {
        val headers = HttpHeaders()
        if (token != null) {
            headers.setBearerAuth(token)
        }
        return headers
    }

    @Test
    @Order(1)
    @DisplayName("1. Setup Users and Tokens")
    fun setupUsers() {
        val admin = userRepository.save(User(phone = "9000000001", profileStatus = ProfileStatus.ACTIVE, name = "Admin"))
        val owner = userRepository.save(User(phone = "9000000002", profileStatus = ProfileStatus.ACTIVE, name = "Owner"))
        
        adminId = admin.id
        ownerId = owner.id
        adminToken = jwtTokenProvider.createToken(admin.id.toString())
        ownerToken = jwtTokenProvider.createToken(owner.id.toString())
    }

    @Test
    @Order(2)
    @DisplayName("2. Create League and Configure Prices")
    fun createLeagueAndConfigPrices() {
        val createReq = LeagueCreateRequest(name = "E2E Test League")
        val createRes = restTemplate.exchange("/leagues", HttpMethod.POST, HttpEntity(createReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, createRes.statusCode)
        val data = createRes.body?.get("data") as Map<*, *>
        leagueId = UUID.fromString(data["id"] as String)

        val catReq = listOf(CategoryPriceRequest("BATTER", 1000), CategoryPriceRequest("BOWLER", 800))
        val catRes = restTemplate.exchange("/leagues/$leagueId/category-prices", HttpMethod.POST, HttpEntity(catReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, catRes.statusCode)

        val tagReq = listOf(TagPriceRequest("Star", 5000))
        val tagRes = restTemplate.exchange("/leagues/$leagueId/tag-prices", HttpMethod.POST, HttpEntity(tagReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, tagRes.statusCode)
    }

    @Test
    @Order(3)
    @DisplayName("3. Create Franchise and Invite Owner")
    fun createFranchiseAndInvite() {
        val createReq = FranchiseCreateRequest(leagueId = leagueId!!, name = "E2E Team", ownerId = adminId!!, totalPurse = 100000)
        val createRes = restTemplate.exchange("/franchises", HttpMethod.POST, HttpEntity(createReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, createRes.statusCode)
        val data = createRes.body?.get("data") as Map<*, *>
        franchiseId = UUID.fromString(data["id"] as String)

        val inviteReq = FranchiseInviteRequest(email = "owner@test.com")
        val inviteRes = restTemplate.exchange("/franchises/$franchiseId/invites", HttpMethod.POST, HttpEntity(inviteReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, inviteRes.statusCode)
        val inviteData = inviteRes.body?.get("data") as Map<*, *>
        inviteToken = UUID.fromString(inviteData["token"] as String)
    }

    @Test
    @Order(4)
    @DisplayName("4. Validate and Accept Invite")
    fun validateAndAcceptInvite() {
        val valRes = restTemplate.getForEntity("/public/invites/validate?token=$inviteToken", Map::class.java)
        assertEquals(HttpStatus.OK, valRes.statusCode)

        val acceptReq = InviteAcceptRequest(token = inviteToken!!)
        val acceptRes = restTemplate.exchange("/franchises/accept", HttpMethod.POST, HttpEntity(acceptReq, getHeaders(ownerToken)), Map::class.java)
        assertEquals(HttpStatus.OK, acceptRes.statusCode)
    }

    @Test
    @Order(5)
    @DisplayName("5. Initialize Auction and Configure Rounds")
    fun initializeAuctionAndConfigRounds() {
        val statusReq = LeagueStatusUpdateRequest(status = LeagueStatus.AUCTION_INITIALIZED)
        restTemplate.exchange("/leagues/$leagueId/status", HttpMethod.PATCH, HttpEntity(LeagueStatusUpdateRequest(status = LeagueStatus.OPEN), getHeaders(adminToken)), Map::class.java)
        val statusRes = restTemplate.exchange("/leagues/$leagueId/status", HttpMethod.PATCH, HttpEntity(statusReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, statusRes.statusCode)

        val auction = auctionRepository.findByLeagueId(leagueId!!)!!
        auctionId = auction.id
        publicViewToken = auction.publicViewToken

        val roundReq = RoundConfigDto(
            roundNumber = 1, name = "Round 1", currencyType = CurrencyType.CASH, purseAmount = 100000,
            purseSource = PurseSource.FRESH, bidMode = BidMode.EACH_BID_RECORDED, playerPoolSource = PlayerPoolSource.ALL_REGISTERED,
            franchiseEligibilityRule = FranchiseEligibilityRule.ALL, completionTrigger = CompletionTrigger.AUCTIONEER_MANUAL,
            bidIncrementSlabs = listOf(BidIncrementSlabDto(fromAmount = 0, toAmount = 5000, incrementBy = 500))
        )
        val roundRes = restTemplate.exchange("/auctions/$auctionId/rounds", HttpMethod.POST, HttpEntity(roundReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, roundRes.statusCode)
    }

    @Test
    @Order(6)
    @DisplayName("6. Configure Category Increments")
    fun configureCategoryIncrements() {
        val rounds = roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId!!)
        roundId = rounds.first().id

        val catIncReq = listOf(CategoryIncrementRequest(category = "BATTER", bidIncrement = 1000))
        val catIncRes = restTemplate.exchange("/auctions/$auctionId/rounds/$roundId/category-increments", HttpMethod.POST, HttpEntity(catIncReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, catIncRes.statusCode)
    }

    @Test
    @Order(7)
    @DisplayName("7. Start Auction, Start Timer, and Test Public Endpoints")
    fun startAuctionAndTestTimer() {
        val startRes = restTemplate.exchange("/auctions/$auctionId/start", HttpMethod.PATCH, HttpEntity(null, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, startRes.statusCode)

        val roundStartRes = restTemplate.exchange("/auctions/$auctionId/rounds/$roundId/start", HttpMethod.PATCH, HttpEntity(null, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, roundStartRes.statusCode)

        val playerReq = listOf(PlayerImportRequest(phone = "8000000000", name = "Test Player", category = "BATTER"))
        restTemplate.exchange("/leagues/$leagueId/players/bulk-import", HttpMethod.POST, HttpEntity(playerReq, getHeaders(adminToken)), Map::class.java)
        
        val player = userRepository.findByPhone("8000000000")!!
        // We need the leaguePlayerId. In integration test, we can query it.
        // Actually, just fetching the pool might be easier.
        val poolRes = restTemplate.exchange("/auctions/$auctionId/rounds/$roundId/player-pool", HttpMethod.GET, HttpEntity(null, getHeaders(adminToken)), List::class.java)
        val pool = poolRes.body as List<Map<String, Any>>
        val leaguePlayerId = pool.first()["leaguePlayerId"] as String
        
        val putReq = mapOf("leaguePlayerId" to leaguePlayerId)
        val putRes = restTemplate.exchange("/auctions/$auctionId/player/put", HttpMethod.POST, HttpEntity(putReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, putRes.statusCode)

        val timerReq = TimerStartRequest(durationSeconds = 120)
        val timerStartRes = restTemplate.exchange("/auctions/$auctionId/timer/start", HttpMethod.POST, HttpEntity(timerReq, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, timerStartRes.statusCode)

        val timerStateRes = restTemplate.exchange("/auctions/$auctionId/timer/state", HttpMethod.GET, HttpEntity(null, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, timerStateRes.statusCode)
        val timerData = timerStateRes.body?.get("data") as Map<*, *>
        assertTrue(timerData["isRunning"] as Boolean)

        val displayRes = restTemplate.getForEntity("/public/auctions/$auctionId/display", String::class.java)
        assertEquals(HttpStatus.OK, displayRes.statusCode)

        val viewRes = restTemplate.getForEntity("/public/auctions/view/$publicViewToken", Map::class.java)
        assertEquals(HttpStatus.OK, viewRes.statusCode)
        val viewData = viewRes.body?.get("data") as Map<*, *>
        assertEquals("LIVE", viewData["auctionStatus"])

        val timerStopRes = restTemplate.exchange("/auctions/$auctionId/timer/stop", HttpMethod.POST, HttpEntity(null, getHeaders(adminToken)), Map::class.java)
        assertEquals(HttpStatus.OK, timerStopRes.statusCode)
    }
}
