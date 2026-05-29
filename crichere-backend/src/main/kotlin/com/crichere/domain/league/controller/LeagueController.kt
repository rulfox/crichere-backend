package com.crichere.domain.league.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.league.dto.*
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.repository.AuctionRepository
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
    private val bulkImportService: BulkImportService,
    private val auctionRepository: AuctionRepository
) {

    @PostMapping
    @ResponseStatus(org.springframework.http.HttpStatus.CREATED)
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
                auctionDate = request.auctionDate,
                createdBy = UUID.fromString(userDetails.username)
            )
        )
        return ResponseHelper.success(data = toResponse(league), message = "League created successfully", messageKey = "success.league_created")
    }

    @GetMapping
    fun getLeagues(
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<com.crichere.common.response.PageResponse<LeagueResponse>> {
        val resultPage = leagueService.getLeagues(org.springframework.data.domain.PageRequest.of(page, size))
        return ResponseHelper.success(data = com.crichere.common.response.PageResponse(
            content = resultPage.content.map { toResponse(it) },
            totalElements = resultPage.totalElements,
            totalPages = resultPage.totalPages,
            pageNumber = resultPage.number,
            pageSize = resultPage.size
        ))
    }

    @GetMapping("/{id}")
    fun getLeague(@PathVariable id: UUID): ApiResponse<LeagueResponse> {
        return ResponseHelper.success(data = toResponse(leagueService.getLeague(id)))
    }

    @PatchMapping("/{id}/status")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #id)")
    fun updateLeagueStatus(
        @PathVariable id: UUID,
        @RequestBody request: LeagueStatusUpdateRequest
    ): ApiResponse<LeagueResponse> {
        val league = leagueService.updateLeagueStatus(id, request.status)
        return ResponseHelper.success(data = toResponse(league), message = "League status updated successfully", messageKey = "success.league_status_updated")
    }

    @PostMapping("/{id}/players/bulk-import")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #id)")
    fun bulkImportPlayers(
        @PathVariable id: UUID,
        @Valid @RequestBody request: List<@Valid PlayerImportRequest>
    ): ApiResponse<BulkImportResponse> {
        val result = bulkImportService.importPlayers(id, request)
        return ResponseHelper.success(data = result, message = "Bulk import completed", messageKey = "success.bulk_import_completed")
    }

    @PostMapping("/{id}/category-prices")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #id)")
    fun updateCategoryPrices(
        @PathVariable id: UUID,
        @RequestBody request: List<CategoryPriceRequest>
    ): ApiResponse<List<CategoryPriceResponse>> {
        val prices = leagueService.updateCategoryPrices(id, request)
        return ResponseHelper.success(data = prices.map { CategoryPriceResponse(it.id, it.category, it.price) })
    }

    @GetMapping("/{id}/category-prices")
    fun getCategoryPrices(@PathVariable id: UUID): ApiResponse<List<CategoryPriceResponse>> {
        val prices = leagueService.getCategoryPrices(id)
        return ResponseHelper.success(data = prices.map { CategoryPriceResponse(it.id, it.category, it.price) })
    }

    @PostMapping("/{id}/tag-prices")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #id)")
    fun updateTagPrices(
        @PathVariable id: UUID,
        @RequestBody request: List<TagPriceRequest>
    ): ApiResponse<List<TagPriceResponse>> {
        val prices = leagueService.updateTagPrices(id, request)
        return ResponseHelper.success(data = prices.map { TagPriceResponse(it.id, it.tag, it.price) })
    }

    @GetMapping("/{id}/tag-prices")
    fun getTagPrices(@PathVariable id: UUID): ApiResponse<List<TagPriceResponse>> {
        val prices = leagueService.getTagPrices(id)
        return ResponseHelper.success(data = prices.map { TagPriceResponse(it.id, it.tag, it.price) })
    }

    @GetMapping("/{id}/auctions")
    fun getAuctions(@PathVariable id: UUID): ApiResponse<List<Map<String, Any?>>> {
        val auctions = auctionRepository.findAllByLeagueId(id)
        return ResponseHelper.success(data = auctions.map { a ->
            mapOf(
                "id" to a.id,
                "leagueId" to a.leagueId,
                "auctioneerId" to a.auctioneerId,
                "status" to a.status,
                "currentRoundId" to a.currentRoundId,
                "currentLeaguePlayerId" to a.currentLeaguePlayerId,
                "startedAt" to a.startedAt,
                "completedAt" to a.completedAt,
                "publicViewToken" to a.publicViewToken
            )
        })
    }

    @GetMapping("/{id}/franchises")
    fun getFranchises(@PathVariable id: UUID): ApiResponse<List<com.crichere.domain.franchise.dto.FranchiseResponse>> {
        val franchises = leagueService.getFranchises(id)
        return ResponseHelper.success(data = franchises.map { f ->
            com.crichere.domain.franchise.dto.FranchiseResponse(
                id = f.id,
                leagueId = f.leagueId,
                name = f.name,
                logoUrl = f.logoUrl,
                ownerId = f.ownerId,
                totalPurse = f.totalPurse,
                remainingPurse = f.remainingPurse
            )
        })
    }

    @GetMapping("/{id}/players")
    fun getPlayers(
        @PathVariable id: UUID,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<com.crichere.domain.player.dto.LeaguePlayerListResponse> {
        val resultPage = leagueService.getPlayers(id, org.springframework.data.domain.PageRequest.of(page, size))
        return ResponseHelper.success(data = com.crichere.domain.player.dto.LeaguePlayerListResponse(
            players = resultPage.content.map { player ->
                com.crichere.domain.player.dto.LeaguePlayerResponse(
                    id = player.id,
                    leagueId = player.leagueId,
                    userId = player.userId,
                    basePrice = leagueService.resolveBasePrice(player),
                    basePriceOverride = player.basePriceOverride,
                    tag = player.tag,
                    status = player.status,
                    category = player.category,
                    auctionEligible = player.auctionEligible
                )
            },
            totalElements = resultPage.totalElements,
            totalPages = resultPage.totalPages,
            pageNumber = resultPage.number,
            pageSize = resultPage.size
        ))
    }

    @PatchMapping("/{id}/players/{playerId}/eligible")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #id)")
    fun updatePlayerEligibility(
        @PathVariable id: UUID,
        @PathVariable playerId: UUID,
        @RequestBody request: Map<String, Boolean>
    ): ApiResponse<com.crichere.domain.player.dto.LeaguePlayerResponse> {
        val eligible = request["eligible"] ?: throw com.crichere.common.exception.BusinessLogicException("eligible field is required", "error.eligible_required")
        val player = leagueService.updatePlayerEligibility(id, playerId, eligible)
        return ResponseHelper.success(data = com.crichere.domain.player.dto.LeaguePlayerResponse(
            id = player.id,
            leagueId = player.leagueId,
            userId = player.userId,
            basePrice = leagueService.resolveBasePrice(player),
            basePriceOverride = player.basePriceOverride,
            tag = player.tag,
            status = player.status,
            category = player.category,
            auctionEligible = player.auctionEligible
        ))
    }

    @DeleteMapping("/{id}/players/{playerId}")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #id)")
    fun removePlayer(
        @PathVariable id: UUID,
        @PathVariable playerId: UUID
    ): ApiResponse<Nothing> {
        leagueService.removePlayer(id, playerId)
        return ResponseHelper.success(message = "Player removed from league", messageKey = "success.player_removed")
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
        auctionDate = league.auctionDate,
        createdBy = league.createdBy,
        auctionIds = auctionRepository.findAllByLeagueId(league.id).map { it.id }
    )
}
