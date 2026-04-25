package com.crichere.domain.league.repository

import com.crichere.domain.league.entity.LeagueCategoryBasePrice
import com.crichere.domain.league.entity.LeagueTagBasePrice
import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface LeagueCategoryBasePriceRepository : JpaRepository<LeagueCategoryBasePrice, UUID> {
    fun findByLeagueIdAndCategory(leagueId: UUID, category: String): LeagueCategoryBasePrice?
}

interface LeagueTagBasePriceRepository : JpaRepository<LeagueTagBasePrice, UUID> {
    fun findByLeagueIdAndTag(leagueId: UUID, tag: String): LeagueTagBasePrice?
}
