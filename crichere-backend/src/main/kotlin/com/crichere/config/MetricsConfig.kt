package com.crichere.config

import io.micrometer.core.instrument.binder.MeterBinder
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
class MetricsConfig {

    // Pre-registers counters at startup so they appear in /actuator/prometheus at 0
    // before any event fires. Services obtain the same instances via meterRegistry.counter().
    @Bean
    fun crichereMetrics(): MeterBinder = MeterBinder { registry ->
        registry.counter("crichere.otp.sent")
        registry.counter("crichere.otp.verified")
        registry.counter("crichere.auction.started")
        registry.counter("crichere.auction.bids.placed")
        registry.counter("crichere.auction.players.sold")
    }
}
