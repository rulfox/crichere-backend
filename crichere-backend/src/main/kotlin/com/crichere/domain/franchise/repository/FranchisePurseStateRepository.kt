package com.crichere.domain.franchise.repository

import com.crichere.domain.franchise.entity.FranchisePurseState
import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface FranchisePurseStateRepository : JpaRepository<FranchisePurseState, UUID> {
    fun findByFranchiseIdAndRoundId(franchiseId: UUID, roundId: UUID): FranchisePurseState?
    fun findByRoundId(roundId: UUID): List<FranchisePurseState>
    fun findByAuctionId(auctionId: UUID): List<FranchisePurseState>
}
