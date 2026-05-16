package com.crichere.domain

import com.crichere.common.MockConfig
import com.crichere.domain.auction.dto.*
import com.crichere.domain.auction.enums.*
import com.crichere.domain.auction.repository.*
import com.crichere.domain.auth.dto.*
import com.crichere.domain.auth.entity.User
import com.crichere.domain.auth.entity.UserLeagueMembership
import com.crichere.domain.auth.enums.LeagueRole
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.auth.repository.OtpRepository
import com.crichere.domain.auth.repository.UserLeagueMembershipRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.franchise.dto.*
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.dto.*
import com.crichere.domain.league.enums.*
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.player.repository.LeaguePlayerRepository
import com.crichere.security.JwtTokenProvider
import org.junit.jupiter.api.*
import org.junit.jupiter.api.Assertions.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.boot.test.web.client.TestRestTemplate
import org.springframework.context.annotation.Import
import org.springframework.http.*
import org.springframework.test.context.DynamicPropertyRegistry
import org.springframework.test.context.DynamicPropertySource
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.junit.jupiter.Container
import org.testcontainers.junit.jupiter.Testcontainers
import java.util.*

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@Testcontainers
@Import(MockConfig::class)
@DisplayName("E2E: 50 Players Signup → League → 5 Franchises → 2-Round Auction")
@TestMethodOrder(MethodOrderer.OrderAnnotation::class)
class E2EAuctionFlowTest {

    @Autowired lateinit var restTemplate: TestRestTemplate
    @Autowired lateinit var userRepository: UserRepository
    @Autowired lateinit var otpRepository: OtpRepository
    @Autowired lateinit var userLeagueMembershipRepository: UserLeagueMembershipRepository
    @Autowired lateinit var leaguePlayerRepository: LeaguePlayerRepository
    @Autowired lateinit var franchiseRepository: FranchiseRepository
    @Autowired lateinit var auctionRepository: AuctionRepository
    @Autowired lateinit var roundConfigRepository: AuctionRoundConfigRepository
    @Autowired lateinit var playerStateRepository: PlayerAuctionStateRepository
    @Autowired lateinit var jwtTokenProvider: JwtTokenProvider

    companion object {
        @Container
        val postgres: PostgreSQLContainer<*> = PostgreSQLContainer("postgres:16-alpine")
            .withDatabaseName("e2e_testdb")
            .withUsername("test")
            .withPassword("test")

        @Container
        val redis: GenericContainer<*> = GenericContainer("redis:7-alpine")
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

        data class PlayerCtx(val userId: UUID, val token: String, val phone: String, val name: String)

        var adminId: UUID? = null
        var adminToken: String? = null
        var leagueId: UUID? = null
        var auctionId: UUID? = null
        var round1Id: UUID? = null
        var round2Id: UUID? = null

        val playerContexts = mutableListOf<PlayerCtx>()
        val franchiseOwnerContexts = mutableListOf<PlayerCtx>()
        val franchiseIds = mutableListOf<UUID>()
        val leaguePlayerIds = mutableListOf<UUID>()
    }

    private fun headers(token: String?): HttpHeaders {
        val h = HttpHeaders()
        if (token != null) h.setBearerAuth(token)
        return h
    }

    private fun signupViaOtp(phone: String, name: String): PlayerCtx {
        // Send OTP (SMS is mocked, OTP saved to DB)
        val sendRes = restTemplate.postForEntity(
            "/auth/otp/send",
            OtpSendRequest(phone = phone),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, sendRes.statusCode, "OTP send failed for $phone")

        // Read OTP code directly from DB (no real SMS)
        val otp = otpRepository.findTopByPhoneOrderByCreatedAtDesc(phone)
            ?: fail("OTP not found in DB for $phone")

        // Verify OTP → creates user account, returns JWT
        val verifyRes = restTemplate.postForEntity(
            "/auth/otp/verify",
            OtpVerifyRequest(phone = phone, code = otp.code),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, verifyRes.statusCode, "OTP verify failed for $phone")
        val authData = verifyRes.body!!["data"] as Map<*, *>
        val token = authData["accessToken"] as String
        val userId = UUID.fromString(authData["userId"].toString())

        // Set display name (users created via OTP are ACTIVE, not GHOST, so use basic update)
        restTemplate.exchange(
            "/users/$userId/basic",
            HttpMethod.PUT,
            HttpEntity(UserBasicInfoRequest(name = name, email = null), headers(token)),
            Map::class.java
        )

        return PlayerCtx(userId = userId, token = token, phone = phone, name = name)
    }

