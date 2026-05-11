package com.crichere.domain.auction.service

import com.crichere.domain.auction.dto.*
import com.crichere.domain.auction.entity.*
import com.crichere.domain.auction.enums.*
import com.crichere.domain.auction.repository.*
import com.crichere.domain.franchise.entity.*
import com.crichere.domain.franchise.repository.*
import com.crichere.domain.league.entity.Auction
import com.crichere.domain.league.enums.AuctionStatus
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.notification.service.NotificationService
import com.crichere.domain.league.service.LeagueService
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.repository.LeaguePlayerRepository
import com.fasterxml.jackson.databind.ObjectMapper
import io.mockk.*
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.springframework.data.redis.core.StringRedisTemplate
import java.time.Instant
import java.util.*

class NewFeaturesTest {

    private val auctionRepository = mockk<AuctionRepository>()
    private val roundConfigRepository = mockk<AuctionRoundConfigRepository>()
    private val slabRepository = mockk<BidIncrementSlabRepository>()
    private val categoryIncrementRepository = mockk<AuctionRoundCategoryIncrementRepository>()
    private val bidRepository = mockk<BidRepository>()
    private val playerStateRepository = mockk<PlayerAuctionStateRepository>()
    private val purseRepository = mockk<FranchisePurseStateRepository>()
    private val franchiseRepository = mockk<FranchiseRepository>()
    private val franchisePlayerRepository = mockk<FranchisePlayerRepository>()
    private val auctionAuditLogRepository = mockk<AuctionAuditLogRepository>()
    private val leaguePlayerRepository = mockk<LeaguePlayerRepository>()
    private val userRepository = mockk<com.crichere.domain.auth.repository.UserRepository>()
    private val leagueRepository = mockk<LeagueRepository>()
    private val redisTemplate = mockk<StringRedisTemplate>()
    private val objectMapper = mockk<ObjectMapper>()
    private val notificationService = mockk<NotificationService>()
    private val leagueService = mockk<LeagueService>()
    private val meterRegistry = mockk<io.micrometer.core.instrument.MeterRegistry>(relaxed = true)

    private lateinit var auctionService: AuctionService

    private val auctionId = UUID.randomUUID()
    private val roundId = UUID.randomUUID()
    private val actorId = UUID.randomUUID()

    @BeforeEach
    fun setUp() {
        val counter = mockk<io.micrometer.core.instrument.Counter>(relaxed = true)
        every { meterRegistry.counter(any()) } returns counter

        auctionService = AuctionService(
            auctionRepository, roundConfigRepository, slabRepository, categoryIncrementRepository,
            bidRepository, playerStateRepository, purseRepository, franchiseRepository,
            franchisePlayerRepository, auctionAuditLogRepository, leaguePlayerRepository,
            userRepository, leagueRepository, redisTemplate, objectMapper,
            notificationService, leagueService, meterRegistry
        )
    }

