package com.crichere.config

import com.crichere.domain.auction.sse.SseBroadcaster
import com.fasterxml.jackson.databind.ObjectMapper
import org.slf4j.LoggerFactory
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.data.redis.connection.RedisConnectionFactory
import org.springframework.data.redis.listener.PatternTopic
import org.springframework.data.redis.listener.RedisMessageListenerContainer
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter
import org.springframework.data.redis.repository.configuration.EnableRedisRepositories
import java.util.*

// Restrict Spring Data Redis repository scanning to a dedicated (currently empty) sub-package.
// Without this, Redis auto-config scans all packages and emits a "Could not safely identify
// store assignment for OtpRepository" warning because OtpRepository (a JPA repo) is picked up.
@EnableRedisRepositories(basePackages = ["com.crichere.infrastructure.redis"])
@Configuration
class RedisConfig {

    private val logger = LoggerFactory.getLogger(RedisConfig::class.java)

    @Bean
    fun container(
        connectionFactory: RedisConnectionFactory,
        sseBroadcaster: SseBroadcaster
    ): RedisMessageListenerContainer {
        val container = object : RedisMessageListenerContainer() {
            override fun start() {
                try {
                    super.start()
                } catch (e: Exception) {
                    logger.warn("Redis pub/sub unavailable at startup — auction SSE broadcasting disabled: ${e.message}")
                }
            }
        }
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