    // ─────────────────────────────────────────────────────────
    // Phase 1 – Signup 50 players via full OTP flow
    // ─────────────────────────────────────────────────────────

    @Test
    @Order(1)
    @DisplayName("1. Signup 50 players via OTP flow")
    fun signup50Players() {
        for (i in 1..50) {
            val phone = "91${i.toString().padStart(8, '0')}"
            val ctx = signupViaOtp(phone = phone, name = "Player $i")
            playerContexts.add(ctx)
        }
        assertEquals(50, playerContexts.size, "Expected 50 player accounts")
    }

    // ─────────────────────────────────────────────────────────
    // Phase 2 – Signup 5 franchise owners via full OTP flow
    // ─────────────────────────────────────────────────────────

    @Test
    @Order(2)
    @DisplayName("2. Signup 5 franchise owners via OTP flow")
    fun signup5FranchiseOwners() {
        for (i in 1..5) {
            val phone = "92${i.toString().padStart(8, '0')}"
            val ctx = signupViaOtp(phone = phone, name = "Team Owner $i")
            franchiseOwnerContexts.add(ctx)
        }
        assertEquals(5, franchiseOwnerContexts.size, "Expected 5 franchise owner accounts")
    }

    // ─────────────────────────────────────────────────────────
    // Phase 3 – Admin creates league
    // ─────────────────────────────────────────────────────────

    @Test
    @Order(3)
    @DisplayName("3. Admin creates league and sets category prices")
    fun adminCreatesLeague() {
        // Create admin directly (bypasses OTP; admin is an internal user)
        val admin = userRepository.save(
            User(phone = "9000000000", profileStatus = ProfileStatus.ACTIVE, name = "League Admin")
        )
        adminId = admin.id
        adminToken = jwtTokenProvider.createToken(admin.id.toString())

        // Create league via API (LEAGUE_ADMIN membership auto-assigned inside LeagueService.createLeague)
        val createRes = restTemplate.exchange(
            "/leagues",
            HttpMethod.POST,
            HttpEntity(
                LeagueCreateRequest(
                    name = "E2E Test League",
                    playerOrderMode = PlayerOrderMode.FREE_PICK
                ),
                headers(adminToken)
            ),
            Map::class.java
        )
        assertEquals(HttpStatus.CREATED, createRes.statusCode, "League creation failed")
        val leagueData = createRes.body!!["data"] as Map<*, *>
        leagueId = UUID.fromString(leagueData["id"] as String)

        // Grant admin the AUCTIONEER role so they can control the auction
        userLeagueMembershipRepository.save(
            UserLeagueMembership(userId = adminId!!, leagueId = leagueId!!, role = LeagueRole.AUCTIONEER)
        )

        // Set base prices: all BATTERs and BOWLERs worth 1000 each
        val catRes = restTemplate.exchange(
            "/leagues/$leagueId/category-prices",
            HttpMethod.POST,
            HttpEntity(
                listOf(
                    CategoryPriceRequest("BATTER", 1000),
                    CategoryPriceRequest("BOWLER", 1000)
                ),
                headers(adminToken)
            ),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, catRes.statusCode, "Category prices update failed")
    }

    // ─────────────────────────────────────────────────────────
    // Phase 4 – 50 players join the league
    // ─────────────────────────────────────────────────────────

