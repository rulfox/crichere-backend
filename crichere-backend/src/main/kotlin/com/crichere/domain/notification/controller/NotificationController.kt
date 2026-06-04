package com.crichere.domain.notification.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.notification.dto.DeviceTokenRequest
import com.crichere.domain.notification.dto.NotificationListResponse
import com.crichere.domain.notification.dto.NotificationResponse
import com.crichere.domain.notification.usecase.*
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springframework.data.domain.PageRequest
import org.springframework.http.HttpStatus
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/notifications")
@Tag(name = "Notification Management")
class NotificationController(
    private val registerDeviceTokenUseCase: RegisterDeviceTokenUseCase,
    private val removeDeviceTokenUseCase: RemoveDeviceTokenUseCase,
    private val getUnreadCountQuery: GetUnreadCountQuery,
    private val getNotificationsQuery: GetNotificationsQuery,
    private val markNotificationAsReadUseCase: MarkNotificationAsReadUseCase,
    private val markAllNotificationsAsReadUseCase: MarkAllNotificationsAsReadUseCase,
    private val deleteNotificationUseCase: DeleteNotificationUseCase
) {

    @PostMapping("/device-token")
    fun registerToken(
        @Valid @RequestBody request: DeviceTokenRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Nothing> {
        val result = registerDeviceTokenUseCase.execute(UUID.fromString(user.username), request.token, request.platform)
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(message = "Device token registered", messageKey = "success.device_token_registered")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @DeleteMapping("/device-token")
    fun removeToken(
        @RequestBody request: Map<String, String>,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Nothing> {
        val token = request["token"] ?: return ResponseHelper.error(HttpStatus.BAD_REQUEST.name, "Token is required", "error.token_required")
        val result = removeDeviceTokenUseCase.execute(UUID.fromString(user.username), token)
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(message = "Device token removed", messageKey = "success.device_token_removed")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @GetMapping("/unread-count")
    fun getUnreadCount(@AuthenticationPrincipal user: UserDetails): ApiResponse<Map<String, Long>> {
        val result = getUnreadCountQuery.execute(UUID.fromString(user.username))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success<Map<String, Long>>(data = mapOf("unreadCount" to result.data))
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @GetMapping
    fun getNotifications(
        @RequestParam(defaultValue = "false") unreadOnly: Boolean,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<NotificationListResponse> {
        val result = getNotificationsQuery.execute(UUID.fromString(user.username), unreadOnly, PageRequest.of(page, size))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success<NotificationListResponse>(data = result.data)
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @PatchMapping("/{id}/read")
    fun markAsRead(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<NotificationResponse> {
        val result = markNotificationAsReadUseCase.execute(id, UUID.fromString(user.username))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success<NotificationResponse>(data = result.data)
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @PatchMapping("/read-all")
    fun markAllAsRead(@AuthenticationPrincipal user: UserDetails): ApiResponse<Nothing> {
        val result = markAllNotificationsAsReadUseCase.execute(UUID.fromString(user.username))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(message = "All notifications marked as read")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @DeleteMapping("/{id}")
    fun deleteNotification(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Nothing> {
        val result = deleteNotificationUseCase.execute(id, UUID.fromString(user.username))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(message = "Notification deleted")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }
}
