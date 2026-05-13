package com.crichere.domain.auction.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.InsufficientPurseException
import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.auction.entity.*
import com.crichere.domain.auction.enums.*
import com.crichere.domain.auction.repository.*
import com.crichere.domain.franchise.entity.Franchise
import com.crichere.domain.franchise.entity.FranchisePurseState
import com.crichere.domain.franchise.repository.FranchisePurseStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.entity.Auction
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.notification.service.NotificationService
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.repository.LeaguePlayerRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.auth.entity.User
import com.crichere.domain.league.service.LeagueService
import com.fasterxml.jackson.databind.ObjectMapper
import io.mockk.*
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.junit5.MockKExtension
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.data.redis.core.StringRedisTemplate
import java.util.*

@ExtendWith(MockKExtension::class)
@DisplayName("AuctionService Unit Tests")
class AuctionServiceTest {

    @MockK lateinit var auctionRepository: AuctionRepository
    @MockK lateinit var roundConfigRepository: AuctionRoundConfigRepository
    @MockK lateinit var slabRepository: BidIncrementSlabRepository
    @MockK lateinit var bidRepository: BidRepository
    @MockK lateinit var playerStateRepository: PlayerAuctionStateRepository
    @MockK lateinit var purseRepository: FranchisePurseStateRepository
    @MockK lateinit var franchiseRepository: FranchiseRepository
    @MockK lateinit var franchisePlayerRepository: FranchisePlayerRepository
    @MockK lateinit var auctionAuditLogRepository: AuctionAuditLogRepository
    @MockK lateinit var leaguePlayerRepository: LeaguePlayerRepository
    @MockK lateinit var userRepository: UserRepository
    @MockK lateinit var leagueRepository: LeagueRepository
    @MockK lateinit var redisTemplate: StringRedisTemplate
    @MockK lateinit var objectMapper: ObjectMapper
    @MockK lateinit var notificationService: NotificationService
    @MockK lateinit var leagueService: LeagueService
    @MockK lateinit var categoryIncrementRepository: AuctionRoundCategoryIncrementRepository
    @MockK lateinit var meterRegistry: io.micrometer.core.instrument.MeterRegistry

    lateinit var auctionService: AuctionService

