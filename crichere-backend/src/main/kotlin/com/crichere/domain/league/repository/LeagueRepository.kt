package com.crichere.domain.league.repository

import com.crichere.domain.league.entity.League
import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface LeagueRepository : JpaRepository<League, UUID> {
    fun findByStatus(status: com.crichere.domain.league.enums.LeagueStatus, pageable: org.springframework.data.domain.Pageable): org.springframework.data.domain.Page<League>
    fun findByNameContainingIgnoreCase(name: String, pageable: org.springframework.data.domain.Pageable): org.springframework.data.domain.Page<League>
}
