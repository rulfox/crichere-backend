package com.crichere.config

import io.micrometer.core.instrument.Counter
import io.micrometer.core.instrument.MeterRegistry
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
class MetricsConfig {

    @Bean
    fun otpSentCounter(registry: MeterRegistry): Counter =
        Counter.builder("crichere.otp.sent")
            .description("Total OTPs sent")
            .register(registry)

    @Bean
    fun otpVerifiedCounter(registry: MeterRegistry): Counter =
        Counter.builder("crichere.otp.verified")
            .description("Total OTPs successfully verified")
            .register(registry)

    @Bean
    fun bidPlacedCounter(registry: MeterRegistry): Counter =
        Counter.builder("crichere.auction.bids.placed")
            .description("Total auction bids placed")
            .register(registry)

    @Bean
    fun auctionStartedCounter(registry: MeterRegistry): Counter =
        Counter.builder("crichere.auction.started")
            .description("Total auctions started")
            .register(registry)

    @Bean
    fun playerSoldCounter(registry: MeterRegistry): Counter =
        Counter.builder("crichere.auction.players.sold")
            .description("Total players sold in auctions")
            .register(registry)
}
