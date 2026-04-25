package com.crichere.domain.league.repository

import com.crichere.domain.league.entity.League
import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface LeagueRepository : JpaRepository<League, UUID>
