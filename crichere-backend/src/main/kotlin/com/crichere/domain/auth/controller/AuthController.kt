package com.crichere.domain.auth.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.auth.dto.*
import com.crichere.domain.auth.service.AuthService
import com.crichere.domain.auth.service.UserService
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
    private val authService: AuthService,
    private val userService: UserService
) {

    @PostMapping("/otp/send")
    fun sendOtp(
        @Valid @RequestBody request: OtpSendRequest,
        httpRequest: HttpServletRequest
    ): ApiResponse<Nothing> {
        authService.sendOtp(request.phone, clientIp(httpRequest))
        return ResponseHelper.success(message = "OTP sent successfully", messageKey = "success.otp_sent")
    }

    @PostMapping("/otp/verify")
    fun verifyOtp(
        @Valid @RequestBody request: OtpVerifyRequest,
        httpRequest: HttpServletRequest
    ): ApiResponse<Map<String, Any>> {
        val result = authService.verifyOtpAndLogin(request.phone, request.code, clientIp(httpRequest))
        return ResponseHelper.success(data = result, message = "Login successful", messageKey = "success.login")
    }

    private fun clientIp(req: HttpServletRequest): String? {
        // Prefer the first entry in X-Forwarded-For (set by trusted proxies); fall back
        // to the socket remote address. Operators should ensure their LB strips spoofed
        // headers before the request reaches this app.
        val xff = req.getHeader("X-Forwarded-For")?.split(",")?.firstOrNull()?.trim()
        return xff?.takeIf { it.isNotBlank() } ?: req.remoteAddr
    }

    @PostMapping("/claim-profile")
    fun claimProfile(
        @AuthenticationPrincipal userDetails: UserDetails,
        @Valid @RequestBody request: ClaimProfileRequest
    ): ApiResponse<Nothing> {
        authService.claimProfile(UUID.fromString(userDetails.username), request)
        return ResponseHelper.success(message = "Profile claimed successfully", messageKey = "success.profile_claimed")
    }

    @PostMapping("/token/refresh")
    fun refreshToken(@Valid @RequestBody request: TokenRefreshRequest): ApiResponse<Map<String, String>> {
        val result = authService.refreshAccessToken(request.refreshToken)
        return ResponseHelper.success(data = result)
    }

    @PostMapping("/logout")
    fun logout(
        @AuthenticationPrincipal userDetails: UserDetails,
        httpRequest: HttpServletRequest
    ): ApiResponse<Nothing> {
        val token = httpRequest.getHeader("Authorization")?.removePrefix("Bearer ")
        authService.logout(UUID.fromString(userDetails.username), token)
        return ResponseHelper.success(message = "Logged out successfully", messageKey = "success.logout")
    }

    @GetMapping("/me")
    fun getCurrentUser(@AuthenticationPrincipal userDetails: UserDetails): ApiResponse<UserResponse> {
        val user = userService.getUserById(UUID.fromString(userDetails.username))
        val response = UserResponse(
            id = user.id,
            phone = user.phone,
            name = user.name,
            email = user.email,
            profileStatus = user.profileStatus,
            profilePhoto = user.profilePhoto,
            playingRole = user.playingRole,
            battingStyle = user.battingStyle,
            bowlingStyle = user.bowlingStyle,
            bowlingType = user.bowlingType,
            experienceLevel = user.experienceLevel,
            jerseyNumber = user.jerseyNumber,
            dateOfBirth = user.dateOfBirth,
            gender = user.gender,
            city = user.city,
            state = user.state
        )
        return ResponseHelper.success(data = response)
    }
}
