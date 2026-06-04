package com.crichere.domain.waitinglist.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.waitinglist.dto.WaitingListEntryCreateRequest
import com.crichere.domain.waitinglist.dto.WaitingListEntryResponse
import com.crichere.domain.waitinglist.dto.WaitingListResponse
import com.crichere.domain.waitinglist.enums.WaitingListStatus
import com.crichere.domain.waitinglist.enums.WaitingListType
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.data.domain.PageRequest
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

import com.crichere.domain.waitinglist.usecase.*

@RestController
@RequestMapping("/leagues/{leagueId}/waiting-list")
@Tag(name = "Waiting List Management")
class WaitingListController(
    private val addToWaitingListUseCase: AddToWaitingListUseCase,
    private val withdrawFromWaitingListUseCase: WithdrawFromWaitingListUseCase,
    private val promoteEntryUseCase: PromoteEntryUseCase,
    private val getWaitingListQuery: GetWaitingListQuery,
    private val getMyPositionQuery: GetMyPositionQuery
) {

    @PostMapping
    fun addToWaitingList(
        @PathVariable leagueId: UUID,
        @RequestBody request: WaitingListEntryCreateRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<WaitingListEntryResponse> {
        return when (val result = addToWaitingListUseCase.execute(leagueId, UUID.fromString(user.username), request)) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(data = result.data)
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
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
        return when (val result = getWaitingListQuery.execute(leagueId, type, status, PageRequest.of(page, size))) {
            is com.crichere.common.domain.Result.Success -> {
                val resultPage = result.data
                ResponseHelper.success(data = WaitingListResponse(
                    entries = resultPage.content,
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

    @GetMapping("/my-position")
    fun getMyPosition(
        @PathVariable leagueId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<WaitingListEntryResponse> {
        return when (val result = getMyPositionQuery.execute(leagueId, UUID.fromString(user.username))) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(data = result.data)
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
    }

    @DeleteMapping("/{entryId}")
    fun withdraw(
        @PathVariable leagueId: UUID,
        @PathVariable entryId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Nothing> {
        return when (val result = withdrawFromWaitingListUseCase.execute(leagueId, entryId, UUID.fromString(user.username))) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(message = "Withdrawn from waiting list", messageKey = "success.withdrawn_from_waiting_list")
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
    }

    @PatchMapping("/{entryId}/promote")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun promoteEntry(
        @PathVariable leagueId: UUID,
        @PathVariable entryId: UUID
    ): ApiResponse<WaitingListEntryResponse> {
        return when (val result = promoteEntryUseCase.execute(leagueId, entryId, true)) {
            is com.crichere.common.domain.Result.Success -> ResponseHelper.success(data = result.data)
            is com.crichere.common.domain.Result.Failure -> ResponseHelper.error(
                code = result.error.httpStatus.name,
                message = result.error.message,
                messageKey = result.error.messageKey ?: "error.unknown"
            )
        }
    }
}
