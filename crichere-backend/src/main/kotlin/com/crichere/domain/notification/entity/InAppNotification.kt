package com.crichere.domain.notification.entity

import com.crichere.domain.notification.enums.NotificationType
import jakarta.persistence.*
import org.hibernate.annotations.JdbcTypeCode
import org.hibernate.type.SqlTypes
import java.time.Instant
import java.util.*

@Entity
@Table(name = "in_app_notifications")
class InAppNotification(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(name = "user_id", nullable = false)
    val userId: UUID,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    val type: NotificationType,

    @Column(nullable = false, length = 200)
    val title: String,

    @Column(nullable = false, columnDefinition = "TEXT")
    val body: String,

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    val payload: Map<String, Any?>? = null,

    @Column(name = "read_at")
    var readAt: Instant? = null,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now()
)
