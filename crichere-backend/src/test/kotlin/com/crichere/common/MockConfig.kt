package com.crichere.common

import com.crichere.common.provider.SmsProvider
import com.crichere.common.provider.PushProvider
import software.amazon.awssdk.services.s3.presigner.S3Presigner
import org.springframework.boot.test.context.TestConfiguration
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Primary
import org.springframework.data.redis.core.StringRedisTemplate
import io.mockk.mockk

@TestConfiguration
class MockConfig {
    @Bean
    @Primary
    fun smsProvider() = mockk<SmsProvider>(relaxed = true)

    @Bean
    @Primary
    fun pushProvider() = mockk<PushProvider>(relaxed = true)

    @Bean
    @Primary
    fun s3Presigner() = mockk<S3Presigner>(relaxed = true)

    @Bean
    @Primary
    fun stringRedisTemplate() = mockk<StringRedisTemplate>(relaxed = true)
}