    @Test
    @Order(4)
    @DisplayName("4. 50 players join the league (bulk import sets auctionEligible=true)")
    fun playersJoinLeague() {
        // Build import list: first 25 as BATTERs, remaining 25 as BOWLERs
        val importRequests = playerContexts.mapIndexed { idx, ctx ->
            PlayerImportRequest(
                phone = ctx.phone,
                name = ctx.name,
                category = if (idx < 25) "BATTER" else "BOWLER",
                basePrice = 1000
            )
        }

        val importRes = restTemplate.exchange(
            "/leagues/$leagueId/players/bulk-import",
            HttpMethod.POST,
            HttpEntity(importRequests, headers(adminToken)),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, importRes.statusCode, "Bulk import failed")

        val result = importRes.body!!["data"] as Map<*, *>
        assertEquals(50, (result["added"] as Number).toInt(), "Expected 50 players added")
        assertEquals(0, (result["skipped"] as Number).toInt(), "Expected 0 players skipped")

        // Collect leaguePlayerIds for later auction use
        leaguePlayerIds.addAll(leaguePlayerRepository.findByLeagueId(leagueId!!).map { it.id })
        assertEquals(50, leaguePlayerIds.size, "Expected 50 LeaguePlayer records")
    }

    // ─────────────────────────────────────────────────────────
    // Phase 5 – Create 5 franchises; owners accept invites
    // ─────────────────────────────────────────────────────────

    @Test
    @Order(5)
    @DisplayName("5. Create 5 franchises and franchise owners accept invites")
    fun createFranchisesAndAcceptInvites() {
        franchiseOwnerContexts.forEachIndexed { idx, owner ->
            // Admin creates franchise, setting the owner upfront
            val createRes = restTemplate.exchange(
                "/franchises",
                HttpMethod.POST,
                HttpEntity(
                    FranchiseCreateRequest(
                        leagueId = leagueId!!,
                        name = "Team ${idx + 1}",
                        ownerId = owner.userId,
                        totalPurse = 100_000
                    ),
                    headers(adminToken)
                ),
                Map::class.java
            )
            assertEquals(HttpStatus.CREATED, createRes.statusCode, "Franchise ${idx + 1} creation failed")
            val franchiseData = createRes.body!!["data"] as Map<*, *>
            val franchiseId = UUID.fromString(franchiseData["id"] as String)
            franchiseIds.add(franchiseId)

            // Admin sends an invite to the franchise owner's email
            val inviteRes = restTemplate.exchange(
                "/franchises/$franchiseId/invites",
                HttpMethod.POST,
                HttpEntity(FranchiseInviteRequest(email = "${owner.phone}@test.com"), headers(adminToken)),
                Map::class.java
            )
            assertEquals(HttpStatus.CREATED, inviteRes.statusCode, "Invite creation failed for franchise ${idx + 1}")
            val inviteData = inviteRes.body!!["data"] as Map<*, *>
            val inviteToken = UUID.fromString(inviteData["token"] as String)

            // Franchise owner accepts the invite
            val acceptRes = restTemplate.exchange(
                "/franchises/accept",
                HttpMethod.POST,
                HttpEntity(InviteAcceptRequest(token = inviteToken), headers(owner.token)),
                Map::class.java
            )
            assertEquals(HttpStatus.OK, acceptRes.statusCode, "Franchise ${idx + 1} owner failed to accept invite")
        }

        assertEquals(5, franchiseIds.size, "Expected 5 franchise IDs")
        assertEquals(5, franchiseRepository.findByLeagueId(leagueId!!).size, "Expected 5 franchises in league")
    }

    // ─────────────────────────────────────────────────────────
    // Phase 6 – Initialize auction with 2 rounds
    // ─────────────────────────────────────────────────────────

