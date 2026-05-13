package com.crichere.security

import org.slf4j.LoggerFactory
import org.springframework.data.redis.RedisConnectionFailureException
import org.springframework.data.redis.core.StringRedisTemplate
import org.springframework.stereotype.Service
import java.time.Duration
import java.time.Instant

@Service
class TokenBlacklistService(private val redisTemplate: StringRedisTemplate) {

    private val log = LoggerFactory.getLogger(javaClass)

    fun blacklist(token: String, expiresAt: Instant) {
        val ttl = Duration.between(Instant.now(), expiresAt)
        if (ttl.isNegative || ttl.isZero) return
        try {
            redisTemplate.opsForValue().set(redisKey(token), "1", ttl)
        } catch (e: RedisConnectionFailureException) {
            log.warn("Redis unavailable — token blacklist write skipped: {}", e.message)
        }
    }

    fun isBlacklisted(token: String): Boolean {
        return try {
            redisTemplate.hasKey(redisKey(token)) == true
        } catch (e: RedisConnectionFailureException) {
            log.warn("Redis unavailable — token blacklist check skipped, treating as not blacklisted: {}", e.message)
            false
        }
    }

    private fun redisKey(token: String) = "jwt:blacklist:${token.hashCode()}"
}
