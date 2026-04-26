package com.crichere.security

import org.springframework.data.redis.core.StringRedisTemplate
import org.springframework.stereotype.Service
import java.time.Duration
import java.time.Instant

@Service
class TokenBlacklistService(private val redisTemplate: StringRedisTemplate) {

    fun blacklist(token: String, expiresAt: Instant) {
        val ttl = Duration.between(Instant.now(), expiresAt)
        if (ttl.isNegative || ttl.isZero) return
        redisTemplate.opsForValue().set(redisKey(token), "1", ttl)
    }

    fun isBlacklisted(token: String): Boolean =
        redisTemplate.hasKey(redisKey(token)) == true

    private fun redisKey(token: String) = "jwt:blacklist:${token.hashCode()}"
}
