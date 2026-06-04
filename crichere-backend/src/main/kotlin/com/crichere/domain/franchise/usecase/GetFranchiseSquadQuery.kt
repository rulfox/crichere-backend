package com.crichere.domain.franchise.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.auction.dto.AuctionPlayerSummary
import com.crichere.domain.auction.repository.AuctionRoundConfigRepository
import com.crichere.domain.auction.repository.FranchisePlayerRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.franchise.error.FranchiseDomainError
import com.crichere.domain.player.repository.LeaguePlayerRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

interface GetFranchiseSquadQuery {
    fun execute(franchiseId: UUID): Result<List<AuctionPlayerSummary>, FranchiseDomainError>
}

@Service
class GetFranchiseSquadQueryImpl(
    private val franchisePlayerRepository: FranchisePlayerRepository,
    private val roundConfigRepository: AuctionRoundConfigRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val userRepository: UserRepository
) : GetFranchiseSquadQuery {

    @Transactional(readOnly = true)
    override fun execute(franchiseId: UUID): Result<List<AuctionPlayerSummary>, FranchiseDomainError> {
        val players = franchisePlayerRepository.findByFranchiseId(franchiseId)
        val roundIds = players.map { it.roundId }.distinct()
        val roundsById = if (roundIds.isEmpty()) emptyMap()
            else roundConfigRepository.findAllById(roundIds).associate { it.id to it.roundNumber }
        
        val summary = players.map { fp ->
            // In a strict microservice, this cross-domain call would be an API call or materialised view.
            // In our CQRS Modular Monolith, Read Models crossing boundaries are acceptable.
            val lp = leaguePlayerRepository.findById(fp.leaguePlayerId).get()
            val user = userRepository.findById(lp.userId).get()
            AuctionPlayerSummary(
                playerName = user.name ?: "Unknown",
                playerCategory = lp.category,
                finalPrice = fp.boughtPrice,
                assignmentType = "SOLD",
                roundNumber = roundsById[fp.roundId] ?: 1
            )
        }
        return Result.Success(summary)
    }
}
