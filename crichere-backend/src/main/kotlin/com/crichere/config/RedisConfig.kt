package com.crichere.config

import com.crichere.domain.auction.sse.SseBroadcaster
import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.data.redis.connection.RedisConnectionFactory
import org.springframework.data.redis.listener.PatternTopic
import org.springframework.data.redis.listener.RedisMessageListenerContainer
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter
import java.util.*

@Configuration
class RedisConfig {

    @Bean
    fun container(
        connectionFactory: RedisConnectionFactory,
        listenerAdapter: MessageListenerAdapter
    ): RedisMessageListenerContainer {
        val container = RedisMessageListenerContainer()
        container.setConnectionFactory(connectionFactory)
        container.addMessageListener(listenerAdapter, PatternTopic("auction:*"))
        return container
    }

    @Bean
    fun listenerAdapter(sseBroadcaster: SseBroadcaster, objectMapper: ObjectMapper): MessageListenerAdapter {
        return MessageListenerAdapter(object : Any() {
            fun handleMessage(message: String, channel: String) {
                val auctionId = UUID.fromString(channel.substringAfter("auction:"))
                // We assume the message is already a JSON string of the event
                // But SseBroadcaster.broadcast also serializes. 
                // Let's refine SseBroadcaster to take raw JSON if needed, 
                // or just pass the message string.
                sseBroadcaster.broadcastRaw(auctionId, message)
            }
        }, "handleMessage")
    }
}
