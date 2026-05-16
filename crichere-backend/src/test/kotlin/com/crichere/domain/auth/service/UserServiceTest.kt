package com.crichere.domain.auth.service

import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.auth.entity.User
import com.crichere.domain.auth.entity.UserLeagueMembership
import com.crichere.domain.auth.enums.LeagueRole
import com.crichere.domain.auth.repository.UserLeagueMembershipRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.repository.LeagueRepository
import io.mockk.*
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.data.domain.PageImpl
import org.springframework.data.domain.PageRequest
import software.amazon.awssdk.services.s3.presigner.S3Presigner
import java.util.*

class UserServiceTest {

    private val userRepository = mockk<UserRepository>()
    private val userLeagueMembershipRepository = mockk<UserLeagueMembershipRepository>()
    private val leagueRepository = mockk<LeagueRepository>()
    private val s3Presigner = mockk<S3Presigner>()
    private val bucketName = "test-bucket"

    private lateinit var userService: UserService

    private val userId = UUID.randomUUID()

    @BeforeEach
    fun setUp() {
        userService = UserService(
            userRepository,
            userLeagueMembershipRepository,
            leagueRepository,
            s3Presigner,
            bucketName
        )
    }

    @Test
    fun `getUserLeagues should return leagues for user`() {
        val leagueId1 = UUID.randomUUID()
        val leagueId2 = UUID.randomUUID()
        val memberships = listOf(
            UserLeagueMembership(userId = userId, leagueId = leagueId1, role = LeagueRole.AUCTIONEER),
            UserLeagueMembership(userId = userId, leagueId = leagueId2, role = LeagueRole.LEAGUE_ADMIN)
        )
        val league1 = League(id = leagueId1, name = "League 1", createdBy = UUID.randomUUID())
        val league2 = League(id = leagueId2, name = "League 2", createdBy = UUID.randomUUID())

        every { userLeagueMembershipRepository.findAllByUserId(userId) } returns memberships
        every { leagueRepository.findById(leagueId1) } returns Optional.of(league1)
        every { leagueRepository.findById(leagueId2) } returns Optional.of(league2)

        val result = userService.getUserLeagues(userId)

        assertEquals(2, result.size)
        assertEquals("League 1", result[0].name)
        assertEquals("League 2", result[1].name)
    }

    @Test
    fun `searchUsers should use repository for optimized search`() {
        val query = "test"
        val pageable = PageRequest.of(0, 10)
        val users = listOf(User(phone = "1234567890", name = "Test User"))
        val page = PageImpl(users, pageable, 1)

        every { userRepository.findByNameContainingIgnoreCaseOrPhoneContaining(query, query, pageable) } returns page

        val result = userService.searchUsers(query, pageable)

        assertEquals(1, result.totalElements)
        assertEquals("Test User", result.content[0].name)
        verify { userRepository.findByNameContainingIgnoreCaseOrPhoneContaining(query, query, pageable) }
    }

    @Test
    fun `getUserById should throw exception when user not found`() {
        every { userRepository.findById(userId) } returns Optional.empty()

        assertThrows(ResourceNotFoundException::class.java) {
            userService.getUserById(userId)
        }
    }
}
