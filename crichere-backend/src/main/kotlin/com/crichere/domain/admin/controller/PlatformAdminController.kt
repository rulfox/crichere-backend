package com.crichere.domain.admin.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.PageResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.admin.usecase.*
import com.crichere.domain.auth.dto.UserResponse
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.league.dto.LeagueResponse
import com.crichere.domain.league.enums.LeagueStatus
import com.crichere.domain.league.repository.AuctionRepository
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.data.domain.PageRequest
import org.springframework.http.HttpStatus
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/admin")
@Tag(name = "Platform Admin")
@PreAuthorize("hasRole('PLATFORM_ADMIN')")
class PlatformAdminController(
    private val adminQueryUseCases: AdminQueryUseCases,
    private val updateRoleUseCase: UpdateRoleUseCase,
    private val updateLeagueRoleUseCase: UpdateLeagueRoleUseCase,
    private val suspendUserUseCase: SuspendUserUseCase,
    private val suspendLeagueUseCase: SuspendLeagueUseCase,
    private val auctionRepository: AuctionRepository
) {

    @GetMapping("/users")
    fun getUsers(
        @RequestParam(required = false) profileStatus: ProfileStatus?,
        @RequestParam(required = false) search: String?,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<Any> {
        val result = adminQueryUseCases.getUsers(profileStatus, search, PageRequest.of(page, size))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(data = result.data)
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @PatchMapping("/users/{id}/roles")
    fun updateRole(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, String>,
        @AuthenticationPrincipal admin: UserDetails
    ): ApiResponse<Any> {
        val action = request["action"] ?: return ResponseHelper.error(HttpStatus.BAD_REQUEST.name, "Action is required", "error.action_required")
        val result = updateRoleUseCase.execute(id, action, UUID.fromString(admin.username))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(data = result.data)
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @PatchMapping("/leagues/{leagueId}/users/{userId}/roles")
    fun updateLeagueRole(
        @PathVariable leagueId: UUID,
        @PathVariable userId: UUID,
        @RequestBody request: Map<String, String>
    ): ApiResponse<Nothing> {
        val action = request["action"] ?: return ResponseHelper.error(HttpStatus.BAD_REQUEST.name, "Action is required", "error.action_required")
        val roleStr = request["role"] ?: return ResponseHelper.error(HttpStatus.BAD_REQUEST.name, "Role is required", "error.role_required")
        val role = com.crichere.domain.auth.enums.LeagueRole.valueOf(roleStr)
        val result = updateLeagueRoleUseCase.execute(leagueId, userId, role, action)
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(message = "League role updated")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @PatchMapping("/users/{id}/suspend")
    fun suspendUser(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, Any>
    ): ApiResponse<Any> {
        val suspended = request["suspended"] as? Boolean ?: false
        val reason = request["reason"] as? String
        val result = suspendUserUseCase.execute(id, suspended, reason)
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(data = result.data)
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @GetMapping("/leagues")
    fun getLeagues(
        @RequestParam(required = false) status: LeagueStatus?,
        @RequestParam(required = false) search: String?,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<PageResponse<LeagueResponse>> {
        val result = adminQueryUseCases.getLeagues(status, search, PageRequest.of(page, size))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(data = PageResponse(
                content = result.data.content.map { league ->
                    LeagueResponse(
                        id = league.id,
                        name = league.name,
                        format = league.format,
                        rulesUrl = league.rulesUrl,
                        mustSellAll = league.mustSellAll,
                        playerOrderMode = league.playerOrderMode,
                        waitingListMode = league.waitingListMode,
                        logoUrl = league.logoUrl,
                        bannerUrl = league.bannerUrl,
                        status = league.status,
                        auctionDate = league.auctionDate,
                        createdBy = league.createdBy,
                        auctionIds = auctionRepository.findAllByLeagueId(league.id).map { it.id }
                    )
                },
                totalElements = result.data.totalElements,
                totalPages = result.data.totalPages,
                pageNumber = result.data.number,
                pageSize = result.data.size
            ))
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @PatchMapping("/leagues/{id}/suspend")
    fun suspendLeague(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, Any>
    ): ApiResponse<Any> {
        val suspended = request["suspended"] as? Boolean ?: false
        val reason = request["reason"] as? String
        val result = suspendLeagueUseCase.execute(id, suspended, reason)
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(data = result.data)
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @GetMapping("/subscriptions")
    fun getSubscriptions(
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<Any> {
        val result = adminQueryUseCases.getSubscriptions(PageRequest.of(page, size))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(data = result.data)
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }
}
