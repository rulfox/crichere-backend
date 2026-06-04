package com.crichere.config

import jakarta.annotation.PostConstruct
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Profile
import org.springframework.stereotype.Component

/**
 * Fail-fast in the `prod` profile if `crichere.jwt.secret` is missing, too short,
 * or still matches the published default in `application.yml`. Logs a warning in
 * non-prod profiles instead of crashing.
 */
@Component
class JwtSecretGuard(
    @param:Value("\${crichere.jwt.secret}") private val secret: String,
    @param:Value("\${spring.profiles.active:default}") private val activeProfile: String
) {
    private val log = LoggerFactory.getLogger(JwtSecretGuard::class.java)

    @PostConstruct
    fun verify() {
        val isProd = activeProfile.split(",").map { it.trim() }.any { it == "prod" }
        val problems = mutableListOf<String>()
        if (secret.isBlank()) problems += "secret is blank"
        if (secret.length < MIN_SECRET_LENGTH) problems += "secret is shorter than $MIN_SECRET_LENGTH characters"
        if (secret == DEFAULT_PUBLISHED_SECRET) problems += "secret matches the default value committed to application.yml"

        if (problems.isEmpty()) return

        val msg = "Insecure JWT secret detected: " + problems.joinToString("; ")
        if (isProd) {
            throw IllegalStateException("$msg. Set JWT_SECRET to a strong, randomly generated value in production.")
        }
        log.warn("$msg. This is tolerated outside the prod profile but MUST be fixed before deployment.")
    }

    companion object {
        // Keep in sync with the published default in application.yml.
        const val DEFAULT_PUBLISHED_SECRET = "404E635266556A586E3272357538782F413F4428472B4B6250645367566B5970"

        // 256 bits / HS256 minimum.
        const val MIN_SECRET_LENGTH = 32
    }
}
