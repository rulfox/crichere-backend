package com.crichere.domain.forfeit.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.forfeit.dto.*
import com.crichere.domain.forfeit.enums.ForfeitStatus
import com.crichere.domain.forfeit.enums.ForfeitType
import com.crichere.domain.forfeit.service.ForfeitService
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
@Tag(name = "Forfeit Management")
class ForfeitController(private val forfeitService: ForfeitService) {

    @PostMapping("/forfeit")
    @PreAuthorize("isAuthenticated()")
    fun createRequest(
        @PathVariable leagueId: UUID,
        @Valid @RequestBody request: ForfeitRequestCreateRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<ForfeitRequestResponse> {
        // Membership check should be done in service or via a custom security expression
        return ResponseHelper.success(data = forfeitService.createRequest(leagueId, UUID.fromString(user.username), request))
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
        val resultPage = forfeitService.getRequests(leagueId, status, type, PageRequest.of(page, size))
        return ResponseHelper.success(data = ForfeitRequestListResponse(
            requests = resultPage.content,
            totalElements = resultPage.totalElements,
            totalPages = resultPage.totalPages,
            pageNumber = resultPage.number,
            pageSize = resultPage.size
        ))
    }

    @PatchMapping("/forfeit-requests/{requestId}/approve")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun approveRequest(
        @PathVariable leagueId: UUID,
        @PathVariable requestId: UUID,
        @Valid @RequestBody request: ForfeitApproveRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<ForfeitRequestResponse> {
        return ResponseHelper.success(data = forfeitService.approveRequest(leagueId, requestId, request, UUID.fromString(user.username)))
    }

    @PatchMapping("/forfeit-requests/{requestId}/reject")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun rejectRequest(
        @PathVariable leagueId: UUID,
        @PathVariable requestId: UUID,
        @RequestBody request: Map<String, String>
    ): ApiResponse<ForfeitRequestResponse> {
        val notes = request["adminNotes"] ?: throw com.crichere.common.exception.BusinessLogicException("Admin notes are required", "error.notes_required")
        return ResponseHelper.success(data = forfeitService.rejectRequest(requestId, notes))
    }

    @PatchMapping("/forfeit-requests/{requestId}/cancel")
    @PreAuthorize("isAuthenticated()")
    fun cancelRequest(
        @PathVariable leagueId: UUID,
        @PathVariable requestId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<ForfeitRequestResponse> {
        // Ownership check is done in service
        return ResponseHelper.success(data = forfeitService.cancelRequest(requestId, UUID.fromString(user.username)))
    }
}
