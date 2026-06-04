package com.crichere.domain.player.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.error.PlayerDomainError
import com.crichere.domain.player.repository.LeaguePlayerRepository
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

interface RegisterPlayerUseCase {
    fun execute(leaguePlayer: LeaguePlayer): Result<LeaguePlayer, PlayerDomainError>
}

@Service
class RegisterPlayerUseCaseImpl(
    private val leaguePlayerRepository: LeaguePlayerRepository
) : RegisterPlayerUseCase {
    @Transactional
    override fun execute(leaguePlayer: LeaguePlayer): Result<LeaguePlayer, PlayerDomainError> {
        return Result.Success(leaguePlayerRepository.save(leaguePlayer))
    }
}

interface GetLeaguePlayerQuery {
    fun execute(id: UUID): Result<LeaguePlayer, PlayerDomainError>
}

@Service
class GetLeaguePlayerQueryImpl(
    private val leaguePlayerRepository: LeaguePlayerRepository
) : GetLeaguePlayerQuery {
    @Transactional(readOnly = true)
    override fun execute(id: UUID): Result<LeaguePlayer, PlayerDomainError> {
        val player = leaguePlayerRepository.findByIdOrNull(id)
            ?: return Result.Failure(PlayerDomainError.PlayerNotFound(id))
        return Result.Success(player)
    }
}

interface GetPlayersInLeagueQuery {
    fun execute(leagueId: UUID, pageable: Pageable): Result<Page<LeaguePlayer>, PlayerDomainError>
}

@Service
class GetPlayersInLeagueQueryImpl(
    private val leaguePlayerRepository: LeaguePlayerRepository
) : GetPlayersInLeagueQuery {
    @Transactional(readOnly = true)
    override fun execute(leagueId: UUID, pageable: Pageable): Result<Page<LeaguePlayer>, PlayerDomainError> {
        return Result.Success(leaguePlayerRepository.findByLeagueId(leagueId, pageable))
    }
}
