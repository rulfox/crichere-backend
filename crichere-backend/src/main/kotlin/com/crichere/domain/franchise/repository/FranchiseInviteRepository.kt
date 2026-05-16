package com.crichere.domain.franchise.repository

import com.crichere.domain.franchise.entity.FranchiseInvite
import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface FranchiseInviteRepository : JpaRepository<FranchiseInvite, UUID> {
    fun findByToken(token: UUID): FranchiseInvite?
    fun findByFranchiseId(franchiseId: UUID): List<FranchiseInvite>
}
