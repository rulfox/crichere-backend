package com.crichere.domain.notification.dto

import com.crichere.domain.notification.enums.NotificationType
import com.crichere.domain.notification.enums.Platform
import java.time.Instant
import java.util.UUID

data class DeviceTokenRequest(
    val token: String,
    val platform: Platform
)

data class NotificationResponse(
    val id: UUID,
    val userId: UUID,
    val type: NotificationType,
    val title: String,
    val body: String,
    val payload: Map<String, Any?>?,
    val readAt: Instant?,
    val createdAt: Instant
)

data class NotificationListResponse(
    val notifications: List<NotificationResponse>,
    val unreadCount: Long,
    val totalElements: Long,
    val totalPages: Int,
    val pageNumber: Int,
    val pageSize: Int
)
