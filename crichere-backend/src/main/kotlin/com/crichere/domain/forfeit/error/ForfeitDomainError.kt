package com.crichere.domain.forfeit.error

import com.crichere.common.domain.DomainError
import org.springframework.http.HttpStatus

sealed class ForfeitDomainError(
    override val message: String,
    override val messageKey: String?,
    val httpStatus: HttpStatus
) : DomainError {

    data class RequestNotFound(
        override val message: String = "Forfeit request not found",
        override val messageKey: String? = "error.forfeit_request_not_found"
    ) : ForfeitDomainError(message, messageKey, HttpStatus.NOT_FOUND)

    data class PendingRequestAlreadyExists(
        override val message: String = "A pending forfeit request already exists",
        override val messageKey: String? = "error.pending_forfeit_exists"
    ) : ForfeitDomainError(message, messageKey, HttpStatus.CONFLICT)

    data class NotLeagueParticipant(
        override val message: String = "User is not a participant in this league",
        override val messageKey: String? = "error.not_league_participant"
    ) : ForfeitDomainError(message, messageKey, HttpStatus.FORBIDDEN)

    data class InvalidRefundAmount(
        override val message: String = "Invalid refund amount",
        override val messageKey: String? = "error.invalid_refund_amount"
    ) : ForfeitDomainError(message, messageKey, HttpStatus.BAD_REQUEST)

    data class InvalidStatusTransition(
        override val message: String,
        override val messageKey: String? = "error.invalid_forfeit_status"
    ) : ForfeitDomainError(message, messageKey, HttpStatus.BAD_REQUEST)

    data class Unauthorized(
        override val message: String = "Cannot perform this action",
        override val messageKey: String? = "error.unauthorized"
    ) : ForfeitDomainError(message, messageKey, HttpStatus.FORBIDDEN)

    data class BusinessLogicError(
        override val message: String,
        override val messageKey: String?
    ) : ForfeitDomainError(message, messageKey, HttpStatus.BAD_REQUEST)
}
