package com.crichere.domain.waitinglist.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.waitinglist.dto.WaitingListEntryCreateRequest
import com.crichere.domain.waitinglist.dto.WaitingListEntryResponse
import com.crichere.domain.waitinglist.dto.WaitingListResponse
import com.crichere.domain.waitinglist.enums.WaitingListStatus
import com.crichere.domain.waitinglist.enums.WaitingListType
import com.crichere.domain.waitinglist.service.WaitingListService
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.data.domain.PageRequest
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/leagues/{leagueId}/waiting-list")
@Tag(name = "Waiting List Management")
class WaitingListController(private val waitingListService: WaitingListService) {

    @PostMapping
    fun addToWaitingList(
        @PathVariable leagueId: UUID,
        @RequestBody request: WaitingListEntryCreateRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<WaitingListEntryResponse> {
        return ResponseHelper.success(data = waitingListService.addToWaitingList(leagueId, UUID.fromString(user.username), request))
    }

    @GetMapping
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun getWaitingList(
        @PathVariable leagueId: UUID,
        @RequestParam(required = false) type: WaitingListType?,
        @RequestParam(required = false) status: WaitingListStatus?,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<WaitingListResponse> {
        val resultPage = waitingListService.getWaitingList(leagueId, type, status, PageRequest.of(page, size))
        return ResponseHelper.success(data = WaitingListResponse(
            entries = resultPage.content,
            totalElements = resultPage.totalElements,
            totalPages = resultPage.totalPages,
            pageNumber = resultPage.number,
            pageSize = resultPage.size
        ))
    }

    @GetMapping("/my-position")
    fun getMyPosition(
        @PathVariable leagueId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<WaitingListEntryResponse> {
        return ResponseHelper.success(data = waitingListService.getMyPosition(leagueId, UUID.fromString(user.username)))
    }

    @DeleteMapping("/{entryId}")
    fun withdraw(
        @PathVariable leagueId: UUID,
        @PathVariable entryId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Nothing> {
        waitingListService.withdraw(leagueId, entryId, UUID.fromString(user.username))
        return ResponseHelper.success(message = "Withdrawn from waiting list", messageKey = "success.withdrawn_from_waiting_list")
    }

    @PatchMapping("/{entryId}/promote")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun promoteEntry(
        @PathVariable leagueId: UUID,
        @PathVariable entryId: UUID
    ): ApiResponse<WaitingListEntryResponse> {
        return ResponseHelper.success(data = waitingListService.promoteEntry(leagueId, entryId, true))
    }
}
