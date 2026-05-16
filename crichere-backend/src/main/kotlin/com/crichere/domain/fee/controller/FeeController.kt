package com.crichere.domain.fee.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.fee.dto.*
import com.crichere.domain.fee.enums.FeeStatus
import com.crichere.domain.fee.enums.FeeType
import com.crichere.domain.fee.service.FeeService
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springframework.data.domain.PageRequest
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/leagues/{leagueId}")
@Tag(name = "Fee Management")
class FeeController(private val feeService: FeeService) {

    @PostMapping("/fee-obligations")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun createObligation(
        @PathVariable leagueId: UUID,
        @Valid @RequestBody request: FeeObligationCreateRequest
    ): ApiResponse<FeeObligationResponse> {
        return ResponseHelper.success(data = feeService.createObligation(leagueId, request))
    }

    @PostMapping("/fee-obligations/{obligationId}/payments")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun recordPayment(
        @PathVariable leagueId: UUID,
        @PathVariable obligationId: UUID,
        @Valid @RequestBody request: FeePaymentRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<FeeObligationResponse> {
        return ResponseHelper.success(data = feeService.recordPayment(leagueId, obligationId, request, UUID.fromString(user.username)))
    }

    @GetMapping("/fee-obligations")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun getObligations(
        @PathVariable leagueId: UUID,
        @RequestParam(required = false) status: FeeStatus?,
        @RequestParam(required = false) feeType: FeeType?,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<FeeObligationListResponse> {
        val resultPage = feeService.getObligations(leagueId, status, feeType, PageRequest.of(page, size))
        return ResponseHelper.success(data = FeeObligationListResponse(
            obligations = resultPage.content,
            totalElements = resultPage.totalElements,
            totalPages = resultPage.totalPages,
            pageNumber = resultPage.number,
            pageSize = resultPage.size
        ))
    }

    @GetMapping("/fee-obligations/{userId}")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId) or #userId.toString() == authentication.name")
    fun getObligationForUser(
        @PathVariable leagueId: UUID,
        @PathVariable userId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<FeeObligationDetailResponse> {
        return ResponseHelper.success(data = feeService.getObligationForUser(leagueId, userId))
    }

    @GetMapping("/fees/summary")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun getFeeSummary(@PathVariable leagueId: UUID): ApiResponse<FeeSummaryResponse> {
        return ResponseHelper.success(data = feeService.getFeeSummary(leagueId))
    }

    @PatchMapping("/fee-obligations/{obligationId}/waive")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun waiveObligation(
        @PathVariable leagueId: UUID,
        @PathVariable obligationId: UUID,
        @RequestBody request: Map<String, String>,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<FeeObligationResponse> {
        val reason = request["reason"] ?: throw com.crichere.common.exception.BusinessLogicException("Reason is required", "error.reason_required")
        return ResponseHelper.success(data = feeService.waiveObligation(leagueId, obligationId, reason, UUID.fromString(user.username)))
    }
}
