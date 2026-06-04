package com.crichere.domain.waitinglist.error

import com.crichere.common.domain.DomainError
import org.springframework.http.HttpStatus

sealed class WaitingListDomainError(
    override val message: String,
    override val messageKey: String?,
    val httpStatus: HttpStatus
) : DomainError {

    data class AlreadyOnWaitingList(
        override val message: String = "Already on waiting list",
        override val messageKey: String? = "error.already_on_waiting_list"
    ) : WaitingListDomainError(message, messageKey, HttpStatus.CONFLICT)

    data class AlreadyLeagueParticipant(
        override val message: String = "Already a participant in this league",
        override val messageKey: String? = "error.already_league_participant"
    ) : WaitingListDomainError(message, messageKey, HttpStatus.CONFLICT)

    data class PositionConflict(
        override val message: String = "Position conflict due to concurrent request. Please try again.",
        override val messageKey: String? = "error.waiting_list_position_conflict"
    ) : WaitingListDomainError(message, messageKey, HttpStatus.CONFLICT)

    data class EntryNotFound(
        override val message: String = "Entry not found",
        override val messageKey: String? = "error.waiting_list_entry_not_found"
    ) : WaitingListDomainError(message, messageKey, HttpStatus.NOT_FOUND)

    data class NotOnWaitingList(
        override val message: String = "Not on waiting list",
        override val messageKey: String? = "error.not_on_waiting_list"
    ) : WaitingListDomainError(message, messageKey, HttpStatus.NOT_FOUND)

    data class InvalidStatusTransition(
        override val message: String,
        override val messageKey: String? = "error.invalid_entry_status"
    ) : WaitingListDomainError(message, messageKey, HttpStatus.BAD_REQUEST)

    data class AutoPromoteModeActive(
        override val message: String = "Auto-promote mode is active",
        override val messageKey: String? = "error.auto_promote_mode_active"
    ) : WaitingListDomainError(message, messageKey, HttpStatus.BAD_REQUEST)

    data class Unauthorized(
        override val message: String = "Cannot perform this action on someone else's entry",
        override val messageKey: String? = "error.unauthorized"
    ) : WaitingListDomainError(message, messageKey, HttpStatus.FORBIDDEN)
}
