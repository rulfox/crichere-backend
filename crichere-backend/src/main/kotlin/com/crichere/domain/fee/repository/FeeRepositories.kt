package com.crichere.domain.fee.repository

import com.crichere.domain.fee.entity.FeeObligation
import com.crichere.domain.fee.entity.FeePayment
import com.crichere.domain.fee.enums.FeeStatus
import com.crichere.domain.fee.enums.FeeType
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface FeeObligationRepository : JpaRepository<FeeObligation, UUID> {
    fun findByLeagueIdAndUserIdAndFeeType(leagueId: UUID, userId: UUID, feeType: FeeType): Optional<FeeObligation>
    fun findByLeagueIdAndUserId(leagueId: UUID, userId: UUID): List<FeeObligation>
    
    fun findByLeagueId(leagueId: UUID, pageable: Pageable): Page<FeeObligation>
    fun findByLeagueIdAndStatus(leagueId: UUID, status: FeeStatus, pageable: Pageable): Page<FeeObligation>
    fun findByLeagueIdAndFeeType(leagueId: UUID, feeType: FeeType, pageable: Pageable): Page<FeeObligation>
    fun findByLeagueIdAndStatusAndFeeType(leagueId: UUID, status: FeeStatus, feeType: FeeType, pageable: Pageable): Page<FeeObligation>
    
    fun findByLeagueId(leagueId: UUID): List<FeeObligation>
}

@Repository
interface FeePaymentRepository : JpaRepository<FeePayment, UUID> {
    fun findByObligationIdOrderByCreatedAtDesc(obligationId: UUID): List<FeePayment>
}
