package com.crichere.domain.league.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.domain.franchise.repository.FranchisePurseStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.entity.LeagueCategoryBasePrice
import com.crichere.domain.league.entity.LeagueTagBasePrice
import com.crichere.domain.league.enums.LeagueStatus
import com.crichere.domain.league.repository.*
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.repository.LeaguePlayerRepository
import io.mockk.every
import io.mockk.just
import io.mockk.runs
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.junit5.MockKExtension
import io.mockk.verify
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertThrows
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import java.util.*

@ExtendWith(MockKExtension::class)
@DisplayName("LeagueService Unit Tests")
class LeagueServiceTest {

    @MockK lateinit var leagueRepository: LeagueRepository
    @MockK lateinit var auctionRepository: AuctionRepository
    @MockK lateinit var franchiseRepository: FranchiseRepository
    @MockK lateinit var franchisePurseStateRepository: FranchisePurseStateRepository
    @MockK lateinit var leagueCategoryBasePriceRepository: LeagueCategoryBasePriceRepository
    @MockK lateinit var leagueTagBasePriceRepository: LeagueTagBasePriceRepository
    @MockK lateinit var leaguePlayerRepository: LeaguePlayerRepository

    @InjectMockKs
    lateinit var leagueService: LeagueService

    @Test
    @DisplayName("resolveBasePrice - priority: override > tag > category")
    fun resolveBasePricePriority() {
        val leagueId = UUID.randomUUID()
        val player = LeaguePlayer(
            leagueId = leagueId,
            userId = UUID.randomUUID(),
            basePriceOverride = 500,
            tag = "Star",
            category = "A"
        )

        // 1. Override priority
        assertEquals(500, leagueService.resolveBasePrice(player))

        // 2. Tag priority
        player.basePriceOverride = null
        every { leagueTagBasePriceRepository.findByLeagueIdAndTag(leagueId, "Star") } returns LeagueTagBasePrice(leagueId = leagueId, tag = "Star", price = 300)
        assertEquals(300, leagueService.resolveBasePrice(player))

        // 3. Category priority
        every { leagueTagBasePriceRepository.findByLeagueIdAndTag(leagueId, "Star") } returns null
        every { leagueCategoryBasePriceRepository.findByLeagueIdAndCategory(leagueId, "A") } returns LeagueCategoryBasePrice(leagueId = leagueId, category = "A", price = 100)
        assertEquals(100, leagueService.resolveBasePrice(player))
        
        // 4. Default 0
        every { leagueCategoryBasePriceRepository.findByLeagueIdAndCategory(leagueId, "A") } returns null
        assertEquals(0, leagueService.resolveBasePrice(player))
    }

    @Test
    @DisplayName("updateLeagueStatus - invalid transition throws exception")
    fun updateStatusInvalidTransition() {
        val leagueId = UUID.randomUUID()
        val league = League(id = leagueId, name = "Test", status = LeagueStatus.DRAFT, createdBy = UUID.randomUUID())
        
        every { leagueRepository.findById(leagueId) } returns Optional.of(league)

        val exception = assertThrows(BusinessLogicException::class.java) {
            leagueService.updateLeagueStatus(leagueId, LeagueStatus.AUCTION_IN_PROGRESS)
        }
        assertEquals("error.invalid_status_transition", exception.messageKey)
    }

    @Test
    @DisplayName("updateLeagueStatus - valid transition")
    fun updateStatusValidTransition() {
        val leagueId = UUID.randomUUID()
        val league = League(id = leagueId, name = "Test", status = LeagueStatus.DRAFT, createdBy = UUID.randomUUID())
        
        every { leagueRepository.findById(leagueId) } returns Optional.of(league)
        every { leagueRepository.save(any()) } answers { firstArg() }

        leagueService.updateLeagueStatus(leagueId, LeagueStatus.OPEN)

        assertEquals(LeagueStatus.OPEN, league.status)
        verify { leagueRepository.save(league) }
    }

    @Test
    @DisplayName("updateCategoryPrices - success")
    fun updateCategoryPricesSuccess() {
        val leagueId = UUID.randomUUID()
        val league = League(id = leagueId, name = "Test", status = LeagueStatus.DRAFT, createdBy = UUID.randomUUID())
        val requests = listOf(com.crichere.domain.league.dto.CategoryPriceRequest("A", 100))

        every { leagueRepository.findById(leagueId) } returns Optional.of(league)
        every { leagueCategoryBasePriceRepository.findByLeagueId(leagueId) } returns emptyList()
        every { leagueCategoryBasePriceRepository.deleteAll(any()) } just runs
        every { leagueCategoryBasePriceRepository.saveAll(any<List<LeagueCategoryBasePrice>>()) } answers { firstArg() }

        val result = leagueService.updateCategoryPrices(leagueId, requests)

        assertEquals(1, result.size)
        assertEquals("A", result[0].category)
        assertEquals(100, result[0].price)
        verify { leagueCategoryBasePriceRepository.deleteAll(any()) }
        verify { leagueCategoryBasePriceRepository.saveAll(any<List<LeagueCategoryBasePrice>>()) }
    }

    @Test
    @DisplayName("updateTagPrices - success")
    fun updateTagPricesSuccess() {
        val leagueId = UUID.randomUUID()
        val league = League(id = leagueId, name = "Test", status = LeagueStatus.DRAFT, createdBy = UUID.randomUUID())
        val requests = listOf(com.crichere.domain.league.dto.TagPriceRequest("Star", 500))

        every { leagueRepository.findById(leagueId) } returns Optional.of(league)
        every { leagueTagBasePriceRepository.findByLeagueId(leagueId) } returns emptyList()
        every { leagueTagBasePriceRepository.deleteAll(any()) } just runs
        every { leagueTagBasePriceRepository.saveAll(any<List<LeagueTagBasePrice>>()) } answers { firstArg() }

        val result = leagueService.updateTagPrices(leagueId, requests)

        assertEquals(1, result.size)
        assertEquals("Star", result[0].tag)
        assertEquals(500, result[0].price)
        verify { leagueTagBasePriceRepository.deleteAll(any()) }
        verify { leagueTagBasePriceRepository.saveAll(any<List<LeagueTagBasePrice>>()) }
    }
}
