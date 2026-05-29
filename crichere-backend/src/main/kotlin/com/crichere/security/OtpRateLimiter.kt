package com.crichere.security

import com.crichere.common.exception.BusinessLogicException
import org.springframework.data.redis.core.StringRedisTemplate
import org.springframework.stereotype.Component
import java.time.Duration

/**
 * Redis-backed rate limiter for OTP send/verify endpoints. Uses fixed-window counters
 * keyed by phone and IP. The DB-side per-phone-per-hour limit in OtpService still applies
 * — these add burst protection (per-phone) and per-IP throttling (anti-rotation).
 */
@Component
class OtpRateLimiter(private val redis: StringRedisTemplate) {

    fun checkSend(phone: String, ip: String?) {
        check("otp:send:phone:30s:$phone", Duration.ofSeconds(30), max = 1, "error.otp_send_too_fast",
            "Please wait 30 seconds between OTP requests")
        check("otp:send:phone:24h:$phone", Duration.ofDays(1), max = 20, "error.otp_send_daily_cap",
            "Daily OTP send limit reached")
        if (!ip.isNullOrBlank()) {
            check("otp:send:ip:1m:$ip", Duration.ofMinutes(1), max = 10, "error.otp_send_ip_burst",
                "Too many OTP requests from this network")
            check("otp:send:ip:24h:$ip", Duration.ofDays(1), max = 100, "error.otp_send_ip_daily_cap",
                "Daily OTP request limit reached for this network")
        }
    }

    fun checkVerify(phone: String, ip: String?) {
        check("otp:verify:phone:5m:$phone", Duration.ofMinutes(5), max = 5, "error.otp_verify_burst",
            "Too many verification attempts. Try again in a few minutes")
        if (!ip.isNullOrBlank()) {
            check("otp:verify:ip:1m:$ip", Duration.ofMinutes(1), max = 20, "error.otp_verify_ip_burst",
                "Too many verification attempts from this network")
        }
    }

    private fun check(key: String, window: Duration, max: Long, errorKey: String, message: String) {
        val count = try {
            val current = redis.opsForValue().increment(key) ?: 1L
            if (current == 1L) redis.expire(key, window)
            current
        } catch (t: Throwable) {
            // Fail-open if Redis is down — DB-level limit and the OTP entity guards still apply.
            return
        }
        if (count > max) {
            throw BusinessLogicException(message, errorKey)
        }
    }
}
