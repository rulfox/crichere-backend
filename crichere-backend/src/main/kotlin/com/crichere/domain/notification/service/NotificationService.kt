package com.crichere.domain.notification.service

import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.common.provider.PushProvider
import com.crichere.domain.notification.dto.NotificationListResponse
import com.crichere.domain.notification.dto.NotificationResponse
import com.crichere.domain.notification.entity.DeviceToken
import com.crichere.domain.notification.entity.InAppNotification
import com.crichere.domain.notification.enums.NotificationType
import com.crichere.domain.notification.enums.Platform
import com.crichere.domain.notification.repository.DeviceTokenRepository
import com.crichere.domain.notification.repository.InAppNotificationRepository
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.util.*

@Service
class NotificationService(
    private val deviceTokenRepository: DeviceTokenRepository,
    private val inAppNotificationRepository: InAppNotificationRepository,
    private val pushProvider: PushProvider
) {

    @Transactional
    fun registerDeviceToken(userId: UUID, token: String, platform: Platform) {
        val existing = deviceTokenRepository.findByUserIdAndToken(userId, token)
        if (existing.isEmpty) {
            deviceTokenRepository.save(DeviceToken(userId = userId, token = token, platform = platform))
        }
    }

    @Transactional
    fun removeDeviceToken(userId: UUID, token: String) {
        val existing = deviceTokenRepository.findByUserIdAndToken(userId, token)
            .orElseThrow { ResourceNotFoundException("Token not found for user", "error.token_not_found") }
        deviceTokenRepository.delete(existing)
    }

    fun getNotifications(userId: UUID, unreadOnly: Boolean, pageable: Pageable): NotificationListResponse {
        val page = if (unreadOnly) {
            inAppNotificationRepository.findByUserIdAndReadAtIsNullOrderByCreatedAtDesc(userId, pageable)
        } else {
            inAppNotificationRepository.findByUserIdOrderByCreatedAtDesc(userId, pageable)
        }
        
        val unreadCount = inAppNotificationRepository.countByUserIdAndReadAtIsNull(userId)
        
        return NotificationListResponse(
            notifications = page.content.map { mapToResponse(it) },
            unreadCount = unreadCount,
            totalElements = page.totalElements,
            totalPages = page.totalPages,
            pageNumber = page.number,
            pageSize = page.size
        )
    }

    fun getUnreadCount(userId: UUID): Long {
        return inAppNotificationRepository.countByUserIdAndReadAtIsNull(userId)
    }

    @Transactional
    fun markAsRead(notificationId: UUID, userId: UUID): NotificationResponse {
        val notification = inAppNotificationRepository.findById(notificationId)
            .orElseThrow { ResourceNotFoundException("Notification not found") }
        
        if (notification.userId != userId) {
            throw com.crichere.common.exception.UnauthorizedException("Cannot read someone else's notification")
        }

        if (notification.readAt == null) {
            notification.readAt = Instant.now()
            inAppNotificationRepository.save(notification)
        }
        return mapToResponse(notification)
    }

    @Transactional
    fun markAllAsRead(userId: UUID) {
        val unread = inAppNotificationRepository.findByUserIdAndReadAtIsNullOrderByCreatedAtDesc(userId, Pageable.unpaged())
        unread.forEach { 
            it.readAt = Instant.now()
            inAppNotificationRepository.save(it)
        }
    }

    @Transactional
    fun deleteNotification(notificationId: UUID, userId: UUID) {
        val notification = inAppNotificationRepository.findById(notificationId)
            .orElseThrow { ResourceNotFoundException("Notification not found") }
        
        if (notification.userId != userId) {
            throw com.crichere.common.exception.UnauthorizedException("Cannot delete someone else's notification")
        }

        inAppNotificationRepository.delete(notification)
    }

    @Transactional
    fun createAndSend(userId: UUID, type: NotificationType, title: String, body: String, payload: Map<String, Any?> = emptyMap()) {
        inAppNotificationRepository.save(InAppNotification(
            userId = userId,
            type = type,
            title = title,
            body = body,
            payload = payload
        ))
        pushProvider.sendPush(userId, title, body, payload)
    }

    // Event-specific methods
    @Transactional
    fun notifyAuctionStarted(userIds: List<UUID>, leagueId: UUID, leagueName: String) {
        userIds.forEach { userId ->
            createAndSend(userId, NotificationType.AUCTION_STARTED, "Auction Started!", "The auction for $leagueName has begun.", mapOf("leagueId" to leagueId))
        }
    }

    @Transactional
    fun notifyPlayerSold(userId: UUID, franchiseName: String, finalPrice: Int) {
        createAndSend(userId, NotificationType.PLAYER_SOLD, "Sold!", "You have been sold to $franchiseName for $finalPrice.", emptyMap())
    }

    @Transactional
    fun notifyPlayerAcquired(ownerUserId: UUID, playerName: String, franchiseName: String, finalPrice: Int) {
        createAndSend(
            ownerUserId,
            NotificationType.PLAYER_SOLD,
            "New signing for $franchiseName",
            "$franchiseName acquired $playerName for $finalPrice.",
            emptyMap()
        )
    }

    @Transactional
    fun notifyForfeitApproved(userId: UUID, leagueName: String) {
        createAndSend(userId, NotificationType.FORFEIT_APPROVED, "Forfeit Approved", "Your forfeit request for $leagueName has been approved.", emptyMap())
    }

    @Transactional
    fun notifyWaitingListPromoted(userId: UUID, leagueName: String) {
        createAndSend(userId, NotificationType.WAITING_LIST_PROMOTED, "Promoted!", "You have been promoted from the waiting list in $leagueName.", emptyMap())
    }

    @Transactional
    fun notifyFeePaymentRecorded(userId: UUID, amount: Int) {
        createAndSend(userId, NotificationType.FEE_PAYMENT_RECORDED, "Payment Recorded", "A payment of $amount has been recorded.", emptyMap())
    }

    private fun mapToResponse(n: InAppNotification) = NotificationResponse(
        n.id, n.userId, n.type, n.title, n.body, n.payload, n.readAt, n.createdAt
    )
}
