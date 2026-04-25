package com.crichere.domain.payment.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ApiError
import com.crichere.common.response.ResponseHelper
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.time.Instant
import java.util.*

@RestController
@RequestMapping("/subscriptions")
@Tag(name = "Payments Stub")
class PaymentStubController {

    private fun comingSoonResponse(): ResponseEntity<ApiResponse<Nothing>> {
        val response = ApiResponse<Nothing>(
            success = false,
            message = "This feature is coming in V2",
            messageKey = "error.coming_soon",
            error = ApiError(code = "NOT_IMPLEMENTED", details = emptyList()),
            timestamp = Instant.now()
        )
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(response)
    }

    @GetMapping("/leagues/{leagueId}")
    fun getSubscription(@PathVariable leagueId: UUID): ResponseEntity<ApiResponse<Nothing>> {
        return comingSoonResponse()
    }

    @PostMapping("/leagues/{leagueId}/initiate")
    fun initiateSubscription(@PathVariable leagueId: UUID): ResponseEntity<ApiResponse<Nothing>> {
        return comingSoonResponse()
    }

    @PostMapping("/webhook")
    fun paymentWebhook(): ResponseEntity<ApiResponse<Nothing>> {
        return comingSoonResponse()
    }

    @GetMapping("/leagues/{leagueId}/invoices")
    fun getInvoices(@PathVariable leagueId: UUID): ResponseEntity<ApiResponse<Nothing>> {
        return comingSoonResponse()
    }
}
