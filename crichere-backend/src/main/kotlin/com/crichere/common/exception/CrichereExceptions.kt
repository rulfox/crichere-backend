package com.crichere.common.exception

import org.springframework.http.HttpStatus

open class CrichereException(
    override val message: String,
    val messageKey: String,
    val status: HttpStatus = HttpStatus.INTERNAL_SERVER_ERROR
) : RuntimeException(message)

class ResourceNotFoundException(message: String, messageKey: String = "error.not_found") :
    CrichereException(message, messageKey, HttpStatus.NOT_FOUND)

class AlreadyExistsException(message: String, messageKey: String = "error.already_exists") :
    CrichereException(message, messageKey, HttpStatus.CONFLICT)

class UnauthorizedException(message: String, messageKey: String = "error.unauthorized") :
    CrichereException(message, messageKey, HttpStatus.UNAUTHORIZED)

class InvalidOtpException(message: String, messageKey: String = "error.invalid_otp") :
    CrichereException(message, messageKey, HttpStatus.BAD_REQUEST)

open class BusinessLogicException(message: String, messageKey: String, status: HttpStatus = HttpStatus.BAD_REQUEST) :
    CrichereException(message, messageKey, status)

class LeagueFullException(message: String, messageKey: String = "error.league_full") :
    BusinessLogicException(message, messageKey)

class InsufficientPurseException(message: String, messageKey: String = "error.insufficient_purse") :
    BusinessLogicException(message, messageKey)

class PlayerAlreadySoldException(message: String, messageKey: String = "error.player_already_sold") :
    BusinessLogicException(message, messageKey)

class FeeUnpaidException(message: String, messageKey: String = "error.fee_unpaid") :
    BusinessLogicException(message, messageKey)
