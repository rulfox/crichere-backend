package com.crichere.domain.league.service

import com.crichere.domain.franchise.repository.FranchisePurseStateRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.entity.LeagueCategoryBasePrice
import com.crichere.domain.league.entity.LeagueTagBasePrice
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.league.repository.LeagueCategoryBasePriceRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.league.repository.LeagueTagBasePriceRepository
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.repository.LeaguePlayerRepository
import io.mockk.every
import io.mockk.mockk
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import java.util.UUID

class LeagueServiceTest {

    private val leagueRepository = mockk<LeagueRepository>()
    private val auctionRepository = mockk<AuctionRepository>()
    private val franchiseRepository = mockk<FranchiseRepository>()
    private val franchisePurseStateRepository = mockk<FranchisePurseStateRepository>()
    private val leagueCategoryBasePriceRepository = mockk<LeagueCategoryBasePriceRepository>()
    private val leagueTagBasePriceRepository = mockk<LeagueTagBasePriceRepository>()
    private val leaguePlayerRepository = mockk<LeaguePlayerRepository>()

    private val leagueService = LeagueService(
        leagueRepository,
        auctionRepository,
        franchiseRepository,
        franchisePurseStateRepository,
        leagueCategoryBasePriceRepository,
        leagueTagBasePriceRepository,
        leaguePlayerRepository
    )

    private val leagueId = UUID.randomUUID()
    private val userId = UUID.randomUUID()

    @Test
    fun `resolveBasePrice should return basePriceOverride if present`() {
        val player = LeaguePlayer(
            leagueId = leagueId,
            userId = userId,
            basePriceOverride = 1000,
            tag = "Star",
            category = "A"
        )

        val resolved = leagueService.resolveBasePrice(player)
        assertEquals(1000, resolved)
    }

    @Test
    fun `resolveBasePrice should return tag price if override is null`() {
        val player = LeaguePlayer(
            leagueId = leagueId,
            userId = userId,
            basePriceOverride = null,
            tag = "Star",
            category = "A"
        )

        every { leagueTagBasePriceRepository.findByLeagueIdAndTag(leagueId, "Star") } returns LeagueTagBasePrice(
            leagueId = leagueId,
            tag = "Star",
            price = 500
        )

        val resolved = leagueService.resolveBasePrice(player)
        assertEquals(500, resolved)
    }

    @Test
    fun `resolveBasePrice should return category price if override and tag price are null`() {
        val player = LeaguePlayer(
            leagueId = leagueId,
            userId = userId,
            basePriceOverride = null,
            tag = "UnknownTag",
            category = "A"
        )

        every { leagueTagBasePriceRepository.findByLeagueIdAndTag(leagueId, "UnknownTag") } returns null
        every { leagueCategoryBasePriceRepository.findByLeagueIdAndCategory(leagueId, "A") } returns LeagueCategoryBasePrice(
            leagueId = leagueId,
            category = "A",
            price = 200
        )

        val resolved = leagueService.resolveBasePrice(player)
        assertEquals(200, resolved)
    }

    @Test
    fun `resolveBasePrice should return 0 if no prices are found`() {
        val player = LeaguePlayer(
            leagueId = leagueId,
            userId = userId,
            basePriceOverride = null,
            tag = null,
            category = null
        )

        val resolved = leagueService.resolveBasePrice(player)
        assertEquals(0, resolved)
    }
}
