package com.crichere.domain.waitinglist.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.domain.auth.entity.User
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.fee.service.FeeService
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.enums.WaitingListMode
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.notification.service.NotificationService
import com.crichere.domain.player.repository.LeaguePlayerRepository
import com.crichere.domain.waitinglist.entity.WaitingListEntry
import com.crichere.domain.waitinglist.enums.WaitingListStatus
import com.crichere.domain.waitinglist.enums.WaitingListType
import com.crichere.domain.waitinglist.repository.WaitingListEntryRepository
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
@DisplayName("WaitingListService Unit Tests")
class WaitingListServiceTest {

    @MockK lateinit var waitingListEntryRepository: WaitingListEntryRepository
    @MockK lateinit var leagueRepository: LeagueRepository
    @MockK lateinit var userRepository: UserRepository
    @MockK lateinit var leaguePlayerRepository: LeaguePlayerRepository
    @MockK lateinit var franchiseRepository: FranchiseRepository
    @MockK lateinit var feeService: FeeService
    @MockK lateinit var notificationService: NotificationService

    lateinit var waitingListService: WaitingListService

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)
        waitingListService = WaitingListService(
            waitingListEntryRepository, leagueRepository, userRepository,
            leaguePlayerRepository, franchiseRepository, feeService, notificationService
        )
    }

    private val leagueId = UUID.randomUUID()
    private val userId = UUID.randomUUID()
    private val entryId = UUID.randomUUID()

    @Test
    @DisplayName("withdraw - position shifts")
    fun withdrawPositionShifts() {
        val entry1 = WaitingListEntry(id = UUID.randomUUID(), leagueId = leagueId, userId = UUID.randomUUID(), position = 1, status = WaitingListStatus.WAITING, type = WaitingListType.PLAYER)
        val entry2 = WaitingListEntry(id = entryId, leagueId = leagueId, userId = userId, position = 2, status = WaitingListStatus.WAITING, type = WaitingListType.PLAYER)
        val entry3 = WaitingListEntry(id = UUID.randomUUID(), leagueId = leagueId, userId = UUID.randomUUID(), position = 3, status = WaitingListStatus.WAITING, type = WaitingListType.PLAYER)

        every { waitingListEntryRepository.findById(entryId) } returns Optional.of(entry2)
        every { waitingListEntryRepository.save(any()) } answers { firstArg() }
        every { waitingListEntryRepository.findByLeagueIdAndStatusOrderByPositionAscWithLock(leagueId, WaitingListStatus.WAITING) } returns listOf(entry1, entry3)

        waitingListService.withdraw(leagueId, entryId, userId)

        assertEquals(WaitingListStatus.WITHDRAWN, entry2.status)
        assertEquals(1, entry1.position)
        assertEquals(2, entry3.position)
        verify(exactly = 3) { waitingListEntryRepository.save(any()) }
    }

    @Test
    @DisplayName("promote - ADMIN_PICKS mode")
    fun promoteAdminPicks() {
        val league = League(id = leagueId, name = "Test League", waitingListMode = WaitingListMode.ADMIN_PICKS, createdBy = UUID.randomUUID())
        val entry = WaitingListEntry(id = entryId, leagueId = leagueId, userId = userId, position = 3, status = WaitingListStatus.WAITING, type = WaitingListType.PLAYER)

        every { waitingListEntryRepository.findById(entryId) } returns Optional.of(entry)
        every { leagueRepository.findById(leagueId) } returns Optional.of(league)
        every { waitingListEntryRepository.save(any()) } answers { firstArg() }
        every { leaguePlayerRepository.save(any()) } returns mockk()
        every { notificationService.notifyWaitingListPromoted(userId, league.name) } just runs
        every { waitingListEntryRepository.findByLeagueIdAndStatusOrderByPositionAscWithLock(leagueId, WaitingListStatus.WAITING) } returns emptyList()

        waitingListService.promoteEntry(leagueId, entryId, true)

        assertEquals(WaitingListStatus.PROMOTED, entry.status)
        verify { leaguePlayerRepository.save(any()) }
        verify { notificationService.notifyWaitingListPromoted(userId, league.name) }
    }

    @Test
    @DisplayName("promote - AUTO_PROMOTE mode returns error")
    fun promoteAutoPromoteModeError() {
        val league = League(id = leagueId, name = "Test League", waitingListMode = WaitingListMode.AUTO_PROMOTE, createdBy = UUID.randomUUID())
        val entry = WaitingListEntry(id = entryId, leagueId = leagueId, userId = userId, position = 1, status = WaitingListStatus.WAITING, type = WaitingListType.PLAYER)

        every { waitingListEntryRepository.findById(entryId) } returns Optional.of(entry)
        every { leagueRepository.findById(leagueId) } returns Optional.of(league)

        val exception = assertThrows(BusinessLogicException::class.java) {
            waitingListService.promoteEntry(leagueId, entryId, true)
        }
        assertEquals("error.auto_promote_mode_active", exception.messageKey)
    }
}
