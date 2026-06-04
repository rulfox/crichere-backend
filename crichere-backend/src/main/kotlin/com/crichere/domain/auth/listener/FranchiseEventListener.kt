package com.crichere.domain.auth.listener

import com.crichere.domain.auth.entity.UserFranchiseMembership
import com.crichere.domain.auth.repository.UserFranchiseMembershipRepository
import com.crichere.domain.franchise.event.FranchiseInviteAcceptedEvent
import org.springframework.context.event.EventListener
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

@Component
class FranchiseEventListener(
    private val membershipRepository: UserFranchiseMembershipRepository
) {

    @EventListener
    @Transactional
    fun handleFranchiseInviteAcceptedEvent(event: FranchiseInviteAcceptedEvent) {
        val existingMembership = membershipRepository.findByUserIdAndFranchiseId(event.userId, event.franchiseId)
        if (existingMembership == null) {
            membershipRepository.save(
                UserFranchiseMembership(
                    userId = event.userId,
                    franchiseId = event.franchiseId
                )
            )
        }
    }
}
