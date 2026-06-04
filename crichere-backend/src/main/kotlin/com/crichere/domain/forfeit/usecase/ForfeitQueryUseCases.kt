package com.crichere.domain.forfeit.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.forfeit.dto.ForfeitRequestResponse
import com.crichere.domain.forfeit.entity.ForfeitRequest
import com.crichere.domain.forfeit.enums.ForfeitStatus
import com.crichere.domain.forfeit.enums.ForfeitType
import com.crichere.domain.forfeit.error.ForfeitDomainError
import com.crichere.domain.forfeit.repository.ForfeitRequestRepository
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Component
import java.util.UUID

@Component
class GetForfeitRequestsQuery(
    private val forfeitRequestRepository: ForfeitRequestRepository
) {
    fun execute(leagueId: UUID, status: ForfeitStatus?, type: ForfeitType?, pageable: Pageable): Result<Page<ForfeitRequestResponse>, ForfeitDomainError> {
        val page = when {
            status != null && type != null -> forfeitRequestRepository.findByLeagueIdAndStatusAndType(leagueId, status, type, pageable)
            status != null -> forfeitRequestRepository.findByLeagueIdAndStatus(leagueId, status, pageable)
            type != null -> forfeitRequestRepository.findByLeagueIdAndType(leagueId, type, pageable)
            else -> forfeitRequestRepository.findByLeagueId(leagueId, pageable)
        }
        return Result.Success(page.map { mapToResponse(it) })
    }

    private fun mapToResponse(f: ForfeitRequest) = ForfeitRequestResponse(
        f.id, f.leagueId, f.userId, f.franchiseId, f.type, f.reason, f.status, f.feeRefundDecision, f.feeRefundAmount, f.adminNotes, f.createdAt, f.resolvedAt
    )
}
