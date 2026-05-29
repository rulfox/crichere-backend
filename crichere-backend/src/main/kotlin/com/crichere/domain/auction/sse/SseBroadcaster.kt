package com.crichere.domain.auction.sse

import com.fasterxml.jackson.databind.ObjectMapper
import jakarta.annotation.PreDestroy
import org.slf4j.LoggerFactory
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter
import java.util.*
import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.CopyOnWriteArrayList
import java.util.concurrent.Executors

@Component
class SseBroadcaster(private val objectMapper: ObjectMapper) {
    private val logger = LoggerFactory.getLogger(SseBroadcaster::class.java)
    private val emitters = ConcurrentHashMap<UUID, CopyOnWriteArrayList<SseEmitter>>()

    private val executor = Executors.newFixedThreadPool(4) { r ->
        Thread(r, "sse-broadcast").apply { isDaemon = true }
    }

    fun addEmitter(auctionId: UUID, emitter: SseEmitter) {
        val auctionEmitters = emitters.computeIfAbsent(auctionId) { CopyOnWriteArrayList() }
        auctionEmitters.add(emitter)

        emitter.onCompletion { auctionEmitters.remove(emitter) }
        emitter.onTimeout {
            emitter.complete()
            auctionEmitters.remove(emitter)
        }
        emitter.onError { auctionEmitters.remove(emitter) }
    }

    fun broadcast(auctionId: UUID, event: Any) {
        val json = objectMapper.writeValueAsString(event)
        broadcastRaw(auctionId, json)
    }

    fun broadcastRaw(auctionId: UUID, json: String) {
        val auctionEmitters = emitters[auctionId] ?: return
        executor.submit {
            val dead = mutableListOf<SseEmitter>()
            auctionEmitters.forEach { emitter ->
                try {
                    emitter.send(SseEmitter.event().data(json))
                } catch (t: Throwable) {
                    dead.add(emitter)
                }
            }
            if (dead.isNotEmpty()) auctionEmitters.removeAll(dead)
        }
    }

    @Scheduled(fixedRate = 15000)
    fun sendKeepAlive() {
        emitters.forEach { (_, auctionEmitters) ->
            val dead = mutableListOf<SseEmitter>()
            auctionEmitters.forEach { emitter ->
                try {
                    emitter.send(SseEmitter.event().comment("keep-alive"))
                } catch (t: Throwable) {
                    dead.add(emitter)
                }
            }
            if (dead.isNotEmpty()) auctionEmitters.removeAll(dead)
        }
    }

    @PreDestroy
    fun shutdown() {
        executor.shutdownNow()
    }
}
