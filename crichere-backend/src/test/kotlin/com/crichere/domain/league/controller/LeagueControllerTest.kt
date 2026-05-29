package com.crichere.domain.league.controller

import com.crichere.domain.league.entity.League
import com.crichere.domain.league.service.LeagueService
import com.crichere.domain.league.service.BulkImportService
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.franchise.entity.Franchise
import com.fasterxml.jackson.databind.ObjectMapper
import org.junit.jupiter.api.Test
import org.mockito.kotlin.any
import org.mockito.kotlin.given
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest
import org.springframework.boot.test.mock.mockito.MockBean
import org.springframework.data.domain.PageImpl
import org.springframework.data.domain.PageRequest
import org.springframework.http.MediaType
import org.springframework.security.test.context.support.WithMockUser
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.*
import java.util.*

@WebMvcTest(LeagueController::class)
@AutoConfigureMockMvc(addFilters = false)
class LeagueControllerTest {

    @Autowired
    private lateinit var mockMvc: MockMvc

    @MockBean
    private lateinit var leagueService: LeagueService

    @MockBean
    private lateinit var bulkImportService: BulkImportService

    @MockBean
    private lateinit var jwtTokenProvider: com.crichere.security.JwtTokenProvider
    @MockBean
    private lateinit var jwtAuthenticationFilter: com.crichere.security.JwtAuthenticationFilter
    @MockBean
    private lateinit var jwtAuthenticationEntryPoint: com.crichere.security.JwtAuthenticationEntryPoint
    @MockBean
    private lateinit var userDetailsService: org.springframework.security.core.userdetails.UserDetailsService
    @MockBean
    private lateinit var auctionService: com.crichere.domain.auction.service.AuctionService
    @MockBean
    private lateinit var pushProvider: com.crichere.common.provider.PushProvider
    @MockBean
    private lateinit var smsProvider: com.crichere.common.provider.SmsProvider
    @MockBean
    private lateinit var stringRedisTemplate: org.springframework.data.redis.core.StringRedisTemplate
    @MockBean
    private lateinit var auctionRepository: com.crichere.domain.league.repository.AuctionRepository

    @Autowired
    private lateinit var objectMapper: ObjectMapper

    @Test
    fun `getFranchises should return list of franchises`() {
        val leagueId = UUID.randomUUID()
        val franchises = listOf(
            Franchise(id = UUID.randomUUID(), leagueId = leagueId, ownerId = UUID.randomUUID(), name = "Team 1"),
            Franchise(id = UUID.randomUUID(), leagueId = leagueId, ownerId = UUID.randomUUID(), name = "Team 2")
        )

        given(leagueService.getFranchises(leagueId)).willReturn(franchises)

        mockMvc.perform(get("/leagues/$leagueId/franchises"))
            .andExpect(status().isOk)
            .andExpect(jsonPath("$.data.length()").value(2))
            .andExpect(jsonPath("$.data[0].name").value("Team 1"))
    }

    @Test
    fun `getPlayers should return paginated players`() {
        val leagueId = UUID.randomUUID()
        val players = listOf(
            LeaguePlayer(id = UUID.randomUUID(), leagueId = leagueId, userId = UUID.randomUUID())
        )
        val page = PageImpl(players, PageRequest.of(0, 20), 1)

        given(leagueService.getPlayers(any(), any())).willReturn(page)
        given(leagueService.resolveBasePrice(any<LeaguePlayer>())).willReturn(500)

        mockMvc.perform(get("/leagues/$leagueId/players"))
            .andExpect(status().isOk)
            .andExpect(jsonPath("$.data.players.length()").value(1))
            .andExpect(jsonPath("$.data.totalElements").value(1))
    }

    @Test
    fun `updatePlayerEligibility should return updated player`() {
        val leagueId = UUID.randomUUID()
        val playerId = UUID.randomUUID()
        val player = LeaguePlayer(id = playerId, leagueId = leagueId, userId = UUID.randomUUID(), auctionEligible = true)

        given(leagueService.updatePlayerEligibility(any(), any(), any())).willReturn(player)
        given(leagueService.resolveBasePrice(any<LeaguePlayer>())).willReturn(500)

        mockMvc.perform(patch("/leagues/$leagueId/players/$playerId/eligible")
            .contentType(MediaType.APPLICATION_JSON)
            .content(objectMapper.writeValueAsString(mapOf("eligible" to true))))
            .andExpect(status().isOk)
            .andExpect(jsonPath("$.data.auctionEligible").value(true))
    }

    @Test
    fun `removePlayer should return success`() {
        val leagueId = UUID.randomUUID()
        val playerId = UUID.randomUUID()

        mockMvc.perform(delete("/leagues/$leagueId/players/$playerId"))
            .andExpect(status().isOk)
            .andExpect(jsonPath("$.success").value(true))
    }
}