    @Test
    @Order(6)
    @DisplayName("6. Initialize auction and configure 2 rounds")
    fun initializeAuctionAndConfigureRounds() {
        // DRAFT → OPEN
        val openRes = restTemplate.exchange(
            "/leagues/$leagueId/status",
            HttpMethod.PATCH,
            HttpEntity(LeagueStatusUpdateRequest(LeagueStatus.OPEN), headers(adminToken)),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, openRes.statusCode, "League status → OPEN failed")

        // OPEN → AUCTION_INITIALIZED (creates the Auction record)
        val initRes = restTemplate.exchange(
            "/leagues/$leagueId/status",
            HttpMethod.PATCH,
            HttpEntity(LeagueStatusUpdateRequest(LeagueStatus.AUCTION_INITIALIZED), headers(adminToken)),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, initRes.statusCode, "League status → AUCTION_INITIALIZED failed")

        auctionId = auctionRepository.findByLeagueId(leagueId!!)!!.id

        val bidSlabs = listOf(BidIncrementSlabDto(fromAmount = 0, toAmount = null, incrementBy = 500))

        // Round 1: fresh purse, full player pool
        val r1Res = restTemplate.exchange(
            "/auctions/$auctionId/rounds",
            HttpMethod.POST,
            HttpEntity(
                RoundConfigDto(
                    roundNumber = 1,
                    name = "Round 1 – BATTERs",
                    currencyType = CurrencyType.CASH,
                    purseAmount = 100_000,
                    purseSource = PurseSource.FRESH,
                    bidMode = BidMode.EACH_BID_RECORDED,
                    playerPoolSource = PlayerPoolSource.ALL_REGISTERED,
                    franchiseEligibilityRule = FranchiseEligibilityRule.ALL,
                    completionTrigger = CompletionTrigger.AUCTIONEER_MANUAL,
                    bidIncrementSlabs = bidSlabs
                ),
                headers(adminToken)
            ),
            Map::class.java
        )
        assertEquals(HttpStatus.CREATED, r1Res.statusCode, "Add round 1 failed")

        // Round 2: carry-over purse, only unsold players from round 1
        val r2Res = restTemplate.exchange(
            "/auctions/$auctionId/rounds",
            HttpMethod.POST,
            HttpEntity(
                RoundConfigDto(
                    roundNumber = 2,
                    name = "Round 2 – BOWLERs",
                    currencyType = CurrencyType.CASH,
                    purseAmount = null,
                    purseSource = PurseSource.CARRY_OVER,
                    bidMode = BidMode.EACH_BID_RECORDED,
                    playerPoolSource = PlayerPoolSource.UNSOLD_PREVIOUS_ROUND,
                    franchiseEligibilityRule = FranchiseEligibilityRule.ALL,
                    completionTrigger = CompletionTrigger.AUCTIONEER_MANUAL,
                    bidIncrementSlabs = bidSlabs
                ),
                headers(adminToken)
            ),
            Map::class.java
        )
        assertEquals(HttpStatus.CREATED, r2Res.statusCode, "Add round 2 failed")

        val rounds = roundConfigRepository.findByAuctionIdOrderByRoundNumberAsc(auctionId!!)
        assertEquals(2, rounds.size, "Expected 2 configured rounds")
        round1Id = rounds[0].id
        round2Id = rounds[1].id
    }

    // ─────────────────────────────────────────────────────────
    // Phase 7 – Round 1: sell first 25 players, unsold last 25
    // ─────────────────────────────────────────────────────────

