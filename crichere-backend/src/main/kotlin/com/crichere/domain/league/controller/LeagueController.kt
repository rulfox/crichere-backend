package com.crichere.domain.league.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.league.dto.*
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.service.LeagueService
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/leagues")
@Tag(name = "League Management")
class LeagueController(
    private val leagueService: LeagueService
) {

    @PostMapping
    fun createLeague(
        @AuthenticationPrincipal userDetails: UserDetails,
        @RequestBody request: LeagueCreateRequest
    ): ApiResponse<LeagueResponse> {
        val league = leagueService.createLeague(
            League(
                name = request.name,
                logoUrl = request.logoUrl,
                bannerUrl = request.bannerUrl,
                createdBy = UUID.fromString(userDetails.username)
            )
        )
        val response = LeagueResponse(
            id = league.id,
            name = league.name,
            logoUrl = league.logoUrl,
            bannerUrl = league.bannerUrl,
            status = league.status,
            createdBy = league.createdBy
        )
        return ResponseHelper.success(data = response, message = "League created successfully", messageKey = "success.league_created")
    }

    @GetMapping("/{id}")
    fun getLeague(@PathVariable id: UUID): ApiResponse<LeagueResponse> {
        val league = leagueService.getLeague(id)
        val response = LeagueResponse(
            id = league.id,
            name = league.name,
            logoUrl = league.logoUrl,
            bannerUrl = league.bannerUrl,
            status = league.status,
            createdBy = league.createdBy
        )
        return ResponseHelper.success(data = response)
    }

    @PatchMapping("/{id}/status")
    fun updateLeagueStatus(
        @PathVariable id: UUID,
        @RequestBody request: LeagueStatusUpdateRequest
    ): ApiResponse<LeagueResponse> {
        val league = leagueService.updateLeagueStatus(id, request.status)
        val response = LeagueResponse(
            id = league.id,
            name = league.name,
            logoUrl = league.logoUrl,
            bannerUrl = league.bannerUrl,
            status = league.status,
            createdBy = league.createdBy
        )
        return ResponseHelper.success(data = response, message = "League status updated successfully", messageKey = "success.league_status_updated")
    }
}
