package com.crichere.domain.auction.controller

import com.crichere.domain.auction.service.AuctionService
import com.crichere.domain.auction.sse.SseBroadcaster
import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.http.MediaType
import org.springframework.web.bind.annotation.*
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter
import java.util.*

@RestController
@RequestMapping("/auctions")
class AuctionSseController(
    private val auctionService: AuctionService,
    private val sseBroadcaster: SseBroadcaster,
    private val objectMapper: ObjectMapper
) {

    @GetMapping("/{id}/events", produces = [MediaType.TEXT_EVENT_STREAM_VALUE])
    fun streamEvents(
        @PathVariable id: UUID,
        @RequestHeader(name = "Last-Event-ID", required = false) lastEventId: Long?
    ): SseEmitter {
        val emitter = SseEmitter(1800000L) // 30 minutes
        sseBroadcaster.addEmitter(id, emitter)

        if (lastEventId != null) {
            // Replay events
            val logs = auctionService.getAuditLogs(id, lastEventId)
            logs.forEach { log ->
                val event = mapOf(
                    "id" to log.sequenceNumber,
                    "event" to log.action.name,
                    "data" to log.payload
                )
                emitter.send(SseEmitter.event().id(log.sequenceNumber.toString()).data(objectMapper.writeValueAsString(event)))
            }
        } else {
            // Send current snapshot
            val snapshot = auctionService.getStateSnapshot(id)
            emitter.send(SseEmitter.event().name("SNAPSHOT").data(objectMapper.writeValueAsString(snapshot)))
        }

        return emitter
    }
}