    @Test
    @Order(7)
    @DisplayName("7. Round 1: auction first 25 players (sell), mark last 25 unsold")
    fun round1AuctionFirstHalf() {
        // Start auction – initializes PlayerAuctionState for all 50 players
        val startRes = restTemplate.exchange(
            "/auctions/$auctionId/start",
            HttpMethod.PATCH,
            HttpEntity(null, headers(adminToken)),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, startRes.statusCode, "Start auction failed")

        // Start round 1 – creates FranchisePurseState for each of the 5 franchises
        val r1StartRes = restTemplate.exchange(
            "/auctions/$auctionId/rounds/$round1Id/start",
            HttpMethod.PATCH,
            HttpEntity(null, headers(adminToken)),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, r1StartRes.statusCode, "Start round 1 failed")

        // Sell first 25 players: each gets 1 bid from a rotating franchise
        val round1Sellers = leaguePlayerIds.subList(0, 25)
        round1Sellers.forEachIndexed { i, lpId ->
            val buyingFranchise = franchiseIds[i % 5]

            // Auctioneer puts player up for bidding
            val putRes = restTemplate.exchange(
                "/auctions/$auctionId/player/put",
                HttpMethod.POST,
                HttpEntity(mapOf("leaguePlayerId" to lpId), headers(adminToken)),
                Map::class.java
            )
            assertEquals(HttpStatus.OK, putRes.statusCode, "Round 1 PUT failed for player ${i + 1} (lpId=$lpId)")

            // Franchise places a bid at base price
            val bidRes = restTemplate.exchange(
                "/auctions/$auctionId/bid",
                HttpMethod.POST,
                HttpEntity(BidRequest(franchiseId = buyingFranchise, bidAmount = 1_000), headers(adminToken)),
                Map::class.java
            )
            assertEquals(HttpStatus.OK, bidRes.statusCode, "Round 1 BID failed for player ${i + 1}")

            // Auctioneer sells the player to the winning franchise
            val sellRes = restTemplate.exchange(
                "/auctions/$auctionId/player/sold",
                HttpMethod.POST,
                HttpEntity(
                    PlayerSoldRequest(
                        leaguePlayerId = lpId,
                        franchiseId = buyingFranchise,
                        finalPrice = 1_000
                    ),
                    headers(adminToken)
                ),
                Map::class.java
            )
            assertEquals(HttpStatus.OK, sellRes.statusCode, "Round 1 SELL failed for player ${i + 1}")
        }

        // Mark the remaining 25 players as UNSOLD so they roll over to round 2
        val round1Unsold = leaguePlayerIds.subList(25, 50)
        round1Unsold.forEachIndexed { i, lpId ->
            // Must put up before marking unsold
            val putRes = restTemplate.exchange(
                "/auctions/$auctionId/player/put",
                HttpMethod.POST,
                HttpEntity(mapOf("leaguePlayerId" to lpId), headers(adminToken)),
                Map::class.java
            )
            assertEquals(HttpStatus.OK, putRes.statusCode, "Round 1 PUT (for unsold) failed for player index ${25 + i}")

            val unsoldRes = restTemplate.exchange(
                "/auctions/$auctionId/player/unsold",
                HttpMethod.POST,
                HttpEntity(mapOf("leaguePlayerId" to lpId), headers(adminToken)),
                Map::class.java
            )
            assertEquals(HttpStatus.OK, unsoldRes.statusCode, "Round 1 UNSOLD failed for player index ${25 + i}")
        }

        // Complete round 1
        val completeR1 = restTemplate.exchange(
            "/auctions/$auctionId/rounds/$round1Id/complete",
            HttpMethod.PATCH,
            HttpEntity(null, headers(adminToken)),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, completeR1.statusCode, "Complete round 1 failed")

        // Verify intermediate state: 25 sold, 25 unsold
        val states = playerStateRepository.findByAuctionId(auctionId!!)
        val soldCount = states.count { it.state == com.crichere.domain.auction.enums.PlayerAuctionStateValue.SOLD }
        val unsoldCount = states.count { it.state == com.crichere.domain.auction.enums.PlayerAuctionStateValue.UNSOLD }
        assertEquals(25, soldCount, "Expected 25 players sold after round 1")
        assertEquals(25, unsoldCount, "Expected 25 players unsold after round 1")
    }

    // ─────────────────────────────────────────────────────────
    // Phase 8 – Round 2: sell the 25 unsold players
    // ─────────────────────────────────────────────────────────

