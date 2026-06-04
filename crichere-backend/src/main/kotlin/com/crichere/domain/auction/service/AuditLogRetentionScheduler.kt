package com.crichere.domain.auction.service

import com.crichere.domain.auction.repository.AuctionAuditLogRepository
import net.javacrumbs.shedlock.spring.annotation.SchedulerLock
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional
import java.time.Instant
import java.time.temporal.ChronoUnit

/**
 * Nightly cleanup for `auction_audit_logs` belonging to long-completed auctions.
 * Retention window is configurable; default 90 days post-completion. Live auction
 * logs are never touched (status check is in the SQL).
 */
@Component
class AuditLogRetentionScheduler(
    private val auditLogRepository: AuctionAuditLogRepository,
    @param:Value("\${crichere.audit-log.retention-days:90}") private val retentionDays: Long
) {
    private val log = LoggerFactory.getLogger(AuditLogRetentionScheduler::class.java)

    // 03:15 server-time every day. Off-peak in IST and US.
    @Scheduled(cron = "0 15 3 * * *")
    @SchedulerLock(name = "auctionAuditLogRetention", lockAtMostFor = "PT30M", lockAtLeastFor = "PT5M")
    @Transactional
    fun purge() {
        val cutoff = Instant.now().minus(retentionDays, ChronoUnit.DAYS)
        val deleted = auditLogRepository.deleteCompletedBefore(cutoff)
        if (deleted > 0) {
            log.info("Purged $deleted auction_audit_logs rows older than $cutoff (retention=$retentionDays d)")
        }
    }
}
