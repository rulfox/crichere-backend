package com.crichere.domain.auction.publisher

import com.crichere.domain.auction.entity.AuctionAuditLog
import com.crichere.domain.auction.enums.AuctionAction
import com.crichere.domain.auction.repository.AuctionAuditLogRepository
import com.fasterxml.jackson.databind.ObjectMapper
import jakarta.persistence.EntityManager
import org.slf4j.LoggerFactory
import org.springframework.data.redis.core.StringRedisTemplate
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Propagation
import org.springframework.transaction.annotation.Transactional
import org.springframework.transaction.support.TransactionSynchronization
import org.springframework.transaction.support.TransactionSynchronizationManager
import java.util.UUID

interface AuctionEventPublisher {
    fun publish(auctionId: UUID, action: AuctionAction, payload: Map<String, Any?>, actorId: UUID?)
}

@Component
class AuctionEventPublisherImpl(
    private val auditLogRepository: AuctionAuditLogRepository,
    private val redisTemplate: StringRedisTemplate,
    private val objectMapper: ObjectMapper,
    private val entityManager: EntityManager
) : AuctionEventPublisher {

    private val logger = LoggerFactory.getLogger(AuctionEventPublisherImpl::class.java)

    @Transactional(propagation = Propagation.MANDATORY)
    override fun publish(auctionId: UUID, action: AuctionAction, payload: Map<String, Any?>, actorId: UUID?) {
        // Atomic per-auction sequence allocation. UPDATE...RETURNING acquires the row
        // lock at the DB level so concurrent allocations serialize, even if the caller
        // did not take a JPA pessimistic write lock.
        val seq = (entityManager.createNativeQuery(
            "UPDATE auctions SET next_sequence_number = next_sequence_number + 1 WHERE id = :id RETURNING next_sequence_number"
        ).setParameter("id", auctionId).singleResult as Number).toLong()

        val logEntry = AuctionAuditLog(
            auctionId = auctionId,
            sequenceNumber = seq,
            action = action,
            payload = payload,
            actorId = actorId
        )
        auditLogRepository.save(logEntry)

        val message = mapOf(
            "id" to logEntry.sequenceNumber,
            "event" to action.name,
            "data" to payload
        )
        
        val json = objectMapper.writeValueAsString(message)
        
        if (TransactionSynchronizationManager.isActualTransactionActive()) {
            TransactionSynchronizationManager.registerSynchronization(
                object : TransactionSynchronization {
                    override fun afterCommit() {
                        publishToRedis(auctionId, action, json)
                    }
                }
            )
        } else {
            publishToRedis(auctionId, action, json)
        }
    }

    private fun publishToRedis(auctionId: UUID, action: AuctionAction, json: String) {
        try {
            redisTemplate.convertAndSend("auction:$auctionId", json)
        } catch (ex: Exception) {
            logger.error("Redis publish failed for auction $auctionId action $action — SSE event dropped", ex)
        }
    }
}
