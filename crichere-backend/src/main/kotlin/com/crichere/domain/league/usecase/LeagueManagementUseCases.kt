package com.crichere.domain.league.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.error.LeagueDomainError
import com.crichere.domain.league.enums.LeagueStatus
import com.crichere.domain.league.repository.LeagueRepository
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID
import org.springframework.data.repository.findByIdOrNull

interface GetLeagueQuery {
    fun execute(id: UUID): Result<League, LeagueDomainError>
}

@Service
class GetLeagueQueryImpl(
    private val leagueRepository: LeagueRepository
) : GetLeagueQuery {
    @Transactional(readOnly = true)
    override fun execute(id: UUID): Result<League, LeagueDomainError> {
        val league = leagueRepository.findByIdOrNull(id)
            ?: return Result.Failure(LeagueDomainError.LeagueNotFound(id))
        return Result.Success(league)
    }
}

interface GetLeaguesQuery {
    fun execute(pageable: Pageable): Result<Page<League>, LeagueDomainError>
}

@Service
class GetLeaguesQueryImpl(
    private val leagueRepository: LeagueRepository
) : GetLeaguesQuery {
    @Transactional(readOnly = true)
    override fun execute(pageable: Pageable): Result<Page<League>, LeagueDomainError> {
        return Result.Success(leagueRepository.findAll(pageable))
    }
}

interface UpdateLeagueStatusUseCase {
    fun execute(leagueId: UUID, newStatus: LeagueStatus): Result<League, LeagueDomainError>
}

@Service
class UpdateLeagueStatusUseCaseImpl(
    private val getLeagueQuery: GetLeagueQuery,
    private val leagueRepository: LeagueRepository,
    private val initializeAuctionUseCase: InitializeAuctionUseCase
) : UpdateLeagueStatusUseCase {

    @Transactional
    override fun execute(leagueId: UUID, newStatus: LeagueStatus): Result<League, LeagueDomainError> {
        val leagueResult = getLeagueQuery.execute(leagueId)
        if (leagueResult is Result.Failure) return leagueResult

        val league = (leagueResult as Result.Success).data
        val validationResult = validateStatusTransition(league.status, newStatus)
        if (validationResult is Result.Failure) return validationResult

        if (newStatus == LeagueStatus.AUCTION_INITIALIZED) {
            val initResult = initializeAuctionUseCase.execute(league)
            if (initResult is Result.Failure) return initResult
        }

        league.status = newStatus
        return Result.Success(leagueRepository.save(league))
    }

    private fun validateStatusTransition(current: LeagueStatus, next: LeagueStatus): Result<Unit, LeagueDomainError> {
        val isValid = when (current) {
            LeagueStatus.DRAFT -> next == LeagueStatus.OPEN
            LeagueStatus.OPEN -> next == LeagueStatus.AUCTION_INITIALIZED || next == LeagueStatus.DRAFT
            LeagueStatus.AUCTION_INITIALIZED -> next == LeagueStatus.AUCTION_IN_PROGRESS
            LeagueStatus.AUCTION_IN_PROGRESS -> next == LeagueStatus.AUCTION_COMPLETED
            LeagueStatus.AUCTION_COMPLETED -> next == LeagueStatus.COMPLETED
            LeagueStatus.COMPLETED -> false
        }

        return if (isValid) Result.Success(Unit)
        else Result.Failure(LeagueDomainError.InvalidStatusTransition(current, next))
    }
}
