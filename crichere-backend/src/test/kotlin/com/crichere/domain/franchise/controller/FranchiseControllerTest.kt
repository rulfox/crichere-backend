package com.crichere.domain.franchise.controller

import com.crichere.domain.franchise.entity.Franchise
import com.crichere.domain.franchise.entity.FranchiseInvite
import com.crichere.domain.franchise.service.FranchiseService
import com.crichere.domain.auction.dto.AuctionPlayerSummary
import com.fasterxml.jackson.databind.ObjectMapper
import org.junit.jupiter.api.Test
import org.mockito.kotlin.any
import org.mockito.kotlin.given
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest
import org.springframework.boot.test.mock.mockito.MockBean
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.*
import java.util.*

@WebMvcTest(FranchiseController::class)
@AutoConfigureMockMvc(addFilters = false)
class FranchiseControllerTest {

    @Autowired
    private lateinit var mockMvc: MockMvc

    @MockBean
    private lateinit var franchiseService: FranchiseService

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

    @Test
    fun `getInvites should return list of invites`() {
        val franchiseId = UUID.randomUUID()
        val invites = listOf(
            FranchiseInvite(franchiseId = franchiseId, email = "test@example.com", expiresAt = java.time.Instant.now())
        )

        given(franchiseService.getInvites(franchiseId)).willReturn(invites)
        given(franchiseService.getInviteUrl(any())).willReturn("http://invite.url")

        mockMvc.perform(get("/franchises/$franchiseId/invites"))
            .andExpect(status().isOk)
            .andExpect(jsonPath("$.data.length()").value(1))
            .andExpect(jsonPath("$.data[0].email").value("test@example.com"))
    }

    @Test
    fun `getSquad should return squad summary`() {
        val franchiseId = UUID.randomUUID()
        val franchise = Franchise(id = franchiseId, leagueId = UUID.randomUUID(), ownerId = UUID.randomUUID(), name = "Test Team")
        val squad = listOf(
            AuctionPlayerSummary(playerName = "Player 1", playerCategory = "BATTER", finalPrice = 1000, assignmentType = "SOLD", roundNumber = 1)
        )

        given(franchiseService.getFranchise(franchiseId)).willReturn(franchise)
        given(franchiseService.getSquad(franchiseId)).willReturn(squad)

        mockMvc.perform(get("/franchises/$franchiseId/squad"))
            .andExpect(status().isOk)
            .andExpect(jsonPath("$.data.franchiseName").value("Test Team"))
            .andExpect(jsonPath("$.data.players.length()").value(1))
            .andExpect(jsonPath("$.data.players[0].playerName").value("Player 1"))
    }
}
