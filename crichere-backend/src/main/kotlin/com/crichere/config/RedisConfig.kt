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
        sseBroadcaster: SseBroadcaster
    ): RedisMessageListenerContainer {
        val container = RedisMessageListenerContainer()
        container.setConnectionFactory(connectionFactory)
        container.addMessageListener({ message, _ ->
            val channel = String(message.channel)
            val body = String(message.body)
            val auctionId = UUID.fromString(channel.substringAfter("auction:"))
            sseBroadcaster.broadcastRaw(auctionId, body)
        }, PatternTopic("auction:*"))
        return container
    }
}
