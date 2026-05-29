package com.crichere.domain.franchise.service

import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.auction.entity.FranchisePlayer
import com.crichere.domain.auction.repository.FranchisePlayerRepository
import com.crichere.domain.auth.repository.UserFranchiseMembershipRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.franchise.entity.Franchise
import com.crichere.domain.franchise.entity.FranchiseInvite
import com.crichere.domain.franchise.repository.FranchiseInviteRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.player.repository.LeaguePlayerRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.time.temporal.ChronoUnit
import java.util.*

@Service
class FranchiseService(
    private val franchiseRepository: FranchiseRepository,
    private val franchiseInviteRepository: FranchiseInviteRepository,
    private val userRepository: UserRepository,
    private val leagueRepository: LeagueRepository,
    private val membershipRepository: UserFranchiseMembershipRepository,
    private val franchisePlayerRepository: FranchisePlayerRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val roundConfigRepository: com.crichere.domain.auction.repository.AuctionRoundConfigRepository,
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
    fun updateFranchise(id: UUID, request: com.crichere.domain.franchise.dto.FranchiseUpdateRequest): Franchise {
        val franchise = getFranchise(id)
        request.name?.let { franchise.name = it }
        request.logoUrl?.let { franchise.logoUrl = it }
        request.totalPurse?.let { 
            val spent = franchise.totalPurse - franchise.remainingPurse
            franchise.totalPurse = it
            franchise.remainingPurse = it - spent
        }
        return franchiseRepository.save(franchise)
    }

    fun getInvites(franchiseId: UUID): List<FranchiseInvite> {
        return franchiseInviteRepository.findByFranchiseId(franchiseId)
    }

    fun getSquad(franchiseId: UUID): List<com.crichere.domain.auction.dto.AuctionPlayerSummary> {
        val players = franchisePlayerRepository.findByFranchiseId(franchiseId)
        val roundIds = players.map { it.roundId }.distinct()
        val roundsById = if (roundIds.isEmpty()) emptyMap()
            else roundConfigRepository.findAllById(roundIds).associate { it.id to it.roundNumber }
        return players.map { fp ->
            val lp = leaguePlayerRepository.findById(fp.leaguePlayerId).get()
            val user = userRepository.findById(lp.userId).get()
            com.crichere.domain.auction.dto.AuctionPlayerSummary(
                playerName = user.name ?: "Unknown",
                playerCategory = lp.category,
                finalPrice = fp.boughtPrice,
                assignmentType = "SOLD",
                roundNumber = roundsById[fp.roundId] ?: 1
            )
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

        // Idempotent membership add. Do NOT silently demote the existing owner — the
        // invite grants membership; explicit ownership transfer is a separate flow.
        val existingMembership = membershipRepository.findByUserIdAndFranchiseId(userId, franchise.id)
        if (existingMembership == null) {
            membershipRepository.save(com.crichere.domain.auth.entity.UserFranchiseMembership(
                userId = userId,
                franchiseId = franchise.id
            ))
        }

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
