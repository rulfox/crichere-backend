package com.crichere.domain.notification.listener

import com.crichere.domain.auction.event.AuctionStartedApplicationEvent
import com.crichere.domain.auction.event.PlayerSoldApplicationEvent
import com.crichere.domain.notification.usecase.CreateAndSendNotificationUseCase
import com.crichere.domain.notification.enums.NotificationType
import org.springframework.context.event.EventListener
import org.springframework.stereotype.Component

@Component
class AuctionNotificationListener(
    private val createAndSendNotificationUseCase: CreateAndSendNotificationUseCase
) {

    @EventListener
    fun handleAuctionStarted(event: AuctionStartedApplicationEvent) {
        event.franchiseOwnerIds.forEach { ownerId ->
            createAndSendNotificationUseCase.execute(
                userId = ownerId,
                type = NotificationType.AUCTION_STARTED,
                title = "Auction Started",
                body = "The auction for ${event.leagueName} has started. Join now!",
                payload = mapOf("auctionId" to event.auctionId.toString())
            )
        }
    }

    @EventListener
    fun handlePlayerSold(event: PlayerSoldApplicationEvent) {
        createAndSendNotificationUseCase.execute(
            userId = event.userId,
            type = NotificationType.PLAYER_SOLD,
            title = "You have been sold!",
            body = "You were bought by ${event.franchiseName} for ${event.finalPrice}.",
            payload = emptyMap()
        )
        createAndSendNotificationUseCase.execute(
            userId = event.franchiseOwnerId,
            type = NotificationType.PLAYER_SOLD,
            title = "Player Acquired",
            body = "You successfully acquired ${event.playerName} for ${event.finalPrice}.",
            payload = emptyMap()
        )
    }
}
