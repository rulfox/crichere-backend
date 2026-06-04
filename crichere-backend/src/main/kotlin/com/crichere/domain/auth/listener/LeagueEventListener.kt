package com.crichere.domain.auth.listener

import com.crichere.domain.auth.entity.UserLeagueMembership
import com.crichere.domain.auth.enums.LeagueRole
import com.crichere.domain.auth.repository.UserLeagueMembershipRepository
import com.crichere.domain.league.event.LeagueCreatedEvent
import org.springframework.context.event.EventListener
import org.springframework.stereotype.Component

@Component
class LeagueEventListener(
    private val userLeagueMembershipRepository: UserLeagueMembershipRepository
) {

    /**
     * Listens for LeagueCreatedEvent and automatically assigns the creator as the LEAGUE_ADMIN.
     * This decouples the League domain from the Auth domain.
     */
    @EventListener
    fun onLeagueCreated(event: LeagueCreatedEvent) {
        userLeagueMembershipRepository.save(
            UserLeagueMembership(
                userId = event.createdByUserId,
                leagueId = event.leagueId,
                role = LeagueRole.LEAGUE_ADMIN,
                isPrimary = true
            )
        )
    }
}
