package com.crichere.common.provider

import org.slf4j.LoggerFactory
import org.springframework.context.annotation.Profile
import org.springframework.stereotype.Component

@Component
@Profile("dev", "test")
class Msg91SmsProvider : SmsProvider {
    private val logger = LoggerFactory.getLogger(Msg91SmsProvider::class.java)

    override fun sendSms(phone: String, message: String) {
        logger.info("[SMS DEV] Sending SMS to $phone: $message")
    }

    override fun sendOtp(phone: String, otp: String) {
        logger.info("[SMS DEV] Sending OTP to $phone: $otp")
        println("\n\n****************************************")
        println("OTP for $phone: $otp")
        println("****************************************\n\n")
    }
}
