package com.crichere.domain.notification.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.notification.dto.DeviceTokenRequest
import com.crichere.domain.notification.dto.NotificationListResponse
import com.crichere.domain.notification.dto.NotificationResponse
import com.crichere.domain.notification.service.NotificationService
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.data.domain.PageRequest
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/notifications")
@Tag(name = "Notification Management")
class NotificationController(private val notificationService: NotificationService) {

    @PostMapping("/device-token")
    fun registerToken(
        @RequestBody request: DeviceTokenRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Nothing> {
        notificationService.registerDeviceToken(UUID.fromString(user.username), request.token, request.platform)
        return ResponseHelper.success(message = "Device token registered", messageKey = "success.device_token_registered")
    }

    @DeleteMapping("/device-token")
    fun removeToken(
        @RequestBody request: Map<String, String>,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Nothing> {
        val token = request["token"] ?: throw com.crichere.common.exception.BusinessLogicException("Token is required", "error.token_required")
        notificationService.removeDeviceToken(UUID.fromString(user.username), token)
        return ResponseHelper.success(message = "Device token removed", messageKey = "success.device_token_removed")
    }

    @GetMapping
    fun getNotifications(
        @RequestParam(defaultValue = "false") unreadOnly: Boolean,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<NotificationListResponse> {
        return ResponseHelper.success(data = notificationService.getNotifications(UUID.fromString(user.username), unreadOnly, PageRequest.of(page, size)))
    }

    @PatchMapping("/{id}/read")
    fun markAsRead(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<NotificationResponse> {
        return ResponseHelper.success(data = notificationService.markAsRead(id, UUID.fromString(user.username)))
    }
}