    private val auctionId = UUID.randomUUID()
    private val roundId = UUID.randomUUID()
    private val playerId = UUID.randomUUID()
    private val franchiseId = UUID.randomUUID()
    private val actorId = UUID.randomUUID()

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)

        // Mock MeterRegistry counters
        val counter = mockk<io.micrometer.core.instrument.Counter>(relaxed = true)
        every { meterRegistry.counter(any()) } returns counter

        // Default mocks for logAndBroadcast which is called in almost every method
        every { auctionAuditLogRepository.findMaxSequenceNumberByAuctionId(any()) } returns 0L
        every { auctionAuditLogRepository.save(any()) } answers { firstArg() }
        every { redisTemplate.convertAndSend(any(), any()) } returns 1L
        every { objectMapper.writeValueAsString(any()) } returns "{}"
        every { categoryIncrementRepository.findByRoundId(any()) } returns emptyList()
        every { slabRepository.findByRoundIdOrderByFromAmountAsc(any()) } returns emptyList()
        every { franchiseRepository.save(any()) } answers { firstArg() }

        auctionService = AuctionService(
            auctionRepository, roundConfigRepository, slabRepository, categoryIncrementRepository,
            bidRepository, playerStateRepository, purseRepository, franchiseRepository,
            franchisePlayerRepository, auctionAuditLogRepository, leaguePlayerRepository,
            userRepository, leagueRepository, redisTemplate, objectMapper,
            notificationService, leagueService, meterRegistry
        )
    }

    @Test
    @DisplayName("placeBid - happy path")
    fun placeBidHappyPath() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID(), currentLeaguePlayerId = playerId, currentRoundId = roundId)
        val playerState = PlayerAuctionState(auctionId = auctionId, leaguePlayerId = playerId, state = PlayerAuctionStateValue.UP_FOR_BIDDING)
        val purse = FranchisePurseState(franchiseId = franchiseId, auctionId = auctionId, roundId = roundId, currencyType = CurrencyType.CASH, startingAmount = 10000, currentAmount = 10000)
        val leaguePlayer = LeaguePlayer(id = playerId, leagueId = auction.leagueId, userId = UUID.randomUUID())
        val bidAmount = 5000

        every { auctionRepository.findByIdWithLock(auctionId) } returns Optional.of(auction)
        every { playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId) } returns Optional.of(playerState)
        every { purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId) } returns purse
        every { leaguePlayerRepository.findById(playerId) } returns Optional.of(leaguePlayer)
        every { leagueService.resolveBasePrice(leaguePlayer) } returns 1000
        every { bidRepository.save(any()) } answers { firstArg() }
        every { playerStateRepository.save(any()) } answers { firstArg() }

        val result = auctionService.placeBid(auctionId, franchiseId, bidAmount, actorId)

        assertEquals(bidAmount, result.bidAmount)
        assertEquals(BidStatus.ACTIVE, result.status)
        assertEquals(bidAmount, playerState.currentHighestBid)
        assertEquals(franchiseId, playerState.currentHighestBidderId)
        verify { bidRepository.save(any()) }
        verify { playerStateRepository.save(playerState) }
        verify { auctionAuditLogRepository.save(any()) }
        verify { redisTemplate.convertAndSend(any(), any()) }
    }

    @Test
    @DisplayName("placeBid - insufficient purse")
    fun placeBidInsufficientPurse() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID(), currentLeaguePlayerId = playerId, currentRoundId = roundId)
        val playerState = PlayerAuctionState(auctionId = auctionId, leaguePlayerId = playerId, state = PlayerAuctionStateValue.UP_FOR_BIDDING)
        val purse = FranchisePurseState(franchiseId = franchiseId, auctionId = auctionId, roundId = UUID.randomUUID(), currencyType = CurrencyType.CASH, startingAmount = 4000, currentAmount = 4000)
        val bidAmount = 5000

        every { auctionRepository.findByIdWithLock(auctionId) } returns Optional.of(auction)
        every { playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId) } returns Optional.of(playerState)
        every { purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId) } returns purse

        assertThrows(InsufficientPurseException::class.java) {
            auctionService.placeBid(auctionId, franchiseId, bidAmount, actorId)
        }
        verify(exactly = 0) { bidRepository.save(any()) }
    }

    @Test
    @DisplayName("placeBid - no player currently up")
    fun placeBidNoPlayerUp() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID(), currentLeaguePlayerId = null)

        every { auctionRepository.findByIdWithLock(auctionId) } returns Optional.of(auction)

        val exception = assertThrows(BusinessLogicException::class.java) {
            auctionService.placeBid(auctionId, franchiseId, 5000, actorId)
        }
        assertEquals("error.no_player_up", exception.messageKey)
    }

    @Test
    @DisplayName("undoBid - happy path")
    fun undoBidHappyPath() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID(), currentLeaguePlayerId = playerId)
        val playerState = PlayerAuctionState(auctionId = auctionId, leaguePlayerId = playerId, state = PlayerAuctionStateValue.UP_FOR_BIDDING)
        val lastBid = Bid(id = UUID.randomUUID(), auctionId = auctionId, roundId = roundId, leaguePlayerId = playerId, franchiseId = franchiseId, bidAmount = 5000, status = BidStatus.ACTIVE, recordedBy = actorId)
        val prevBid = Bid(id = UUID.randomUUID(), auctionId = auctionId, roundId = roundId, leaguePlayerId = playerId, franchiseId = UUID.randomUUID(), bidAmount = 4000, status = BidStatus.ACTIVE, recordedBy = actorId)

        every { auctionRepository.findByIdWithLock(auctionId) } returns Optional.of(auction)
        every { playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId) } returns Optional.of(playerState)
        every { bidRepository.findFirstByLeaguePlayerIdAndAuctionIdAndStatusOrderByBidAtDesc(playerId, auctionId, BidStatus.ACTIVE) } returnsMany listOf(Optional.of(lastBid), Optional.of(prevBid))
        every { bidRepository.save(any()) } answers { firstArg() }
        every { playerStateRepository.save(any()) } answers { firstArg() }

        val result = auctionService.undoBid(auctionId, "Mistake", actorId)

        assertEquals(PlayerAuctionStateValue.UP_FOR_BIDDING, result.state)
        assertEquals(BidStatus.UNDONE, lastBid.status)
        assertEquals(4000, playerState.currentHighestBid)
        verify { bidRepository.save(lastBid) }
        verify { auctionAuditLogRepository.save(match { it.action == AuctionAction.BID_UNDONE }) }
    }

    @Test
    @DisplayName("undoBid - no active bid to undo")
    fun undoBidNoActiveBid() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID(), currentLeaguePlayerId = playerId)
        val playerState = PlayerAuctionState(auctionId = auctionId, leaguePlayerId = playerId, state = PlayerAuctionStateValue.UP_FOR_BIDDING)

        every { auctionRepository.findByIdWithLock(auctionId) } returns Optional.of(auction)
        every { playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId) } returns Optional.of(playerState)
        every { bidRepository.findFirstByLeaguePlayerIdAndAuctionIdAndStatusOrderByBidAtDesc(playerId, auctionId, BidStatus.ACTIVE) } returns Optional.empty()

        val exception = assertThrows(BusinessLogicException::class.java) {
            auctionService.undoBid(auctionId, "Mistake", actorId)
        }
        assertEquals("error.no_active_bids", exception.messageKey)
    }

    @Test
    @DisplayName("sellPlayer - happy path")
    fun sellPlayerHappyPath() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID(), currentRoundId = roundId)
        val playerState = PlayerAuctionState(auctionId = auctionId, leaguePlayerId = playerId, state = PlayerAuctionStateValue.UP_FOR_BIDDING)
        val purse = FranchisePurseState(franchiseId = franchiseId, auctionId = auctionId, roundId = roundId, currencyType = CurrencyType.CASH, startingAmount = 10000, currentAmount = 10000)
        val finalPrice = 5000
        val leaguePlayer = LeaguePlayer(id = playerId, leagueId = UUID.randomUUID(), userId = UUID.randomUUID())
        val franchise = Franchise(id = franchiseId, name = "Team A", ownerId = UUID.randomUUID(), leagueId = UUID.randomUUID())

        every { auctionRepository.findByIdWithLock(auctionId) } returns Optional.of(auction)
        every { playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId) } returns Optional.of(playerState)
        every { purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId) } returns purse
        every { playerStateRepository.save(any()) } answers { firstArg() }
        every { purseRepository.save(any()) } answers { firstArg() }
        every { franchisePlayerRepository.save(any()) } returns mockk()
        every { auctionRepository.save(any()) } answers { firstArg() }
        every { leaguePlayerRepository.findById(playerId) } returns Optional.of(leaguePlayer)
        every { franchiseRepository.findById(franchiseId) } returns Optional.of(franchise)
        every { notificationService.notifyPlayerSold(any(), any(), any()) } just runs

        val result = auctionService.sellPlayer(auctionId, playerId, franchiseId, finalPrice, actorId)

        assertEquals(PlayerAuctionStateValue.SOLD, result.state)
        assertEquals(finalPrice, result.finalPrice)
        assertEquals(franchiseId, result.soldToFranchiseId)
        assertEquals(5000, purse.currentAmount)
        assertNull(auction.currentLeaguePlayerId)
        verify { franchisePlayerRepository.save(any()) }
        verify { auctionAuditLogRepository.save(match { it.action == AuctionAction.PLAYER_SOLD }) }
        verify(exactly = 2) { notificationService.notifyPlayerSold(any(), any(), any()) }
    }

    @Test
    @DisplayName("undoSold - happy path")
    fun undoSoldHappyPath() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID(), currentRoundId = roundId)
        val playerState = PlayerAuctionState(
            auctionId = auctionId, 
            leaguePlayerId = playerId, 
            state = PlayerAuctionStateValue.SOLD,
            soldToFranchiseId = franchiseId,
            finalPrice = 5000
        )
        val purse = FranchisePurseState(franchiseId = franchiseId, auctionId = auctionId, roundId = roundId, currencyType = CurrencyType.CASH, startingAmount = 5000, currentAmount = 5000)
        val franchise = Franchise(id = franchiseId, name = "Team A", ownerId = UUID.randomUUID(), leagueId = UUID.randomUUID())
        val lastLog = AuctionAuditLog(
            auctionId = auctionId,
            action = AuctionAction.PLAYER_SOLD,
            payload = mapOf("leaguePlayerId" to playerId.toString()),
            sequenceNumber = 1
        )

        every { auctionRepository.findByIdWithLock(auctionId) } returns Optional.of(auction)
        every { auctionRepository.save(any()) } answers { firstArg() }
        every { auctionAuditLogRepository.findByAuctionIdOrderBySequenceNumberAsc(auctionId) } returns listOf(lastLog)
        every { playerStateRepository.findByAuctionIdAndLeaguePlayerId(auctionId, playerId) } returns Optional.of(playerState)
        every { purseRepository.findByFranchiseIdAndRoundId(franchiseId, roundId) } returns purse
        every { franchiseRepository.findById(franchiseId) } returns Optional.of(franchise)
        every { playerStateRepository.save(any()) } answers { firstArg() }
        every { purseRepository.save(any()) } answers { firstArg() }
        every { franchisePlayerRepository.deleteByLeaguePlayerId(playerId) } just runs

        val result = auctionService.undoSold(auctionId, playerId, "Mistake", actorId)

        assertEquals(PlayerAuctionStateValue.UP_FOR_BIDDING, result.state)
        assertNull(result.finalPrice)
        assertNull(result.soldToFranchiseId)
        assertEquals(10000, purse.currentAmount)
        verify { franchisePlayerRepository.deleteByLeaguePlayerId(playerId) }
        verify { auctionAuditLogRepository.save(match { it.action == AuctionAction.SOLD_REVERTED }) }
    }

    @Test
    @DisplayName("undoSold - not last action")
    fun undoSoldNotLastAction() {
        val auction = Auction(id = auctionId, leagueId = UUID.randomUUID())
        val lastLog = AuctionAuditLog(
            auctionId = auctionId,
            action = AuctionAction.BID_PLACED,
            payload = mapOf("leaguePlayerId" to playerId.toString()),
            sequenceNumber = 1
        )

        every { auctionRepository.findByIdWithLock(auctionId) } returns Optional.of(auction)
        every { auctionAuditLogRepository.findByAuctionIdOrderBySequenceNumberAsc(auctionId) } returns listOf(lastLog)

        val exception = assertThrows(BusinessLogicException::class.java) {
            auctionService.undoSold(auctionId, playerId, "Mistake", actorId)
        }
        assertEquals("error.undo_sold_not_last_action", exception.messageKey)
    }
}
