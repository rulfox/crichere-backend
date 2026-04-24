package com.crichere.common.exception

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RestControllerAdvice
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler

@RestControllerAdvice
class GlobalExceptionHandler : ResponseEntityExceptionHandler() {

    @ExceptionHandler(CrichereException::class)
    fun handleCrichereException(ex: CrichereException): ResponseEntity<ApiResponse<Nothing>> {
        val response = ResponseHelper.error(
            code = ex.javaClass.simpleName,
            message = ex.message,
            messageKey = ex.messageKey
        )
        return ResponseEntity.status(ex.status).body(response)
    }

    @ExceptionHandler(Exception::class)
    fun handleAllExceptions(ex: Exception): ResponseEntity<ApiResponse<Nothing>> {
        val response = ResponseHelper.error(
            code = "InternalServerError",
            message = ex.message ?: "An unexpected error occurred",
            messageKey = "error.internal_server_error"
        )
        return ResponseEntity.internalServerError().body(response)
    }
}
