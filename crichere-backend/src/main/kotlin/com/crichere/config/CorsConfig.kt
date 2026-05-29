package com.crichere.config

import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.cors.CorsConfiguration
import org.springframework.web.cors.CorsConfigurationSource
import org.springframework.web.cors.UrlBasedCorsConfigurationSource

@Configuration
class CorsConfig(
    @Value("\${crichere.cors.allowed-origins}") private val allowedOrigins: String
) {

    @Bean
    fun corsConfigurationSource(): CorsConfigurationSource {
        val patterns = allowedOrigins.split(",").map { it.trim() }.filter { it.isNotEmpty() }
        require(patterns.isNotEmpty()) { "crichere.cors.allowed-origins must not be empty" }

        // We use addAllowedOriginPattern (NOT addAllowedOrigin), which permits "*" alongside
        // allowCredentials=true at the framework level. We still warn in production-style
        // setups to nudge operators toward explicit origins, but do not block startup —
        // dev uses "*" for developer ergonomics.
        if (patterns.any { it == "*" }) {
            org.slf4j.LoggerFactory.getLogger(CorsConfig::class.java)
                .warn("CORS allowed-origin pattern '*' is in use with allowCredentials=true. " +
                      "This is fine for dev but should be tightened for production.")
        }

        val source = UrlBasedCorsConfigurationSource()
        val config = CorsConfiguration()
        config.allowCredentials = true
        patterns.forEach { config.addAllowedOriginPattern(it) }
        config.addAllowedHeader("*")
        config.addAllowedMethod("*")
        source.registerCorsConfiguration("/**", config)
        return source
    }
}
