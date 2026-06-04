package com.crichere.domain.franchise.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.franchise.dto.InviteValidationResponse
import com.crichere.domain.franchise.entity.Franchise
import com.crichere.domain.franchise.entity.FranchiseInvite
import com.crichere.domain.franchise.enums.FranchiseInviteStatus
import com.crichere.domain.franchise.error.FranchiseDomainError
import com.crichere.domain.franchise.event.FranchiseInviteAcceptedEvent
import com.crichere.domain.franchise.repository.FranchiseInviteRepository
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.league.repository.LeagueRepository
import org.springframework.context.ApplicationEventPublisher
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.time.temporal.ChronoUnit
import java.util.UUID

interface CreateFranchiseInviteUseCase {
    fun execute(franchiseId: UUID, email: String): Result<FranchiseInvite, FranchiseDomainError>
}

@Service
class CreateFranchiseInviteUseCaseImpl(
    private val franchiseInviteRepository: FranchiseInviteRepository,
    private val getFranchiseQuery: GetFranchiseQuery
) : CreateFranchiseInviteUseCase {
    @Transactional
    override fun execute(franchiseId: UUID, email: String): Result<FranchiseInvite, FranchiseDomainError> {
        val franchiseResult = getFranchiseQuery.execute(franchiseId)
        if (franchiseResult is Result.Failure) return franchiseResult

        val franchise = (franchiseResult as Result.Success).data
        val invite = FranchiseInvite(
            franchiseId = franchise.id,
            email = email,
            token = UUID.randomUUID(),
            expiresAt = Instant.now().plus(7, ChronoUnit.DAYS)
        )
        return Result.Success(franchiseInviteRepository.save(invite))
    }
}

interface GetFranchiseInvitesQuery {
    fun execute(franchiseId: UUID): Result<List<FranchiseInvite>, FranchiseDomainError>
}

@Service
class GetFranchiseInvitesQueryImpl(
    private val franchiseInviteRepository: FranchiseInviteRepository
) : GetFranchiseInvitesQuery {
    @Transactional(readOnly = true)
    override fun execute(franchiseId: UUID): Result<List<FranchiseInvite>, FranchiseDomainError> {
        return Result.Success(franchiseInviteRepository.findByFranchiseId(franchiseId))
    }
}

interface ValidateFranchiseInviteQuery {
    fun execute(token: UUID): Result<InviteValidationResponse, FranchiseDomainError>
}

@Service
class ValidateFranchiseInviteQueryImpl(
    private val franchiseInviteRepository: FranchiseInviteRepository,
    private val franchiseRepository: FranchiseRepository,
    private val leagueRepository: LeagueRepository,
    private val userRepository: UserRepository
) : ValidateFranchiseInviteQuery {
    @Transactional(readOnly = true)
    override fun execute(token: UUID): Result<InviteValidationResponse, FranchiseDomainError> {
        val invite = franchiseInviteRepository.findByToken(token) 
            ?: return Result.Failure(FranchiseDomainError.InviteNotFound)

        if (invite.expiresAt.isBefore(Instant.now())) {
            return Result.Failure(FranchiseDomainError.InviteExpired)
        }
        if (invite.useCount >= invite.maxUses) {
            return Result.Failure(FranchiseDomainError.InviteAlreadyUsed)
        }

        // We use get() here safely assuming DB integrity, but ideally we'd fetch safely.
        val franchise = franchiseRepository.findById(invite.franchiseId).get()
        val league = leagueRepository.findById(franchise.leagueId).get()
        val owner = userRepository.findById(franchise.ownerId).get()

        return Result.Success(
            InviteValidationResponse(
                valid = true,
                token = token,
                franchiseName = franchise.name,
                leagueName = league.name,
                invitedBy = owner.name ?: "Admin",
                expiresAt = invite.expiresAt
            )
        )
    }
}

interface AcceptFranchiseInviteUseCase {
    fun execute(token: UUID, userId: UUID): Result<Franchise, FranchiseDomainError>
}

@Service
class AcceptFranchiseInviteUseCaseImpl(
    private val franchiseInviteRepository: FranchiseInviteRepository,
    private val getFranchiseQuery: GetFranchiseQuery,
    private val eventPublisher: ApplicationEventPublisher
) : AcceptFranchiseInviteUseCase {
    @Transactional
    override fun execute(token: UUID, userId: UUID): Result<Franchise, FranchiseDomainError> {
        val invite = franchiseInviteRepository.findByToken(token) 
            ?: return Result.Failure(FranchiseDomainError.InviteNotFound)

        if (invite.expiresAt.isBefore(Instant.now())) {
            return Result.Failure(FranchiseDomainError.InviteExpired)
        }
        if (invite.useCount >= invite.maxUses) {
            return Result.Failure(FranchiseDomainError.InviteAlreadyUsed)
        }

        val franchiseResult = getFranchiseQuery.execute(invite.franchiseId)
        if (franchiseResult is Result.Failure) return franchiseResult
        val franchise = (franchiseResult as Result.Success).data

        // Publish event to Auth module instead of hard-coupling UserFranchiseMembershipRepository
        eventPublisher.publishEvent(FranchiseInviteAcceptedEvent(franchise.id, userId))

        invite.useCount++
        invite.acceptedByUserId = userId
        invite.acceptedAt = Instant.now()
        if (invite.useCount >= invite.maxUses) {
            invite.status = FranchiseInviteStatus.ACCEPTED
        }
        franchiseInviteRepository.save(invite)

        return Result.Success(franchise)
    }
}
