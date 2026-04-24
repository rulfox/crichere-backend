package com.crichere.common.response

import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Component

object ResponseHelper {
    fun <T> success(data: T? = null, message: String? = null, messageKey: String? = null): ApiResponse<T> {
        return ApiResponse(
            success = true,
            message = message,
            messageKey = messageKey,
            data = data
        )
    }

    fun error(code: String, message: String? = null, messageKey: String? = null, details: List<String> = emptyList()): ApiResponse<Nothing> {
        return ApiResponse(
            success = false,
            message = message,
            messageKey = messageKey,
            error = ApiError(code, details)
        )
    }
}
