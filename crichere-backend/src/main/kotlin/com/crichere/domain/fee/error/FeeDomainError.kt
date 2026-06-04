package com.crichere.domain.fee.error

import com.crichere.common.domain.DomainError
import org.springframework.http.HttpStatus

sealed class FeeDomainError(
    override val message: String,
    override val messageKey: String?,
    val httpStatus: HttpStatus
) : DomainError {
    
    data class ObligationNotFound(
        override val message: String = "Fee obligation not found",
        override val messageKey: String? = "error.fee_obligation_not_found"
    ) : FeeDomainError(message, messageKey, HttpStatus.NOT_FOUND)

    data class ObligationAlreadyExists(
        override val message: String = "Fee obligation already exists",
        override val messageKey: String? = "error.fee_obligation_already_exists"
    ) : FeeDomainError(message, messageKey, HttpStatus.CONFLICT)

    data class InvalidAmount(
        override val message: String = "Amount must be greater than zero",
        override val messageKey: String? = "error.invalid_amount"
    ) : FeeDomainError(message, messageKey, HttpStatus.BAD_REQUEST)
}
