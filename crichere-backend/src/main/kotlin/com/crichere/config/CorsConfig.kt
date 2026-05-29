package com.crichere.config

import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.core.env.Environment
import org.springframework.web.cors.CorsConfiguration
import org.springframework.web.cors.CorsConfigurationSource
import org.springframework.web.cors.UrlBasedCorsConfigurationSource

@Configuration
class CorsConfig(
    @Value("\${crichere.cors.allowed-origins}") private val allowedOrigins: String,
    private val environment: Environment
) {

    @Bean
    fun corsConfigurationSource(): CorsConfigurationSource {
        val patterns = allowedOrigins.split(",").map { it.trim() }.filter { it.isNotEmpty() }
        require(patterns.isNotEmpty()) { "crichere.cors.allowed-origins must not be empty" }

        // We use addAllowedOriginPattern (NOT addAllowedOrigin), which permits "*" alongside
        // allowCredentials=true at the framework level. But with credentials enabled, a "*"
        // pattern reflects ANY request origin back as allowed — meaning any website could make
        // credentialed calls. That is acceptable for local dev only.
        val isProd = environment.activeProfiles.any { it.equals("prod", ignoreCase = true) }
        if (patterns.any { it == "*" }) {
            // Fail fast rather than silently shipping an open, credentialed CORS policy.
            require(!isProd) {
                "CORS allowed-origins must not include '*' under the 'prod' profile while " +
                    "allowCredentials=true. Set CORS_ALLOWED_ORIGINS to the explicit deployed " +
                    "web origin(s), e.g. https://app.crichere.live."
            }
            logger.warn(
                "CORS allowed-origin pattern '*' is in use with allowCredentials=true. " +
                    "This is fine for dev but must be tightened for production."
            )
        }

        val source = UrlBasedCorsConfigurationSource()
        val config = CorsConfiguration()
        config.allowCredentials = true
        patterns.forEach { config.addAllowedOriginPattern(it) }
        config.addAllowedHeader("*")
        config.addAllowedMethod("*")
        // Cache preflight results to cut OPTIONS chatter (incl. for SSE GETs).
        config.maxAge = 3600
        source.registerCorsConfiguration("/**", config)
        return source
    }

    companion object {
        private val logger = org.slf4j.LoggerFactory.getLogger(CorsConfig::class.java)
    }
}
