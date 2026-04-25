package com.crichere.common.provider

import org.slf4j.LoggerFactory
import org.springframework.context.annotation.Profile
import org.springframework.stereotype.Component
import java.util.UUID

interface PushProvider {
    fun sendPush(userId: UUID, title: String, body: String, payload: Map<String, Any?> = emptyMap()): Boolean
}

@Component
@Profile("dev")
class DevPushProvider : PushProvider {
    private val logger = LoggerFactory.getLogger(DevPushProvider::class.java)

    override fun sendPush(userId: UUID, title: String, body: String, payload: Map<String, Any?>): Boolean {
        logger.info("PUSH SENT [dev] to user $userId: Title='$title', Body='$body', Payload=$payload")
        return true
    }
}
