package com.crichere.domain.fee.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.fee.dto.*
import com.crichere.domain.fee.enums.FeeStatus
import com.crichere.domain.fee.enums.FeeType
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springframework.data.domain.PageRequest
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

import com.crichere.domain.fee.usecase.*

@RestController
@RequestMapping("/leagues/{leagueId}")
@Tag(name = "Fee Management")
class FeeController(
    private val createFeeObligationUseCase: CreateFeeObligationUseCase,
    private val recordFeePaymentUseCase: RecordFeePaymentUseCase,
    private val waiveFeeObligationUseCase: WaiveFeeObligationUseCase,
    private val getFeeObligationsQuery: GetFeeObligationsQuery,
    private val getFeeObligationForUserQuery: GetFeeObligationForUserQuery,
    private val getFeeSummaryQuery: GetFeeSummaryQuery
) {

    @PostMapping("/fee-obligations")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun createObligation(
        @PathVariable leagueId: UUID,
        @Valid @RequestBody request: FeeObligationCreateRequest
    ): ApiResponse<FeeObligationResponse> {
        return when (val result = createFeeObligationUseCase.execute(leagueId, request)) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(data = result.data)
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
    }

    @PostMapping("/fee-obligations/{obligationId}/payments")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun recordPayment(
        @PathVariable leagueId: UUID,
        @PathVariable obligationId: UUID,
        @Valid @RequestBody request: FeePaymentRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<FeeObligationResponse> {
        return when (val result = recordFeePaymentUseCase.execute(leagueId, obligationId, request, UUID.fromString(user.username))) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(data = result.data)
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
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
        return when (val result = getFeeObligationsQuery.execute(leagueId, status, feeType, PageRequest.of(page, size))) {
            is com.crichere.common.domain.Result.Success -> {
                val resultPage = result.data
                ResponseHelper.success(data = FeeObligationListResponse(
                    obligations = resultPage.content,
                    totalElements = resultPage.totalElements,
                    totalPages = resultPage.totalPages,
                    pageNumber = resultPage.number,
                    pageSize = resultPage.size
                ))
            }
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
    }

    @GetMapping("/fee-obligations/{userId}")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId) or #userId.toString() == authentication.name")
    fun getObligationForUser(
        @PathVariable leagueId: UUID,
        @PathVariable userId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<FeeObligationDetailResponse> {
        return when (val result = getFeeObligationForUserQuery.execute(leagueId, userId)) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(data = result.data)
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
    }

    @GetMapping("/fees/summary")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun getFeeSummary(@PathVariable leagueId: UUID): ApiResponse<FeeSummaryResponse> {
        return when (val result = getFeeSummaryQuery.execute(leagueId)) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(data = result.data)
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
    }

    @PatchMapping("/fee-obligations/{obligationId}/waive")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun waiveObligation(
        @PathVariable leagueId: UUID,
        @PathVariable obligationId: UUID,
        @RequestBody request: Map<String, String>,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<FeeObligationResponse> {
        val reason = request["reason"]
        if (reason == null) {
            return ResponseHelper.error(code = org.springframework.http.HttpStatus.BAD_REQUEST.name, message = "Reason is required", messageKey = "error.reason_required")
        }
        return when (val result = waiveFeeObligationUseCase.execute(leagueId, obligationId, reason, UUID.fromString(user.username))) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(data = result.data)
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
    }
}
