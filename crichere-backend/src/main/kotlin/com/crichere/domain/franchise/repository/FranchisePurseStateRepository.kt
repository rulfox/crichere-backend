package com.crichere.domain.franchise.repository

import com.crichere.domain.franchise.entity.FranchisePurseState
import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface FranchisePurseStateRepository : JpaRepository<FranchisePurseState, UUID> {
    fun findByFranchiseIdAndAuctionIdAndRoundNumber(
        franchiseId: UUID,
        auctionId: UUID,
        roundNumber: Int
    ): FranchisePurseState?
}
