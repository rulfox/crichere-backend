package com.crichere.domain.league.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.league.dto.*
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.service.BulkImportService
import com.crichere.domain.league.service.LeagueService
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/leagues")
@Tag(name = "League Management")
class LeagueController(
    private val leagueService: LeagueService,
    private val bulkImportService: BulkImportService
) {

    @PostMapping
    fun createLeague(
        @AuthenticationPrincipal userDetails: UserDetails,
        @Valid @RequestBody request: LeagueCreateRequest
    ): ApiResponse<LeagueResponse> {
        val league = leagueService.createLeague(
            League(
                name = request.name,
                format = request.format,
                rulesUrl = request.rulesUrl,
                mustSellAll = request.mustSellAll,
                playerOrderMode = request.playerOrderMode,
                waitingListMode = request.waitingListMode,
                logoUrl = request.logoUrl,
                bannerUrl = request.bannerUrl,
                createdBy = UUID.fromString(userDetails.username)
            )
        )
        return ResponseHelper.success(data = toResponse(league), message = "League created successfully", messageKey = "success.league_created")
    }

    @GetMapping("/{id}")
    fun getLeague(@PathVariable id: UUID): ApiResponse<LeagueResponse> {
        return ResponseHelper.success(data = toResponse(leagueService.getLeague(id)))
    }

    @PatchMapping("/{id}/status")
    @PreAuthorize("hasRole('LEAGUE_ADMIN')")
    fun updateLeagueStatus(
        @PathVariable id: UUID,
        @RequestBody request: LeagueStatusUpdateRequest
    ): ApiResponse<LeagueResponse> {
        val league = leagueService.updateLeagueStatus(id, request.status)
        return ResponseHelper.success(data = toResponse(league), message = "League status updated successfully", messageKey = "success.league_status_updated")
    }

    @PostMapping("/{id}/players/bulk-import")
    @PreAuthorize("hasRole('LEAGUE_ADMIN')")
    fun bulkImportPlayers(
        @PathVariable id: UUID,
        @Valid @RequestBody request: List<@Valid PlayerImportRequest>
    ): ApiResponse<BulkImportResponse> {
        val result = bulkImportService.importPlayers(id, request)
        return ResponseHelper.success(data = result, message = "Bulk import completed", messageKey = "success.bulk_import_completed")
    }

    private fun toResponse(league: League) = LeagueResponse(
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
        createdBy = league.createdBy
    )
}
