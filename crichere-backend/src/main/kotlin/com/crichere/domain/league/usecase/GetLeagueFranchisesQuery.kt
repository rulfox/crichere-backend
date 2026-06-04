package com.crichere.domain.league.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.franchise.entity.Franchise
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.league.error.LeagueDomainError
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

interface GetLeagueFranchisesQuery {
    fun execute(leagueId: UUID): Result<List<Franchise>, LeagueDomainError>
}

@Service
class GetLeagueFranchisesQueryImpl(
    private val franchiseRepository: FranchiseRepository
) : GetLeagueFranchisesQuery {
    @Transactional(readOnly = true)
    override fun execute(leagueId: UUID): Result<List<Franchise>, LeagueDomainError> {
        return Result.Success(franchiseRepository.findByLeagueId(leagueId))
    }
}
