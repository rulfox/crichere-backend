package com.crichere.domain.forfeit.repository

import com.crichere.domain.forfeit.entity.ForfeitRequest
import com.crichere.domain.forfeit.enums.ForfeitStatus
import com.crichere.domain.forfeit.enums.ForfeitType
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface ForfeitRequestRepository : JpaRepository<ForfeitRequest, UUID> {
    fun findByLeagueIdAndUserIdAndStatus(leagueId: UUID, userId: UUID, status: ForfeitStatus): Optional<ForfeitRequest>
    
    fun findByLeagueId(leagueId: UUID, pageable: Pageable): Page<ForfeitRequest>
    fun findByLeagueIdAndStatus(leagueId: UUID, status: ForfeitStatus, pageable: Pageable): Page<ForfeitRequest>
    fun findByLeagueIdAndType(leagueId: UUID, type: ForfeitType, pageable: Pageable): Page<ForfeitRequest>
    fun findByLeagueIdAndStatusAndType(leagueId: UUID, status: ForfeitStatus, type: ForfeitType, pageable: Pageable): Page<ForfeitRequest>
}
