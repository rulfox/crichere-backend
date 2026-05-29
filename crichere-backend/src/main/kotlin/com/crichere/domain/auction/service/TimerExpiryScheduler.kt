package com.crichere.domain.auction.service

import com.crichere.domain.auction.enums.PlayerAuctionStateValue
import com.crichere.domain.auction.repository.PlayerAuctionStateRepository
import com.crichere.domain.league.repository.AuctionRepository
import net.javacrumbs.shedlock.spring.annotation.SchedulerLock
import org.slf4j.LoggerFactory
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import java.time.Duration
import java.time.Instant
import java.util.*

/**
 * Watches every LIVE auction with an active countdown timer. When the timer expires,
 * either finalizes the sale to the current highest bidder or marks the player UNSOLD.
 * Runs every second; ShedLock serializes across replicas via JDBC.
 */
@Component
class TimerExpiryScheduler(
    private val auctionRepository: AuctionRepository,
    private val playerStateRepository: PlayerAuctionStateRepository,
    private val auctionService: AuctionService
) {
    private val logger = LoggerFactory.getLogger(TimerExpiryScheduler::class.java)

    // Synthetic system actor for auto-finalized actions
    private val systemActor: UUID = UUID.fromString("00000000-0000-0000-0000-000000000001")

    @Scheduled(fixedDelay = 1000)
    @SchedulerLock(name = "auctionTimerExpiry", lockAtMostFor = "PT10S", lockAtLeastFor = "PT1S")
    fun expireTimers() {
        val now = Instant.now()
        val candidates = auctionRepository.findAllWithActiveTimer()
        for (a in candidates) {
            val started = a.timerStartedAt ?: continue
            val duration = a.timerDurationSeconds ?: continue
            val elapsed = Duration.between(started, now).seconds
            if (elapsed < duration) continue

            val playerId = a.currentLeaguePlayerId ?: continue
            try {
                val state = playerStateRepository.findByAuctionIdAndLeaguePlayerId(a.id, playerId).orElse(null)
                    ?: continue
                if (state.state != PlayerAuctionStateValue.UP_FOR_BIDDING) continue

                val highBidder = state.currentHighestBidderId
                val highBid = state.currentHighestBid
                if (highBidder != null && highBid != null) {
                    auctionService.sellPlayer(a.id, playerId, highBidder, highBid, systemActor)
                } else {
                    auctionService.unsoldPlayer(a.id, playerId, systemActor)
                }
            } catch (t: Throwable) {
                logger.warn("Failed to auto-finalize auction ${a.id}: ${t.message}")
            }
        }
    }
}
