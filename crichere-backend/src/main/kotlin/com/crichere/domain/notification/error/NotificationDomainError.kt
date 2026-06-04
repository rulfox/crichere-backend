package com.crichere.domain.notification.error

import com.crichere.common.domain.DomainError
import java.util.UUID

sealed class NotificationDomainError(
    override val message: String,
    override val messageKey: String? = null
) : DomainError {
    class NotificationNotFound(id: UUID) : NotificationDomainError("Notification not found: $id", "error.notification_not_found")
    class TokenNotFound : NotificationDomainError("Device token not found", "error.token_not_found")
    class UnauthorizedAccess(msg: String) : NotificationDomainError(msg, "error.unauthorized")
}
