package com.crichere.common.provider

import org.slf4j.LoggerFactory
import org.springframework.context.annotation.Profile
import org.springframework.stereotype.Component

interface SmsProvider {
    fun sendSms(phone: String, message: String)
    fun sendOtp(phone: String, otp: String)
}

@Component
@Profile("dev")
class DevSmsProvider : SmsProvider {
    private val logger = LoggerFactory.getLogger(DevSmsProvider::class.java)

    override fun sendSms(phone: String, message: String) {
        logger.info("SMS SENT [dev] to $phone: $message")
    }

    override fun sendOtp(phone: String, otp: String) {
        logger.info("OTP SENT [dev] to $phone: $otp")
    }
}

@Component
@Profile("prod")
class ProdSmsProvider : SmsProvider {
    private val logger = LoggerFactory.getLogger(ProdSmsProvider::class.java)

    override fun sendSms(phone: String, message: String) {
        logger.info("SMS SENT [prod] to $phone")
    }

    override fun sendOtp(phone: String, otp: String) {
        logger.info("OTP SENT [prod] to $phone")
    }
}
