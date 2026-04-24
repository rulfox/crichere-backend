package com.crichere.common.provider

interface SmsProvider {
    fun sendSms(phone: String, message: String)
    fun sendOtp(phone: String, otp: String)
}
