package com.crichere.domain.franchise.error

import com.crichere.common.domain.DomainError
import java.util.UUID

sealed class FranchiseDomainError : DomainError {
    
    data class FranchiseNotFound(val id: UUID) : FranchiseDomainError() {
        override val message = "Franchise not found with id: $id"
        override val messageKey = "error.franchise_not_found"
    }

    object InviteExpired : FranchiseDomainError() {
        override val message = "Invite expired"
        override val messageKey = "error.invite_expired"
    }

    object InviteAlreadyUsed : FranchiseDomainError() {
        override val message = "Invite already used"
        override val messageKey = "error.invite_already_used"
    }

    object InviteNotFound : FranchiseDomainError() {
        override val message = "Invite not found"
        override val messageKey = "error.invite_not_found"
    }
}
