package com.crichere.domain.player.service

import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.repository.LeaguePlayerRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

@Service
class PlayerService(
    private val leaguePlayerRepository: LeaguePlayerRepository
) {

    @Transactional
    fun registerPlayer(leaguePlayer: LeaguePlayer): LeaguePlayer {
        return leaguePlayerRepository.save(leaguePlayer)
    }

    fun getLeaguePlayer(id: UUID): LeaguePlayer {
        return leaguePlayerRepository.findById(id).orElseThrow {
            ResourceNotFoundException("League player not found with id: $id")
        }
    }

    fun getPlayersInLeague(leagueId: UUID, pageable: org.springframework.data.domain.Pageable): org.springframework.data.domain.Page<LeaguePlayer> {
        return leaguePlayerRepository.findByLeagueId(leagueId, pageable)
    }
}
