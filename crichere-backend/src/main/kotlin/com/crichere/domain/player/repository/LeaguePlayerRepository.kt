package com.crichere.domain.player.repository

import com.crichere.domain.player.entity.LeaguePlayer
import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface LeaguePlayerRepository : JpaRepository<LeaguePlayer, UUID> {
    fun findByLeagueIdAndUserId(leagueId: UUID, userId: UUID): LeaguePlayer?
    fun findByLeagueId(leagueId: UUID): List<LeaguePlayer>
}
