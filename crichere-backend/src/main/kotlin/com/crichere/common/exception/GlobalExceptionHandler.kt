package com.crichere.common.exception

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import org.slf4j.LoggerFactory
import org.slf4j.MDC
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatusCode
import org.springframework.http.ResponseEntity
import org.springframework.http.converter.HttpMessageNotReadableException
import org.springframework.web.bind.MethodArgumentNotValidException
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RestControllerAdvice
import org.springframework.web.context.request.WebRequest
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler

@RestControllerAdvice
class GlobalExceptionHandler : ResponseEntityExceptionHandler() {

    private val log = LoggerFactory.getLogger(GlobalExceptionHandler::class.java)

    @ExceptionHandler(CrichereException::class)
    fun handleCrichereException(ex: CrichereException): ResponseEntity<ApiResponse<Nothing>> {
        // Business exceptions are caller-visible: keep their message.
        val response = ResponseHelper.error(
            code = ex.javaClass.simpleName,
            message = ex.message,
            messageKey = ex.messageKey
        )
        return ResponseEntity.status(ex.status).body(response)
    }

    override fun handleHttpMessageNotReadable(
        ex: HttpMessageNotReadableException,
        headers: HttpHeaders,
        status: HttpStatusCode,
        request: WebRequest
    ): ResponseEntity<Any> {
        val response = ResponseHelper.error(
            code = "BadRequest",
            message = "Request body is missing or malformed",
            messageKey = "error.bad_request"
        )
        return ResponseEntity.badRequest().body(response)
    }

    override fun handleMethodArgumentNotValid(
        ex: MethodArgumentNotValidException,
        headers: HttpHeaders,
        status: HttpStatusCode,
        request: WebRequest
    ): ResponseEntity<Any> {
        val errors = ex.bindingResult.fieldErrors.map { "${it.field}: ${it.defaultMessage}" }
        val response = ResponseHelper.error(
            code = "ValidationError",
            message = errors.joinToString("; "),
            messageKey = "error.validation_failed"
        )
        return ResponseEntity.badRequest().body(response)
    }

    @ExceptionHandler(Exception::class)
    fun handleAllExceptions(ex: Exception): ResponseEntity<ApiResponse<Nothing>> {
        val requestId = MDC.get("requestId")
        // Internal errors: log the full stack but never leak internals to the client.
        log.error("Unhandled exception (requestId=$requestId)", ex)
        val response = ResponseHelper.error(
            code = "InternalServerError",
            message = if (requestId != null) "Internal server error. Request id: $requestId" else "Internal server error",
            messageKey = "error.internal_server_error"
        )
        return ResponseEntity.internalServerError().body(response)
    }
}
