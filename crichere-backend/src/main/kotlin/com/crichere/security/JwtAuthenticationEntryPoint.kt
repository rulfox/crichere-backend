package com.crichere.security

import com.crichere.common.response.ResponseHelper
import com.fasterxml.jackson.databind.ObjectMapper
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import org.springframework.http.MediaType
import org.springframework.security.core.AuthenticationException
import org.springframework.security.web.AuthenticationEntryPoint
import org.springframework.stereotype.Component

@Component
class JwtAuthenticationEntryPoint(private val objectMapper: ObjectMapper) : AuthenticationEntryPoint {

    override fun commence(
        request: HttpServletRequest,
        response: HttpServletResponse,
        authException: AuthenticationException
    ) {
        response.contentType = MediaType.APPLICATION_JSON_VALUE
        response.status = HttpServletResponse.SC_UNAUTHORIZED

        val apiResponse = ResponseHelper.error(
            code = "Unauthorized",
            message = "Full authentication is required to access this resource",
            messageKey = "error.unauthorized"
        )
        
        response.writer.write(objectMapper.writeValueAsString(apiResponse))
    }
}
