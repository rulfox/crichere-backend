package com.crichere.domain.admin.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.PageResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.admin.service.PlatformAdminService
import com.crichere.domain.auth.dto.UserResponse
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.league.dto.LeagueResponse
import com.crichere.domain.league.enums.LeagueStatus
import com.crichere.domain.league.repository.AuctionRepository
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.data.domain.PageRequest
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
    private val adminService: PlatformAdminService,
    private val auctionRepository: AuctionRepository
) {

    @GetMapping("/users")
    fun getUsers(
        @RequestParam(required = false) profileStatus: ProfileStatus?,
        @RequestParam(required = false) search: String?,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<Any> {
        val result = adminService.getUsers(profileStatus, search, PageRequest.of(page, size))
        // Map to response... (simplified)
        return ResponseHelper.success(data = result)
    }

    @PatchMapping("/users/{id}/roles")
    fun updateRole(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, String>,
        @AuthenticationPrincipal admin: UserDetails
    ): ApiResponse<Any> {
        val action = request["action"] ?: throw com.crichere.common.exception.BusinessLogicException("Action is required", "error.action_required")
        val result = adminService.updateRole(id, action, UUID.fromString(admin.username))
        return ResponseHelper.success(data = result)
    }

    @PatchMapping("/leagues/{leagueId}/users/{userId}/roles")
    fun updateLeagueRole(
        @PathVariable leagueId: UUID,
        @PathVariable userId: UUID,
        @RequestBody request: Map<String, String>
    ): ApiResponse<Nothing> {
        val action = request["action"] ?: throw com.crichere.common.exception.BusinessLogicException("Action is required", "error.action_required")
        val roleStr = request["role"] ?: throw com.crichere.common.exception.BusinessLogicException("Role is required", "error.role_required")
        val role = com.crichere.domain.auth.enums.LeagueRole.valueOf(roleStr)
        adminService.updateLeagueRole(leagueId, userId, role, action)
        return ResponseHelper.success(message = "League role updated")
    }

    @PatchMapping("/users/{id}/suspend")
    fun suspendUser(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, Any>
    ): ApiResponse<Any> {
        val suspended = request["suspended"] as Boolean
        val reason = request["reason"] as? String
        val result = adminService.suspendUser(id, suspended, reason)
        return ResponseHelper.success(data = result)
    }

    @GetMapping("/leagues")
    fun getLeagues(
        @RequestParam(required = false) status: LeagueStatus?,
        @RequestParam(required = false) search: String?,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<PageResponse<LeagueResponse>> {
        val result = adminService.getLeagues(status, search, PageRequest.of(page, size))
        return ResponseHelper.success(data = PageResponse(
            content = result.content.map { league ->
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
            totalElements = result.totalElements,
            totalPages = result.totalPages,
            pageNumber = result.number,
            pageSize = result.size
        ))
    }

    @PatchMapping("/leagues/{id}/suspend")
    fun suspendLeague(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, Any>
    ): ApiResponse<Any> {
        val suspended = request["suspended"] as Boolean
        val reason = request["reason"] as? String
        val result = adminService.suspendLeague(id, suspended, reason)
        return ResponseHelper.success(data = result)
    }

    @GetMapping("/subscriptions")
    fun getSubscriptions(
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<Any> {
        val result = adminService.getSubscriptions(PageRequest.of(page, size))
        return ResponseHelper.success(data = result)
    }
}
