package com.crichere.domain.player.error

import com.crichere.common.domain.DomainError
import java.util.UUID

sealed class PlayerDomainError : DomainError {
    data class PlayerNotFound(val id: UUID) : PlayerDomainError() {
        override val message = "League player not found with id: $id"
        override val messageKey = "error.player_not_found"
    }
}