    @Test
    @Order(8)
    @DisplayName("8. Round 2: auction the 25 unsold players from round 1")
    fun round2AuctionSecondHalf() {
        // Start round 2 – purse carries over from round 1 remainder
        val r2StartRes = restTemplate.exchange(
            "/auctions/$auctionId/rounds/$round2Id/start",
            HttpMethod.PATCH,
            HttpEntity(null, headers(adminToken)),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, r2StartRes.statusCode, "Start round 2 failed")

        // Sell the 25 players that were unsold in round 1
        val round2Players = leaguePlayerIds.subList(25, 50)
        round2Players.forEachIndexed { i, lpId ->
            val buyingFranchise = franchiseIds[i % 5]

            val putRes = restTemplate.exchange(
                "/auctions/$auctionId/player/put",
                HttpMethod.POST,
                HttpEntity(mapOf("leaguePlayerId" to lpId), headers(adminToken)),
                Map::class.java
            )
            assertEquals(HttpStatus.OK, putRes.statusCode, "Round 2 PUT failed for player index ${25 + i}")

            val bidRes = restTemplate.exchange(
                "/auctions/$auctionId/bid",
                HttpMethod.POST,
                HttpEntity(BidRequest(franchiseId = buyingFranchise, bidAmount = 1_000), headers(adminToken)),
                Map::class.java
            )
            assertEquals(HttpStatus.OK, bidRes.statusCode, "Round 2 BID failed for player index ${25 + i}")

            val sellRes = restTemplate.exchange(
                "/auctions/$auctionId/player/sold",
                HttpMethod.POST,
                HttpEntity(
                    PlayerSoldRequest(
                        leaguePlayerId = lpId,
                        franchiseId = buyingFranchise,
                        finalPrice = 1_000
                    ),
                    headers(adminToken)
                ),
                Map::class.java
            )
            assertEquals(HttpStatus.OK, sellRes.statusCode, "Round 2 SELL failed for player index ${25 + i}")
        }

        // Complete round 2
        val completeR2 = restTemplate.exchange(
            "/auctions/$auctionId/rounds/$round2Id/complete",
            HttpMethod.PATCH,
            HttpEntity(null, headers(adminToken)),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, completeR2.statusCode, "Complete round 2 failed")
    }

    // ─────────────────────────────────────────────────────────
    // Phase 9 – Complete auction and verify final state
    // ─────────────────────────────────────────────────────────

    @Test
    @Order(9)
    @DisplayName("9. Complete auction and verify all 50 players sold across 5 franchises")
    fun completeAuctionAndVerify() {
        // Complete the auction
        val completeRes = restTemplate.exchange(
            "/auctions/$auctionId/complete",
            HttpMethod.PATCH,
            HttpEntity(null, headers(adminToken)),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, completeRes.statusCode, "Complete auction failed")

        // Verify auction state: all 50 players sold
        val finalStates = playerStateRepository.findByAuctionId(auctionId!!)
        assertEquals(50, finalStates.size, "Expected 50 player auction state records")
        val totalSold = finalStates.count { it.state == com.crichere.domain.auction.enums.PlayerAuctionStateValue.SOLD }
        assertEquals(50, totalSold, "Expected all 50 players to be SOLD")

        // Verify summary endpoint
        val summaryRes = restTemplate.exchange(
            "/auctions/$auctionId/summary",
            HttpMethod.GET,
            HttpEntity(null, headers(adminToken)),
            Map::class.java
        )
        assertEquals(HttpStatus.OK, summaryRes.statusCode)
        val summary = summaryRes.body!!["data"] as Map<*, *>
        assertEquals(50, (summary["totalPlayers"] as Number).toInt(), "totalPlayers mismatch")
        assertEquals(50, (summary["totalSold"] as Number).toInt(), "totalSold mismatch")
        assertEquals(0, (summary["totalUnsold"] as Number).toInt(), "totalUnsold should be 0")
        assertEquals("COMPLETED", summary["status"], "Auction status should be COMPLETED")

        // Each franchise should have exactly 10 players
        @Suppress("UNCHECKED_CAST")
        val franchiseSummaries = summary["franchiseSummaries"] as List<Map<*, *>>
        assertEquals(5, franchiseSummaries.size, "Expected 5 franchise summaries")
        franchiseSummaries.forEach { fs ->
            assertEquals(10, (fs["squadCount"] as Number).toInt(), "Each franchise should have 10 players")
            assertEquals(10_000L, (fs["totalSpent"] as Number).toLong(), "Each franchise should have spent 10,000")
        }
    }
}
