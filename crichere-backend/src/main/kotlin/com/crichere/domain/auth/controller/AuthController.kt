package com.crichere.domain.auth.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.auth.dto.*
import com.crichere.domain.auth.usecase.*
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.servlet.http.HttpServletRequest
import jakarta.validation.Valid
import org.springframework.http.HttpStatus
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/auth")
@Tag(name = "Authentication")
class AuthController(
    private val sendOtpUseCase: SendOtpUseCase,
    private val verifyOtpAndLoginUseCase: VerifyOtpAndLoginUseCase,
    private val claimProfileUseCase: ClaimProfileUseCase,
    private val refreshAccessTokenUseCase: RefreshAccessTokenUseCase,
    private val logoutUseCase: LogoutUseCase,
    private val getUserProfileQuery: GetUserProfileQuery
) {

    @PostMapping("/otp/send")
    fun sendOtp(
        @Valid @RequestBody request: OtpSendRequest,
        httpRequest: HttpServletRequest
    ): ApiResponse<Nothing> {
        val result = sendOtpUseCase.execute(request.phone, clientIp(httpRequest))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(message = "OTP sent successfully", messageKey = "success.otp_sent")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @PostMapping("/otp/verify")
    fun verifyOtp(
        @Valid @RequestBody request: OtpVerifyRequest,
        httpRequest: HttpServletRequest
    ): ApiResponse<Map<String, Any>> {
        val result = verifyOtpAndLoginUseCase.execute(request.phone, request.code, clientIp(httpRequest))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(data = result.data, message = "Login successful", messageKey = "success.login")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    private fun clientIp(req: HttpServletRequest): String? {
        val xff = req.getHeader("X-Forwarded-For")?.split(",")?.firstOrNull()?.trim()
        return xff?.takeIf { it.isNotBlank() } ?: req.remoteAddr
    }

    @PostMapping("/claim-profile")
    fun claimProfile(
        @AuthenticationPrincipal userDetails: UserDetails,
        @Valid @RequestBody request: ClaimProfileRequest
    ): ApiResponse<Nothing> {
        val result = claimProfileUseCase.execute(UUID.fromString(userDetails.username), request)
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(message = "Profile claimed successfully", messageKey = "success.profile_claimed")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @PostMapping("/token/refresh")
    fun refreshToken(@Valid @RequestBody request: TokenRefreshRequest): ApiResponse<Map<String, String>> {
        val result = refreshAccessTokenUseCase.execute(request.refreshToken)
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(data = result.data)
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.UNAUTHORIZED.name, error.message, error.messageKey ?: "error.unauthorized")
        }
    }

    @PostMapping("/logout")
    fun logout(
        @AuthenticationPrincipal userDetails: UserDetails,
        httpRequest: HttpServletRequest
    ): ApiResponse<Nothing> {
        val token = httpRequest.getHeader("Authorization")?.removePrefix("Bearer ")
        val result = logoutUseCase.execute(UUID.fromString(userDetails.username), token)
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(message = "Logged out successfully", messageKey = "success.logout")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @GetMapping("/me")
    fun getCurrentUser(@AuthenticationPrincipal userDetails: UserDetails): ApiResponse<UserResponse> {
        val result = getUserProfileQuery.execute(UUID.fromString(userDetails.username))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(data = result.data)
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.NOT_FOUND.name, error.message, error.messageKey ?: "error.not_found")
        }
    }
}
