package com.crichere.domain.league.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.league.error.LeagueDomainError
import com.crichere.domain.league.repository.LeagueCategoryBasePriceRepository
import com.crichere.domain.league.repository.LeagueTagBasePriceRepository
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.repository.LeaguePlayerRepository
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID
import org.springframework.data.repository.findByIdOrNull

interface GetLeaguePlayersQuery {
    fun execute(leagueId: UUID, pageable: Pageable): Result<Page<LeaguePlayer>, LeagueDomainError>
}

@Service
class GetLeaguePlayersQueryImpl(
    private val leaguePlayerRepository: LeaguePlayerRepository
) : GetLeaguePlayersQuery {
    @Transactional(readOnly = true)
    override fun execute(leagueId: UUID, pageable: Pageable): Result<Page<LeaguePlayer>, LeagueDomainError> {
        return Result.Success(leaguePlayerRepository.findByLeagueId(leagueId, pageable))
    }
}

interface UpdatePlayerEligibilityUseCase {
    fun execute(leagueId: UUID, playerId: UUID, eligible: Boolean): Result<LeaguePlayer, LeagueDomainError>
}

@Service
class UpdatePlayerEligibilityUseCaseImpl(
    private val leaguePlayerRepository: LeaguePlayerRepository
) : UpdatePlayerEligibilityUseCase {
    @Transactional
    override fun execute(leagueId: UUID, playerId: UUID, eligible: Boolean): Result<LeaguePlayer, LeagueDomainError> {
        val player = leaguePlayerRepository.findByIdOrNull(playerId)
            ?: return Result.Failure(LeagueDomainError.PlayerNotFound(playerId))
        
        if (player.leagueId != leagueId) {
            return Result.Failure(LeagueDomainError.PlayerNotInLeague)
        }

        player.auctionEligible = eligible
        return Result.Success(leaguePlayerRepository.save(player))
    }
}

interface RemovePlayerUseCase {
    fun execute(leagueId: UUID, playerId: UUID): Result<Unit, LeagueDomainError>
}

@Service
class RemovePlayerUseCaseImpl(
    private val leaguePlayerRepository: LeaguePlayerRepository
) : RemovePlayerUseCase {
    @Transactional
    override fun execute(leagueId: UUID, playerId: UUID): Result<Unit, LeagueDomainError> {
        val player = leaguePlayerRepository.findByIdOrNull(playerId)
            ?: return Result.Failure(LeagueDomainError.PlayerNotFound(playerId))
        
        if (player.leagueId != leagueId) {
            return Result.Failure(LeagueDomainError.PlayerNotInLeague)
        }

        leaguePlayerRepository.delete(player)
        return Result.Success(Unit)
    }
}

interface ResolveBasePriceQuery {
    fun execute(leaguePlayerId: UUID): Result<Int, LeagueDomainError>
    fun execute(player: LeaguePlayer): Int
}

@Service
class ResolveBasePriceQueryImpl(
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val leagueTagBasePriceRepository: LeagueTagBasePriceRepository,
    private val leagueCategoryBasePriceRepository: LeagueCategoryBasePriceRepository
) : ResolveBasePriceQuery {

    @Transactional(readOnly = true)
    override fun execute(leaguePlayerId: UUID): Result<Int, LeagueDomainError> {
        val player = leaguePlayerRepository.findByIdOrNull(leaguePlayerId)
            ?: return Result.Failure(LeagueDomainError.PlayerNotFound(leaguePlayerId))
        
        return Result.Success(execute(player))
    }

    override fun execute(player: LeaguePlayer): Int {
        // Priority 1: basePriceOverride
        player.basePriceOverride?.let { return it }

        // Priority 2: LeagueTagBasePrice
        player.tag?.let { tag ->
            val tagPrice = leagueTagBasePriceRepository.findByLeagueIdAndTag(player.leagueId, tag)
            if (tagPrice != null) return tagPrice.price
        }

        // Priority 3: LeagueCategoryBasePrice
        player.category?.let { category ->
            val categoryPrice = leagueCategoryBasePriceRepository.findByLeagueIdAndCategory(player.leagueId, category)
            if (categoryPrice != null) return categoryPrice.price
        }

        return 0
    }
}
