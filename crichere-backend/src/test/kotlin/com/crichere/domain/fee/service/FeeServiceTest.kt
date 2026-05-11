package com.crichere.domain.fee.service

import com.crichere.domain.fee.dto.FeePaymentRequest
import com.crichere.domain.fee.entity.FeeObligation
import com.crichere.domain.fee.entity.FeePayment
import com.crichere.domain.fee.enums.FeeStatus
import com.crichere.domain.fee.enums.FeeType
import com.crichere.domain.fee.enums.PaymentMode
import com.crichere.domain.fee.repository.FeeObligationRepository
import com.crichere.domain.fee.repository.FeePaymentRepository
import com.crichere.domain.notification.service.NotificationService
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.repository.LeaguePlayerRepository
import io.mockk.*
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.junit5.MockKExtension
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import java.util.*

@ExtendWith(MockKExtension::class)
@DisplayName("FeeService Unit Tests")
class FeeServiceTest {

    @MockK lateinit var feeObligationRepository: FeeObligationRepository
    @MockK lateinit var feePaymentRepository: FeePaymentRepository
    @MockK lateinit var leaguePlayerRepository: LeaguePlayerRepository
    @MockK lateinit var notificationService: NotificationService

    lateinit var feeService: FeeService

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)
        feeService = FeeService(
            feeObligationRepository, feePaymentRepository,
            leaguePlayerRepository, notificationService
        )
    }

    private val leagueId = UUID.randomUUID()
    private val userId = UUID.randomUUID()
    private val obligationId = UUID.randomUUID()
    private val actorId = UUID.randomUUID()

    @Test
    @DisplayName("recordPayment - minimumToRegister threshold met")
    fun recordPaymentThresholdMet() {
        val obligation = FeeObligation(
            id = obligationId,
            leagueId = leagueId,
            userId = userId,
            feeType = FeeType.PLAYER_FEE,
            totalAmount = 1000,
            minimumToRegister = 500,
            paidAmount = 0,
            status = FeeStatus.UNPAID
        )
        val player = LeaguePlayer(id = UUID.randomUUID(), leagueId = leagueId, userId = userId, auctionEligible = false)
        val request = FeePaymentRequest(amount = 600, paymentMode = PaymentMode.CASH, notes = "Partial payment")

        every { feeObligationRepository.findById(obligationId) } returns Optional.of(obligation)
        every { leaguePlayerRepository.findByLeagueIdAndUserId(leagueId, userId) } returns player
        every { feeObligationRepository.save(any()) } answers { firstArg() }
        every { feePaymentRepository.save(any()) } answers { firstArg() }
        every { leaguePlayerRepository.save(any()) } answers { firstArg() }
        every { notificationService.notifyFeePaymentRecorded(any(), any()) } just runs

        val result = feeService.recordPayment(leagueId, obligationId, request, actorId)

        assertEquals(600, obligation.paidAmount)
        assertEquals(FeeStatus.PARTIALLY_PAID, obligation.status)
        assertTrue(player.auctionEligible)
        verify { leaguePlayerRepository.save(player) }
        verify { feePaymentRepository.save(any()) }
    }

    @Test
    @DisplayName("recordPayment - fully paid")
    fun recordPaymentFullyPaid() {
        val obligation = FeeObligation(
            id = obligationId,
            leagueId = leagueId,
            userId = userId,
            feeType = FeeType.PLAYER_FEE,
            totalAmount = 1000,
            paidAmount = 800,
            status = FeeStatus.PARTIALLY_PAID
        )
        val request = FeePaymentRequest(amount = 200, paymentMode = PaymentMode.CASH, notes = "Final payment")

        every { feeObligationRepository.findById(obligationId) } returns Optional.of(obligation)
        every { feeObligationRepository.save(any()) } answers { firstArg() }
        every { feePaymentRepository.save(any()) } answers { firstArg() }
        every { notificationService.notifyFeePaymentRecorded(any(), any()) } just runs

        feeService.recordPayment(leagueId, obligationId, request, actorId)

        assertEquals(1000, obligation.paidAmount)
        assertEquals(FeeStatus.PAID, obligation.status)
        verify { feeObligationRepository.save(obligation) }
    }

    @Test
    @DisplayName("waiveFee - from any status")
    fun waiveFeeHappyPath() {
        val obligation = FeeObligation(
            id = obligationId,
            leagueId = leagueId,
            userId = userId,
            feeType = FeeType.PLAYER_FEE,
            totalAmount = 1000,
            status = FeeStatus.PARTIALLY_PAID
        )

        every { feeObligationRepository.findById(obligationId) } returns Optional.of(obligation)
        every { feeObligationRepository.save(any()) } answers { firstArg() }
        every { feePaymentRepository.save(any()) } answers { firstArg() }

        feeService.waiveObligation(leagueId, obligationId, "Special case", actorId)

        assertEquals(FeeStatus.WAIVED, obligation.status)
        verify { feeObligationRepository.save(obligation) }
        verify { feePaymentRepository.save(match { it.notes?.contains("WAIVED: Special case") == true }) }
    }
}
