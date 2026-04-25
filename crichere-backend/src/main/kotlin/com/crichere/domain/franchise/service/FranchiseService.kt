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
    private val franchiseInviteRepository: FranchiseInviteRepository
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
}
