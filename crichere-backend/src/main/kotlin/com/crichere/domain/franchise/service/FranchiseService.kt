package com.crichere.domain.franchise.service

import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.franchise.entity.Franchise
import com.crichere.domain.franchise.entity.FranchiseInvite
import com.crichere.domain.franchise.repository.FranchiseInviteRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.time.temporal.ChronoUnit
import java.util.UUID

@Service
class FranchiseService(
    private val franchiseRepository: FranchiseRepository,
    private val franchiseInviteRepository: FranchiseInviteRepository,
    private val userRepository: com.crichere.domain.auth.repository.UserRepository,
    private val leagueRepository: com.crichere.domain.league.repository.LeagueRepository,
    private val membershipRepository: com.crichere.domain.auth.repository.UserFranchiseMembershipRepository,
    @org.springframework.beans.factory.annotation.Value("\${app.base-url:http://localhost:8080}")
    private val baseUrl: String
) {

    @Transactional
    fun createFranchise(franchise: Franchise): Franchise {
        return franchiseRepository.save(franchise)
    }

    fun getFranchise(id: UUID): Franchise {
        return franchiseRepository.findById(id).orElseThrow {
            ResourceNotFoundException("Franchise not found with id: $id")
        }
    }

    @Transactional
    fun createInvite(franchiseId: UUID, email: String): FranchiseInvite {
        val franchise = getFranchise(franchiseId)
        val invite = FranchiseInvite(
            franchiseId = franchise.id,
            email = email,
            token = UUID.randomUUID(),
            expiresAt = Instant.now().plus(7, ChronoUnit.DAYS)
        )
        return franchiseInviteRepository.save(invite)
    }

    fun getInviteByToken(token: UUID): FranchiseInvite {
        return franchiseInviteRepository.findByToken(token) ?: throw ResourceNotFoundException("Invite not found")
    }

    /**
     * Validates a franchise invite token.
     * Checks for expiration and usage limits.
     */
    fun validateInvite(token: UUID): com.crichere.domain.franchise.dto.InviteValidationResponse {
        val invite = getInviteByToken(token)
        if (invite.expiresAt.isBefore(Instant.now())) {
            throw com.crichere.common.exception.BusinessLogicException("Invite expired", "error.invite_expired")
        }
        if (invite.useCount >= invite.maxUses) {
            throw com.crichere.common.exception.BusinessLogicException("Invite already used", "error.invite_already_used")
        }

        val franchise = getFranchise(invite.franchiseId)
        val league = leagueRepository.findById(franchise.leagueId).get()
        val owner = userRepository.findById(franchise.ownerId).get()

        return com.crichere.domain.franchise.dto.InviteValidationResponse(
            valid = true,
            token = token,
            franchiseName = franchise.name,
            leagueName = league.name,
            invitedBy = owner.name ?: "Admin",
            expiresAt = invite.expiresAt
        )
    }

    /**
     * Processes an invite acceptance.
     * Creates a franchise membership for the user and updates the invite status.
     */
    @Transactional
    fun acceptInvite(token: UUID, userId: UUID): Franchise {
        val invite = getInviteByToken(token)
        if (invite.expiresAt.isBefore(Instant.now())) {
            throw com.crichere.common.exception.BusinessLogicException("Invite expired", "error.invite_expired")
        }
        if (invite.useCount >= invite.maxUses) {
            throw com.crichere.common.exception.BusinessLogicException("Invite already used", "error.invite_already_used")
        }

        val franchise = getFranchise(invite.franchiseId)
        
        // Add membership
        membershipRepository.save(com.crichere.domain.auth.entity.UserFranchiseMembership(
            userId = userId,
            franchiseId = franchise.id
        ))

        invite.useCount++
        invite.acceptedByUserId = userId
        invite.acceptedAt = Instant.now()
        if (invite.useCount >= invite.maxUses) {
            invite.status = com.crichere.domain.franchise.enums.FranchiseInviteStatus.ACCEPTED
        }
        franchiseInviteRepository.save(invite)

        return franchise
    }

    /**
     * Generates the public validation URL for an invite.
     */
    fun getInviteUrl(token: UUID): String {
        return "$baseUrl/api/v1/public/invites/validate?token=$token"
    }
}
