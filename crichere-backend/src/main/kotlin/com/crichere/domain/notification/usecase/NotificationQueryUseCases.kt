package com.crichere.domain.notification.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.notification.dto.NotificationListResponse
import com.crichere.domain.notification.dto.NotificationResponse
import com.crichere.domain.notification.error.NotificationDomainError
import com.crichere.domain.notification.repository.InAppNotificationRepository
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

interface GetNotificationsQuery {
    fun execute(userId: UUID, unreadOnly: Boolean, pageable: Pageable): Result<NotificationListResponse, NotificationDomainError>
}

interface GetUnreadCountQuery {
    fun execute(userId: UUID): Result<Long, NotificationDomainError>
}

@Service
class GetNotificationsQueryImpl(
    private val inAppNotificationRepository: InAppNotificationRepository
) : GetNotificationsQuery {
    @Transactional(readOnly = true)
    override fun execute(userId: UUID, unreadOnly: Boolean, pageable: Pageable): Result<NotificationListResponse, NotificationDomainError> {
        val page = if (unreadOnly) {
            inAppNotificationRepository.findByUserIdAndReadAtIsNullOrderByCreatedAtDesc(userId, pageable)
        } else {
            inAppNotificationRepository.findByUserIdOrderByCreatedAtDesc(userId, pageable)
        }
        
        val unreadCount = inAppNotificationRepository.countByUserIdAndReadAtIsNull(userId)
        
        val response = NotificationListResponse(
            notifications = page.content.map { 
                NotificationResponse(
                    id = it.id,
                    userId = it.userId,
                    type = it.type,
                    title = it.title,
                    body = it.body,
                    payload = it.payload,
                    readAt = it.readAt,
                    createdAt = it.createdAt
                )
            },
            unreadCount = unreadCount,
            totalElements = page.totalElements,
            totalPages = page.totalPages,
            pageNumber = page.number,
            pageSize = page.size
        )
        return Result.Success(response)
    }
}

@Service
class GetUnreadCountQueryImpl(
    private val inAppNotificationRepository: InAppNotificationRepository
) : GetUnreadCountQuery {
    @Transactional(readOnly = true)
    override fun execute(userId: UUID): Result<Long, NotificationDomainError> {
        return Result.Success(inAppNotificationRepository.countByUserIdAndReadAtIsNull(userId))
    }
}
