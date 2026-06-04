package com.crichere.domain.notification.usecase

import com.crichere.common.domain.Result
import com.crichere.common.provider.PushProvider
import com.crichere.domain.notification.dto.NotificationResponse
import com.crichere.domain.notification.entity.DeviceToken
import com.crichere.domain.notification.entity.InAppNotification
import com.crichere.domain.notification.enums.NotificationType
import com.crichere.domain.notification.enums.Platform
import com.crichere.domain.notification.error.NotificationDomainError
import com.crichere.domain.notification.repository.DeviceTokenRepository
import com.crichere.domain.notification.repository.InAppNotificationRepository
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.util.*

interface RegisterDeviceTokenUseCase {
    fun execute(userId: UUID, token: String, platform: Platform): Result<Unit, NotificationDomainError>
}

interface RemoveDeviceTokenUseCase {
    fun execute(userId: UUID, token: String): Result<Unit, NotificationDomainError>
}

interface MarkNotificationAsReadUseCase {
    fun execute(notificationId: UUID, userId: UUID): Result<NotificationResponse, NotificationDomainError>
}

interface MarkAllNotificationsAsReadUseCase {
    fun execute(userId: UUID): Result<Unit, NotificationDomainError>
}

interface DeleteNotificationUseCase {
    fun execute(notificationId: UUID, userId: UUID): Result<Unit, NotificationDomainError>
}

interface CreateAndSendNotificationUseCase {
    fun execute(userId: UUID, type: NotificationType, title: String, body: String, payload: Map<String, Any?> = emptyMap()): Result<Unit, NotificationDomainError>
}

@Service
class RegisterDeviceTokenUseCaseImpl(
    private val deviceTokenRepository: DeviceTokenRepository
) : RegisterDeviceTokenUseCase {
    @Transactional
    override fun execute(userId: UUID, token: String, platform: Platform): Result<Unit, NotificationDomainError> {
        val existing = deviceTokenRepository.findByUserIdAndToken(userId, token)
        if (existing.isEmpty) {
            deviceTokenRepository.save(DeviceToken(userId = userId, token = token, platform = platform))
        }
        return Result.Success(Unit)
    }
}

@Service
class RemoveDeviceTokenUseCaseImpl(
    private val deviceTokenRepository: DeviceTokenRepository
) : RemoveDeviceTokenUseCase {
    @Transactional
    override fun execute(userId: UUID, token: String): Result<Unit, NotificationDomainError> {
        val existing = deviceTokenRepository.findByUserIdAndToken(userId, token)
        if (existing.isEmpty) {
            return Result.Failure(NotificationDomainError.TokenNotFound())
        }
        deviceTokenRepository.delete(existing.get())
        return Result.Success(Unit)
    }
}

@Service
class MarkNotificationAsReadUseCaseImpl(
    private val inAppNotificationRepository: InAppNotificationRepository
) : MarkNotificationAsReadUseCase {
    @Transactional
    override fun execute(notificationId: UUID, userId: UUID): Result<NotificationResponse, NotificationDomainError> {
        val notificationOpt = inAppNotificationRepository.findById(notificationId)
        if (notificationOpt.isEmpty) {
            return Result.Failure(NotificationDomainError.NotificationNotFound(notificationId))
        }
        val notification = notificationOpt.get()
        if (notification.userId != userId) {
            return Result.Failure(NotificationDomainError.UnauthorizedAccess("Cannot read someone else's notification"))
        }

        if (notification.readAt == null) {
            notification.readAt = Instant.now()
            inAppNotificationRepository.save(notification)
        }
        
        return Result.Success(NotificationResponse(
            id = notification.id,
            userId = notification.userId,
            type = notification.type,
            title = notification.title,
            body = notification.body,
            payload = notification.payload,
            readAt = notification.readAt,
            createdAt = notification.createdAt
        ))
    }
}

@Service
class MarkAllNotificationsAsReadUseCaseImpl(
    private val inAppNotificationRepository: InAppNotificationRepository
) : MarkAllNotificationsAsReadUseCase {
    @Transactional
    override fun execute(userId: UUID): Result<Unit, NotificationDomainError> {
        val unread = inAppNotificationRepository.findByUserIdAndReadAtIsNullOrderByCreatedAtDesc(userId, Pageable.unpaged())
        unread.forEach { 
            it.readAt = Instant.now()
            inAppNotificationRepository.save(it)
        }
        return Result.Success(Unit)
    }
}

@Service
class DeleteNotificationUseCaseImpl(
    private val inAppNotificationRepository: InAppNotificationRepository
) : DeleteNotificationUseCase {
    @Transactional
    override fun execute(notificationId: UUID, userId: UUID): Result<Unit, NotificationDomainError> {
        val notificationOpt = inAppNotificationRepository.findById(notificationId)
        if (notificationOpt.isEmpty) {
            return Result.Failure(NotificationDomainError.NotificationNotFound(notificationId))
        }
        val notification = notificationOpt.get()
        if (notification.userId != userId) {
            return Result.Failure(NotificationDomainError.UnauthorizedAccess("Cannot delete someone else's notification"))
        }

        inAppNotificationRepository.delete(notification)
        return Result.Success(Unit)
    }
}

@Service
class CreateAndSendNotificationUseCaseImpl(
    private val inAppNotificationRepository: InAppNotificationRepository,
    private val pushProvider: PushProvider
) : CreateAndSendNotificationUseCase {
    @Transactional
    override fun execute(userId: UUID, type: NotificationType, title: String, body: String, payload: Map<String, Any?>): Result<Unit, NotificationDomainError> {
        inAppNotificationRepository.save(InAppNotification(
            userId = userId,
            type = type,
            title = title,
            body = body,
            payload = payload
        ))
        pushProvider.sendPush(userId, title, body, payload)
        return Result.Success(Unit)
    }
}
