package com.crichere.common.response

import com.fasterxml.jackson.annotation.JsonInclude
import java.time.Instant

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ApiResponse<out T>(
    val success: Boolean,
    val message: String? = null,
    val messageKey: String? = null,
    val data: T? = null,
    val error: ApiError? = null,
    val timestamp: Instant = Instant.now()
)

data class ApiError(
    val code: String,
    val details: List<String> = emptyList()
)
