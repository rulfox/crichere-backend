package com.crichere.common.response

import com.crichere.common.domain.DomainError
import com.crichere.common.domain.Result
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity

fun <T> Result<T, DomainError>.toResponseEntity(
    message: String? = null,
    messageKey: String? = null,
    successStatus: HttpStatus = HttpStatus.OK
): ResponseEntity<ApiResponse<T>> {
    return when (this) {
        is Result.Success -> {
            val response = ApiResponse(
                success = true,
                data = this.data,
                message = message,
                messageKey = messageKey
            )
            ResponseEntity.status(successStatus).body(response)
        }
        is Result.Failure -> {
            val errorResponse = ApiResponse<T>(
                success = false,
                message = this.error.message,
                messageKey = this.error.messageKey,
                error = ApiError(
                    code = HttpStatus.BAD_REQUEST.name
                )
            )
            ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse)
        }
    }
}

fun <T, E : DomainError> Result<T, E>.getOrNull(): T? {
    return when (this) {
        is Result.Success -> this.data
        is Result.Failure -> null
    }
}
