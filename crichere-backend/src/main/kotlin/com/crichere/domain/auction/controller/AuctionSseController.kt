package com.crichere.domain.auction.controller

import com.crichere.domain.auction.service.AuctionService
import com.crichere.domain.auction.sse.SseBroadcaster
import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.security.access.prepost.PreAuthorize
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
    @PreAuthorize("@auctionAuth.canView(#id, authentication)")
    fun streamEvents(
        @PathVariable id: UUID,
        @RequestHeader(name = "Last-Event-ID", required = false) headerLastId: Long?,
        @RequestParam(name = "lastEventId", required = false) queryLastId: Long?
    ): ResponseEntity<SseEmitter> {
        val lastEventId = headerLastId ?: queryLastId
        val emitter = SseEmitter(0L)

        emitter.send(SseEmitter.event().reconnectTime(3000L).comment("connected"))

        val snapshot = auctionService.getStateSnapshot(id)
        val baseSeq = snapshot.lastSequenceNumber
        val event = mapOf("event" to "SNAPSHOT", "data" to snapshot)
        emitter.send(
            SseEmitter.event()
                .id(baseSeq.toString())
                .name("SNAPSHOT")
                .data(objectMapper.writeValueAsString(event))
        )

        val replayFrom = lastEventId ?: baseSeq
        auctionService.getAuditLogs(id, replayFrom).forEach { log ->
            val payload = mapOf("id" to log.sequenceNumber, "event" to log.action.name, "data" to log.payload)
            emitter.send(
                SseEmitter.event()
                    .id(log.sequenceNumber.toString())
                    .name(log.action.name)
                    .data(objectMapper.writeValueAsString(payload))
            )
        }

        sseBroadcaster.addEmitter(id, emitter)

        return ResponseEntity.ok()
            .header(HttpHeaders.CACHE_CONTROL, "no-cache, no-transform")
            .header("X-Accel-Buffering", "no")
            .header(HttpHeaders.CONNECTION, "keep-alive")
            .body(emitter)
    }
}