    @Test
    @DisplayName("startTimer - happy path")
    fun startTimerHappyPath() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID(), status = AuctionStatus.LIVE, currentLeaguePlayerId = UUID.randomUUID(), currentRoundId = roundId)
        val round = AuctionRoundConfig(id = roundId, auctionId = auctionId, roundNumber = 1, currencyType = CurrencyType.CASH, purseSource = PurseSource.FRESH, bidMode = BidMode.EACH_BID_RECORDED, playerPoolSource = PlayerPoolSource.ALL_REGISTERED, franchiseEligibilityRule = FranchiseEligibilityRule.ALL, completionTrigger = CompletionTrigger.AUCTIONEER_MANUAL)
        round.countdownSeconds = 45

        every { auctionRepository.findById(auctionId) } returns Optional.of(auction)
        every { auctionRepository.save(any()) } answers { firstArg() }
        every { roundConfigRepository.findById(roundId) } returns Optional.of(round)
        every { auctionAuditLogRepository.findMaxSequenceNumberByAuctionId(any()) } returns 0L
        every { auctionAuditLogRepository.save(any()) } answers { firstArg() }
        every { redisTemplate.convertAndSend(any(), any()) } returns 1L
        every { objectMapper.writeValueAsString(any()) } returns "{}"

        val result = auctionService.startTimer(auctionId, null, actorId)

        assertTrue(result.isRunning)
        assertEquals(45, result.durationSeconds)
        assertNotNull(result.startedAt)
        verify { auctionRepository.save(match { it.timerDurationSeconds == 45 }) }
    }

    @Test
    @DisplayName("getTimerState - running")
    fun getTimerStateRunning() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID())
        auction.timerStartedAt = Instant.now().minusSeconds(10)
        auction.timerDurationSeconds = 60
        auction.currentRoundId = roundId
        
        val round = AuctionRoundConfig(id = roundId, auctionId = auctionId, roundNumber = 1, currencyType = CurrencyType.CASH, purseSource = PurseSource.FRESH, bidMode = BidMode.EACH_BID_RECORDED, playerPoolSource = PlayerPoolSource.ALL_REGISTERED, franchiseEligibilityRule = FranchiseEligibilityRule.ALL, completionTrigger = CompletionTrigger.AUCTIONEER_MANUAL)
        round.antiSnipeSeconds = 15

        every { auctionRepository.findById(auctionId) } returns Optional.of(auction)
        every { roundConfigRepository.findById(roundId) } returns Optional.of(round)

        val result = auctionService.getTimerState(auctionId)

        assertTrue(result.isRunning)
        assertEquals(60, result.durationSeconds)
        assertEquals(15, result.antiSnipeSeconds)
        assertTrue(result.remainingSeconds!! <= 50)
    }

    @Test
    @DisplayName("placeBid - anti-snipe trigger")
    fun placeBidAntiSnipe() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID(), currentLeaguePlayerId = UUID.randomUUID(), currentRoundId = roundId)
        auction.timerStartedAt = Instant.now().minusSeconds(55) // 5s remaining
        auction.timerDurationSeconds = 60
        
        val round = AuctionRoundConfig(id = roundId, auctionId = auctionId, roundNumber = 1, currencyType = CurrencyType.CASH, purseSource = PurseSource.FRESH, bidMode = BidMode.EACH_BID_RECORDED, playerPoolSource = PlayerPoolSource.ALL_REGISTERED, franchiseEligibilityRule = FranchiseEligibilityRule.ALL, completionTrigger = CompletionTrigger.AUCTIONEER_MANUAL)
        round.antiSnipeSeconds = 10
        
        val playerState = PlayerAuctionState(auctionId = auctionId, leaguePlayerId = auction.currentLeaguePlayerId!!, state = PlayerAuctionStateValue.UP_FOR_BIDDING)
        val purse = FranchisePurseState(franchiseId = UUID.randomUUID(), auctionId = auctionId, roundId = roundId, currentAmount = 10000)
        val leaguePlayer = LeaguePlayer(id = auction.currentLeaguePlayerId!!, leagueId = auction.leagueId, userId = UUID.randomUUID())

        every { auctionRepository.findById(auctionId) } returns Optional.of(auction)
        every { auctionRepository.save(any()) } answers { firstArg() }
        every { roundConfigRepository.findById(roundId) } returns Optional.of(round)
        every { playerStateRepository.findByAuctionIdAndLeaguePlayerId(any(), any()) } returns Optional.of(playerState)
        every { playerStateRepository.save(any()) } answers { firstArg() }
        every { purseRepository.findByFranchiseIdAndRoundId(any(), any()) } returns purse
        every { leaguePlayerRepository.findById(any()) } returns Optional.of(leaguePlayer)
        every { leagueService.resolveBasePrice(any<LeaguePlayer>()) } returns 1000
        every { categoryIncrementRepository.findByRoundId(any()) } returns emptyList()
        every { slabRepository.findByRoundIdOrderByFromAmountAsc(any()) } returns emptyList()
        every { bidRepository.save(any()) } answers { firstArg() }
        every { auctionAuditLogRepository.findMaxSequenceNumberByAuctionId(any()) } returns 0L
        every { auctionAuditLogRepository.save(any()) } answers { firstArg() }
        every { redisTemplate.convertAndSend(any(), any()) } returns 1L
        every { objectMapper.writeValueAsString(any()) } returns "{}"

        auctionService.placeBid(auctionId, purse.franchiseId, 2000, actorId)

        // Verify timer was reset to anti-snipe duration
        verify { auctionRepository.save(match { it.timerDurationSeconds == 10 }) }
    }

    @Test
    @DisplayName("resolveBidIncrement - tag priority over category")
    fun resolveBidIncrementPriority() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID(), status = AuctionStatus.LIVE, currentLeaguePlayerId = UUID.randomUUID(), currentRoundId = roundId)
        val player = LeaguePlayer(id = auction.currentLeaguePlayerId!!, leagueId = auction.leagueId, userId = UUID.randomUUID(), category = "BATTER", tag = "A")
        val increments = listOf(
            AuctionRoundCategoryIncrement(roundId = roundId, category = "BATTER", bidIncrement = 1000),
            AuctionRoundCategoryIncrement(roundId = roundId, tag = "A", bidIncrement = 2000)
        )
        val playerState = PlayerAuctionState(auctionId = auctionId, leaguePlayerId = player.id, state = PlayerAuctionStateValue.UP_FOR_BIDDING, currentHighestBid = 5000)
        val purse = FranchisePurseState(franchiseId = UUID.randomUUID(), auctionId = auctionId, roundId = roundId, currentAmount = 10000)

        every { auctionRepository.findById(auctionId) } returns Optional.of(auction)
        every { playerStateRepository.findByAuctionIdAndLeaguePlayerId(any(), any()) } returns Optional.of(playerState)
        every { categoryIncrementRepository.findByRoundId(roundId) } returns increments
        every { leaguePlayerRepository.findById(player.id) } returns Optional.of(player)
        every { leagueService.resolveBasePrice(any<LeaguePlayer>()) } returns 1000
        every { purseRepository.findByFranchiseIdAndRoundId(any(), any()) } returns purse
        every { bidRepository.save(any()) } answers { firstArg() }
        every { playerStateRepository.save(any()) } answers { firstArg() }
        every { auctionAuditLogRepository.findMaxSequenceNumberByAuctionId(any()) } returns 0L
        every { auctionAuditLogRepository.save(any()) } answers { firstArg() }
        every { redisTemplate.convertAndSend(any(), any()) } returns 1L
        every { objectMapper.writeValueAsString(any()) } returns "{}"

        // Act: Place a bid. Increment should be 2000 (from Tag 'A')
        // Current bid is 5000. Min next bid is 7000.
        val result = auctionService.placeBid(auctionId, purse.franchiseId, 7000, actorId)

        assertEquals(7000, result.bidAmount)
    }

    @Test
    @DisplayName("resolveBidIncrement - fallback to slab")
    fun resolveBidIncrementSlabFallback() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID(), status = AuctionStatus.LIVE, currentLeaguePlayerId = UUID.randomUUID(), currentRoundId = roundId)
        val player = LeaguePlayer(id = auction.currentLeaguePlayerId!!, leagueId = auction.leagueId, userId = UUID.randomUUID(), category = "BATTER")
        val slabs = listOf(
            BidIncrementSlab(roundId = roundId, fromAmount = 0, toAmount = 10000, incrementBy = 500)
        )
        val playerState = PlayerAuctionState(auctionId = auctionId, leaguePlayerId = player.id, state = PlayerAuctionStateValue.UP_FOR_BIDDING, currentHighestBid = 2000)
        val purse = FranchisePurseState(franchiseId = UUID.randomUUID(), auctionId = auctionId, roundId = roundId, currentAmount = 10000)

        every { auctionRepository.findById(auctionId) } returns Optional.of(auction)
        every { playerStateRepository.findByAuctionIdAndLeaguePlayerId(any(), any()) } returns Optional.of(playerState)
        every { categoryIncrementRepository.findByRoundId(roundId) } returns emptyList()
        every { slabRepository.findByRoundIdOrderByFromAmountAsc(roundId) } returns slabs
        every { leaguePlayerRepository.findById(player.id) } returns Optional.of(player)
        every { leagueService.resolveBasePrice(any<LeaguePlayer>()) } returns 1000
        every { purseRepository.findByFranchiseIdAndRoundId(any(), any()) } returns purse
        every { bidRepository.save(any()) } answers { firstArg() }
        every { playerStateRepository.save(any()) } answers { firstArg() }
        every { auctionAuditLogRepository.findMaxSequenceNumberByAuctionId(any()) } returns 0L
        every { auctionAuditLogRepository.save(any()) } answers { firstArg() }
        every { redisTemplate.convertAndSend(any(), any()) } returns 1L
        every { objectMapper.writeValueAsString(any()) } returns "{}"

        // Act: Place a bid. Increment should be 500 (from Slab)
        val result = auctionService.placeBid(auctionId, purse.franchiseId, 2500, actorId)

        assertEquals(2500, result.bidAmount)
    }

    @Test
    @DisplayName("regeneratePublicViewToken - success")
    fun regenerateTokenSuccess() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID(), publicViewToken = "old-token")
        every { auctionRepository.findById(auctionId) } returns Optional.of(auction)
        every { auctionRepository.save(any()) } answers { firstArg() }

        val result = auctionService.regeneratePublicViewToken(auctionId)

        assertNotEquals("old-token", result.publicViewToken)
        assertEquals(64, result.publicViewToken.length)
        verify { auctionRepository.save(any()) }
    }
}
