package com.crichere.domain.forfeit.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.domain.fee.entity.FeeObligation
import com.crichere.domain.fee.enums.FeeStatus
import com.crichere.domain.fee.enums.FeeType
import com.crichere.domain.fee.repository.FeeObligationRepository
import com.crichere.domain.fee.service.FeeService
import com.crichere.domain.forfeit.dto.ForfeitApproveRequest
import com.crichere.domain.forfeit.entity.ForfeitRequest
import com.crichere.domain.forfeit.enums.FeeRefundDecision
import com.crichere.domain.forfeit.enums.ForfeitStatus
import com.crichere.domain.forfeit.enums.ForfeitType
import com.crichere.domain.forfeit.repository.ForfeitRequestRepository
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.enums.WaitingListMode
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.notification.service.NotificationService
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.repository.LeaguePlayerRepository
import com.crichere.domain.waitinglist.service.WaitingListService
import io.mockk.*
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.junit5.MockKExtension
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertThrows
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import java.util.*

@ExtendWith(MockKExtension::class)
@DisplayName("ForfeitService Unit Tests")
class ForfeitServiceTest {

    @MockK lateinit var forfeitRequestRepository: ForfeitRequestRepository
    @MockK lateinit var feeService: FeeService
    @MockK lateinit var feeObligationRepository: FeeObligationRepository
    @MockK lateinit var leaguePlayerRepository: LeaguePlayerRepository
    @MockK lateinit var leagueRepository: LeagueRepository
    @MockK lateinit var waitingListService: WaitingListService
    @MockK lateinit var notificationService: NotificationService

    lateinit var forfeitService: ForfeitService

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)
        forfeitService = ForfeitService(
            forfeitRequestRepository, feeService, feeObligationRepository,
            leaguePlayerRepository, leagueRepository, waitingListService,
            notificationService
        )
    }

    private val leagueId = UUID.randomUUID()
    private val userId = UUID.randomUUID()
    private val requestId = UUID.randomUUID()
    private val adminId = UUID.randomUUID()

    @Test
    @DisplayName("approveRequest - full refund and auto-promote")
    fun approveRequestFullRefund() {
        val forfeitRequest = ForfeitRequest(id = requestId, leagueId = leagueId, userId = userId, status = ForfeitStatus.PENDING, type = ForfeitType.PLAYER, reason = "Personal")
        val obligation = FeeObligation(leagueId = leagueId, userId = userId, feeType = FeeType.PLAYER_FEE, totalAmount = 1000, paidAmount = 1000, status = FeeStatus.PAID)
        val player = LeaguePlayer(id = UUID.randomUUID(), leagueId = leagueId, userId = userId, auctionEligible = true)
        val league = League(id = leagueId, name = "League A", waitingListMode = WaitingListMode.AUTO_PROMOTE, createdBy = UUID.randomUUID())
        
        val approveRequest = ForfeitApproveRequest(feeRefundDecision = FeeRefundDecision.FULL_REFUND)

        every { forfeitRequestRepository.findById(requestId) } returns Optional.of(forfeitRequest)
        every { feeObligationRepository.findByLeagueIdAndUserIdAndFeeType(leagueId, userId, FeeType.PLAYER_FEE) } returns Optional.of(obligation)
        every { feeObligationRepository.save(any()) } answers { firstArg() }
        every { feeService.recordPayment(any(), any(), any(), any()) } returns mockk()
        every { leaguePlayerRepository.findByLeagueIdAndUserId(leagueId, userId) } returns player
        every { leaguePlayerRepository.save(any()) } answers { firstArg() }
        every { forfeitRequestRepository.save(any()) } answers { firstArg() }
        every { leagueRepository.findById(leagueId) } returns Optional.of(league)
        every { notificationService.notifyForfeitApproved(any(), any()) } just runs
        every { waitingListService.promoteNext(leagueId) } just runs

        forfeitService.approveRequest(leagueId, requestId, approveRequest, adminId)

        assertEquals(ForfeitStatus.APPROVED, forfeitRequest.status)
        assertEquals(1000, forfeitRequest.feeRefundAmount)
        assertEquals(FeeStatus.WAIVED, obligation.status)
        verify { feeService.recordPayment(leagueId, obligation.id, match { it.amount == -1000 }, adminId) }
        verify { waitingListService.promoteNext(leagueId) }
    }

    @Test
    @DisplayName("rejectRequest - happy path")
    fun rejectRequestHappyPath() {
        val forfeitRequest = ForfeitRequest(id = requestId, status = ForfeitStatus.PENDING, userId = userId, leagueId = leagueId, type = ForfeitType.PLAYER, reason = "Personal")
        
        every { forfeitRequestRepository.findById(requestId) } returns Optional.of(forfeitRequest)
        every { forfeitRequestRepository.save(any()) } answers { firstArg() }

        forfeitService.rejectRequest(requestId, "Invalid reason")

        assertEquals(ForfeitStatus.REJECTED, forfeitRequest.status)
        assertEquals("Invalid reason", forfeitRequest.adminNotes)
    }
}
