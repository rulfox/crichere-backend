package com.crichere.domain.forfeit.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.forfeit.dto.*
import com.crichere.domain.forfeit.enums.ForfeitStatus
import com.crichere.domain.forfeit.enums.ForfeitType
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springframework.data.domain.PageRequest
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

import com.crichere.domain.forfeit.usecase.*

@RestController
@RequestMapping("/leagues/{leagueId}")
@Tag(name = "Forfeit Management")
class ForfeitController(
    private val createForfeitRequestUseCase: CreateForfeitRequestUseCase,
    private val approveForfeitRequestUseCase: ApproveForfeitRequestUseCase,
    private val rejectForfeitRequestUseCase: RejectForfeitRequestUseCase,
    private val cancelForfeitRequestUseCase: CancelForfeitRequestUseCase,
    private val getForfeitRequestsQuery: GetForfeitRequestsQuery
) {

    @PostMapping("/forfeit")
    @PreAuthorize("isAuthenticated()")
    fun createRequest(
        @PathVariable leagueId: UUID,
        @Valid @RequestBody request: ForfeitRequestCreateRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<ForfeitRequestResponse> {
        return when (val result = createForfeitRequestUseCase.execute(leagueId, UUID.fromString(user.username), request)) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(data = result.data)
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
    }

    @GetMapping("/forfeit-requests")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun getRequests(
        @PathVariable leagueId: UUID,
        @RequestParam(required = false) status: ForfeitStatus?,
        @RequestParam(required = false) type: ForfeitType?,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<ForfeitRequestListResponse> {
        return when (val result = getForfeitRequestsQuery.execute(leagueId, status, type, PageRequest.of(page, size))) {
            is com.crichere.common.domain.Result.Success -> {
                val resultPage = result.data
                ResponseHelper.success(data = ForfeitRequestListResponse(
                    requests = resultPage.content,
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

    @PatchMapping("/forfeit-requests/{requestId}/approve")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun approveRequest(
        @PathVariable leagueId: UUID,
        @PathVariable requestId: UUID,
        @Valid @RequestBody request: ForfeitApproveRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<ForfeitRequestResponse> {
        return when (val result = approveForfeitRequestUseCase.execute(leagueId, requestId, request, UUID.fromString(user.username))) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(data = result.data)
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
    }

    @PatchMapping("/forfeit-requests/{requestId}/reject")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun rejectRequest(
        @PathVariable leagueId: UUID,
        @PathVariable requestId: UUID,
        @RequestBody request: Map<String, String>
    ): ApiResponse<ForfeitRequestResponse> {
        val notes = request["adminNotes"]
        if (notes == null) {
            return ResponseHelper.error(code = org.springframework.http.HttpStatus.BAD_REQUEST.name, message = "Admin notes are required", messageKey = "error.notes_required")
        }
        return when (val result = rejectForfeitRequestUseCase.execute(requestId, notes)) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(data = result.data)
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
    }

    @PatchMapping("/forfeit-requests/{requestId}/cancel")
    @PreAuthorize("isAuthenticated()")
    fun cancelRequest(
        @PathVariable leagueId: UUID,
        @PathVariable requestId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<ForfeitRequestResponse> {
        return when (val result = cancelForfeitRequestUseCase.execute(requestId, UUID.fromString(user.username))) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(data = result.data)
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
    }
}
