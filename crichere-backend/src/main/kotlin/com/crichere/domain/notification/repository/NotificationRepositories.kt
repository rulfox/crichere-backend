package com.crichere.domain.notification.repository

import com.crichere.domain.notification.entity.DeviceToken
import com.crichere.domain.notification.entity.InAppNotification
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface DeviceTokenRepository : JpaRepository<DeviceToken, UUID> {
    fun findByUserIdAndToken(userId: UUID, token: String): Optional<DeviceToken>
    fun deleteByUserIdAndToken(userId: UUID, token: String)
    fun findByUserId(userId: UUID): List<DeviceToken>
}

@Repository
interface InAppNotificationRepository : JpaRepository<InAppNotification, UUID> {
    fun findByUserIdOrderByCreatedAtDesc(userId: UUID, pageable: Pageable): Page<InAppNotification>
    fun findByUserIdAndReadAtIsNullOrderByCreatedAtDesc(userId: UUID, pageable: Pageable): Page<InAppNotification>
    fun countByUserIdAndReadAtIsNull(userId: UUID): Long
}
