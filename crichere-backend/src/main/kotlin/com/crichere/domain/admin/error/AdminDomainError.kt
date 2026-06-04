package com.crichere.domain.admin.error

import com.crichere.common.domain.DomainError
import org.springframework.http.HttpStatus
import java.util.UUID

sealed class AdminDomainError(
    override val message: String,
    override val messageKey: String?,
    val httpStatus: HttpStatus = HttpStatus.BAD_REQUEST
) : DomainError {
    class UserNotFound(userId: UUID) : AdminDomainError("User $userId not found", "error.user_not_found", HttpStatus.NOT_FOUND)
    class LeagueNotFound(leagueId: UUID) : AdminDomainError("League $leagueId not found", "error.league_not_found", HttpStatus.NOT_FOUND)
    object CannotRemoveOwnRole : AdminDomainError("Cannot remove own Platform Admin role", "error.cannot_remove_own_admin", HttpStatus.BAD_REQUEST)
    object SuspensionReasonRequired : AdminDomainError("Reason is required for suspension", "error.reason_required", HttpStatus.BAD_REQUEST)
}
