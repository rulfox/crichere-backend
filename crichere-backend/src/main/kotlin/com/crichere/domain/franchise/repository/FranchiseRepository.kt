package com.crichere.domain.franchise.repository

import com.crichere.domain.franchise.entity.Franchise
import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface FranchiseRepository : JpaRepository<Franchise, UUID> {
    fun findByLeagueId(leagueId: UUID): List<Franchise>
    fun findByOwnerId(ownerId: UUID): List<Franchise>
}
