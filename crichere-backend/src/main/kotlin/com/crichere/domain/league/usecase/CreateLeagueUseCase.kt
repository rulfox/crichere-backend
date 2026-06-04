package com.crichere.domain.league.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.error.LeagueDomainError
import com.crichere.domain.league.event.LeagueCreatedEvent
import com.crichere.domain.league.repository.LeagueRepository
import org.springframework.context.ApplicationEventPublisher
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

/**
 * Use Case for creating a new League.
 */
interface CreateLeagueUseCase {
    /**
     * Executes the creation of a League.
     * @param league The League entity to create.
     * @return A [Result] containing the saved League or a DomainError.
     */
    fun execute(league: League): Result<League, LeagueDomainError>
}

@Service
class CreateLeagueUseCaseImpl(
    private val leagueRepository: LeagueRepository,
    private val eventPublisher: ApplicationEventPublisher
) : CreateLeagueUseCase {

    @Transactional
    override fun execute(league: League): Result<League, LeagueDomainError> {
        return try {
            val savedLeague = leagueRepository.save(league)
            
            // Publish event instead of directly calling AuthRepository
            eventPublisher.publishEvent(
                LeagueCreatedEvent(
                    leagueId = savedLeague.id,
                    createdByUserId = savedLeague.createdBy
                )
            )
            
            Result.Success(savedLeague)
        } catch (e: Exception) {
            // Ideally map DB constraint violations to domain errors, but for now wrap
            // generic failures. In a real system, we might define a generic DatabaseError.
            throw e 
        }
    }
}
