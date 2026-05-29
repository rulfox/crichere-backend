package com.crichere.domain.franchise.service

import com.crichere.common.exception.BusinessLogicException
import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.auth.entity.User
import com.crichere.domain.auth.entity.UserFranchiseMembership
import com.crichere.domain.auth.repository.UserFranchiseMembershipRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.franchise.entity.Franchise
import com.crichere.domain.franchise.entity.FranchiseInvite
import com.crichere.domain.franchise.enums.FranchiseInviteStatus
import com.crichere.domain.franchise.repository.FranchiseInviteRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.repository.LeagueRepository
import io.mockk.*
import io.mockk.impl.annotations.MockK
import io.mockk.junit5.MockKExtension
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import java.time.Instant
import java.time.temporal.ChronoUnit
import java.util.*

@ExtendWith(MockKExtension::class)
@DisplayName("FranchiseService Unit Tests")
class FranchiseServiceTest {

    @MockK lateinit var franchiseRepository: FranchiseRepository
    @MockK lateinit var franchiseInviteRepository: FranchiseInviteRepository
    @MockK lateinit var userRepository: UserRepository
    @MockK lateinit var leagueRepository: LeagueRepository
    @MockK lateinit var membershipRepository: UserFranchiseMembershipRepository
    @MockK lateinit var franchisePlayerRepository: com.crichere.domain.auction.repository.FranchisePlayerRepository
    @MockK lateinit var leaguePlayerRepository: com.crichere.domain.player.repository.LeaguePlayerRepository
    @MockK lateinit var roundConfigRepository: com.crichere.domain.auction.repository.AuctionRoundConfigRepository

    private lateinit var franchiseService: FranchiseService

    private val franchiseId = UUID.randomUUID()
    private val leagueId = UUID.randomUUID()
    private val ownerId = UUID.randomUUID()
    private val token = UUID.randomUUID()

    @BeforeEach
    fun setUp() {
        franchiseService = FranchiseService(
            franchiseRepository,
            franchiseInviteRepository,
            userRepository,
            leagueRepository,
            membershipRepository,
            franchisePlayerRepository,
            leaguePlayerRepository,
            roundConfigRepository,
            "http://localhost:8080"
        )
    }

    @Test
    @DisplayName("validateInvite - success")
    fun validateInviteSuccess() {
        val invite = FranchiseInvite(
            franchiseId = franchiseId,
            email = "test@example.com",
            token = token,
            expiresAt = Instant.now().plus(1, ChronoUnit.DAYS),
            maxUses = 1,
            useCount = 0
        )
        val franchise = Franchise(id = franchiseId, leagueId = leagueId, name = "Strikers", ownerId = ownerId, totalPurse = 1000)
        val league = League(id = leagueId, name = "CPL", createdBy = UUID.randomUUID(), status = com.crichere.domain.league.enums.LeagueStatus.DRAFT)
        val owner = User(id = ownerId, phone = "9999999999", profileStatus = com.crichere.domain.auth.enums.ProfileStatus.ACTIVE, name = "Admin")

        every { franchiseInviteRepository.findByToken(token) } returns invite
        every { franchiseRepository.findById(franchiseId) } returns Optional.of(franchise)
        every { leagueRepository.findById(leagueId) } returns Optional.of(league)
        every { userRepository.findById(ownerId) } returns Optional.of(owner)

        val result = franchiseService.validateInvite(token)

        assertTrue(result.valid)
        assertEquals("Strikers", result.franchiseName)
        assertEquals("CPL", result.leagueName)
        assertEquals("Admin", result.invitedBy)
    }

    @Test
    @DisplayName("validateInvite - expired")
    fun validateInviteExpired() {
        val invite = FranchiseInvite(
            franchiseId = franchiseId,
            email = "test@example.com",
            token = token,
            expiresAt = Instant.now().minus(1, ChronoUnit.DAYS)
        )

        every { franchiseInviteRepository.findByToken(token) } returns invite

        val exception = assertThrows(BusinessLogicException::class.java) {
            franchiseService.validateInvite(token)
        }
        assertEquals("error.invite_expired", exception.messageKey)
    }

    @Test
    @DisplayName("validateInvite - fully used")
    fun validateInviteUsed() {
        val invite = FranchiseInvite(
            franchiseId = franchiseId,
            email = "test@example.com",
            token = token,
            expiresAt = Instant.now().plus(1, ChronoUnit.DAYS),
            maxUses = 1,
            useCount = 1
        )

        every { franchiseInviteRepository.findByToken(token) } returns invite

        val exception = assertThrows(BusinessLogicException::class.java) {
            franchiseService.validateInvite(token)
        }
        assertEquals("error.invite_already_used", exception.messageKey)
    }

    @Test
    @DisplayName("acceptInvite - adds membership without overwriting owner")
    fun acceptInviteSuccess() {
        val invite = FranchiseInvite(
            franchiseId = franchiseId,
            email = "test@example.com",
            token = token,
            expiresAt = Instant.now().plus(1, ChronoUnit.DAYS),
            maxUses = 1,
            useCount = 0
        )
        val franchise = Franchise(id = franchiseId, leagueId = leagueId, name = "Strikers", ownerId = ownerId, totalPurse = 1000)
        val newUserId = UUID.randomUUID()

        every { franchiseInviteRepository.findByToken(token) } returns invite
        every { franchiseRepository.findById(franchiseId) } returns Optional.of(franchise)
        every { membershipRepository.findByUserIdAndFranchiseId(newUserId, franchiseId) } returns null
        every { membershipRepository.save(any()) } answers { firstArg() }
        every { franchiseInviteRepository.save(any()) } answers { firstArg() }

        franchiseService.acceptInvite(token, newUserId)

        assertEquals(1, invite.useCount)
        assertEquals(newUserId, invite.acceptedByUserId)
        assertEquals(FranchiseInviteStatus.ACCEPTED, invite.status)
        assertEquals(ownerId, franchise.ownerId) // Ownership preserved
        verify { membershipRepository.save(match { it.userId == newUserId && it.franchiseId == franchiseId }) }
    }

    @Test
    @DisplayName("getSquad - returns squad with player details")
    fun getSquadSuccess() {
        val player1Id = UUID.randomUUID()
        val user1Id = UUID.randomUUID()
        val squadEntities = listOf(
            com.crichere.domain.auction.entity.FranchisePlayer(franchiseId = franchiseId, leaguePlayerId = player1Id, boughtPrice = 500, roundId = UUID.randomUUID())
        )
        val leaguePlayer = com.crichere.domain.player.entity.LeaguePlayer(id = player1Id, leagueId = leagueId, userId = user1Id, category = "BATTER")
        val user = User(id = user1Id, phone = "1234567890", name = "Player One")

        every { franchisePlayerRepository.findByFranchiseId(franchiseId) } returns squadEntities
        every { leaguePlayerRepository.findById(player1Id) } returns Optional.of(leaguePlayer)
        every { userRepository.findById(user1Id) } returns Optional.of(user)
        every { leagueRepository.findById(leagueId) } returns Optional.of(League(id = leagueId, name = "CPL", createdBy = UUID.randomUUID()))
        every { roundConfigRepository.findAllById(any<Iterable<UUID>>()) } returns emptyList()

        val result = franchiseService.getSquad(franchiseId)

        assertEquals(1, result.size)
        assertEquals("Player One", result[0].playerName)
        assertEquals(500, result[0].finalPrice)
    }
}
