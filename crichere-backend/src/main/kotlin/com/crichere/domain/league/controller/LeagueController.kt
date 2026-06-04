package com.crichere.domain.league.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.toResponseEntity
import com.crichere.domain.league.dto.*
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.repository.AuctionRepository
import com.crichere.domain.league.service.BulkImportService
import com.crichere.domain.league.usecase.*
import com.crichere.domain.league.mapper.toResponse
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/leagues")
@Tag(name = "League Management")
class LeagueController(
    private val bulkImportService: BulkImportService,
    private val auctionRepository: AuctionRepository,
    private val createLeagueUseCase: CreateLeagueUseCase,
    private val getLeagueQuery: GetLeagueQuery,
    private val getLeaguesQuery: GetLeaguesQuery,
    private val updateLeagueStatusUseCase: UpdateLeagueStatusUseCase,
    private val updateCategoryPricesUseCase: UpdateCategoryPricesUseCase,
    private val getCategoryPricesQuery: GetCategoryPricesQuery,
    private val updateTagPricesUseCase: UpdateTagPricesUseCase,
    private val getTagPricesQuery: GetTagPricesQuery,
    private val getLeagueFranchisesQuery: GetLeagueFranchisesQuery,
    private val getLeaguePlayersQuery: GetLeaguePlayersQuery,
    private val updatePlayerEligibilityUseCase: UpdatePlayerEligibilityUseCase,
    private val removePlayerUseCase: RemovePlayerUseCase,
    private val resolveBasePriceQuery: ResolveBasePriceQuery
) {

    @PostMapping
    fun createLeague(
        @AuthenticationPrincipal userDetails: UserDetails,
        @Valid @RequestBody request: LeagueCreateRequest
    ): ResponseEntity<ApiResponse<LeagueResponse>> {
        val leagueToCreate = League(
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
        
        return createLeagueUseCase.execute(leagueToCreate)
            .map { it.toResponse(auctionRepository.findAllByLeagueId(it.id).map { a -> a.id }) }
            .toResponseEntity("League created successfully", "success.league_created", HttpStatus.CREATED)
    }

    @GetMapping
    fun getLeagues(
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ResponseEntity<ApiResponse<com.crichere.common.response.PageResponse<LeagueResponse>>> {
        return getLeaguesQuery.execute(org.springframework.data.domain.PageRequest.of(page, size))
            .map { resultPage ->
                com.crichere.common.response.PageResponse(
                    content = resultPage.content.map { it.toResponse(auctionRepository.findAllByLeagueId(it.id).map { a -> a.id }) },
                    totalElements = resultPage.totalElements,
                    totalPages = resultPage.totalPages,
                    pageNumber = resultPage.number,
                    pageSize = resultPage.size
                )
            }
            .toResponseEntity()
    }

    @GetMapping("/{id}")
    fun getLeague(@PathVariable id: UUID): ResponseEntity<ApiResponse<LeagueResponse>> {
        return getLeagueQuery.execute(id)
            .map { it.toResponse(auctionRepository.findAllByLeagueId(it.id).map { a -> a.id }) }
            .toResponseEntity()
    }

    @PatchMapping("/{id}/status")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #id)")
    fun updateLeagueStatus(
        @PathVariable id: UUID,
        @RequestBody request: LeagueStatusUpdateRequest
    ): ResponseEntity<ApiResponse<LeagueResponse>> {
        return updateLeagueStatusUseCase.execute(id, request.status)
            .map { it.toResponse(auctionRepository.findAllByLeagueId(it.id).map { a -> a.id }) }
            .toResponseEntity("League status updated successfully", "success.league_status_updated")
    }

    @PostMapping("/{id}/players/bulk-import")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #id)")
    fun bulkImportPlayers(
        @PathVariable id: UUID,
        @Valid @RequestBody request: List<@Valid PlayerImportRequest>
    ): ResponseEntity<ApiResponse<BulkImportResponse>> {
        // BulkImportService isn't fully refactored to CQRS yet, we keep it as is for now
        val result = bulkImportService.importPlayers(id, request)
        return ResponseEntity.ok(
            com.crichere.common.response.ResponseHelper.success(
                data = result, 
                message = "Bulk import completed", 
                messageKey = "success.bulk_import_completed"
            )
        )
    }

    @PostMapping("/{id}/category-prices")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #id)")
    fun updateCategoryPrices(
        @PathVariable id: UUID,
        @RequestBody request: List<CategoryPriceRequest>
    ): ResponseEntity<ApiResponse<List<CategoryPriceResponse>>> {
        return updateCategoryPricesUseCase.execute(id, request)
            .map { prices -> prices.map { CategoryPriceResponse(it.id, it.category, it.price) } }
            .toResponseEntity()
    }

    @GetMapping("/{id}/category-prices")
    fun getCategoryPrices(@PathVariable id: UUID): ResponseEntity<ApiResponse<List<CategoryPriceResponse>>> {
        return getCategoryPricesQuery.execute(id)
            .map { prices -> prices.map { CategoryPriceResponse(it.id, it.category, it.price) } }
            .toResponseEntity()
    }

    @PostMapping("/{id}/tag-prices")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #id)")
    fun updateTagPrices(
        @PathVariable id: UUID,
        @RequestBody request: List<TagPriceRequest>
    ): ResponseEntity<ApiResponse<List<TagPriceResponse>>> {
        return updateTagPricesUseCase.execute(id, request)
            .map { prices -> prices.map { TagPriceResponse(it.id, it.tag, it.price) } }
            .toResponseEntity()
    }

    @GetMapping("/{id}/tag-prices")
    fun getTagPrices(@PathVariable id: UUID): ResponseEntity<ApiResponse<List<TagPriceResponse>>> {
        return getTagPricesQuery.execute(id)
            .map { prices -> prices.map { TagPriceResponse(it.id, it.tag, it.price) } }
            .toResponseEntity()
    }

    @GetMapping("/{id}/auctions")
    fun getAuctions(@PathVariable id: UUID): ResponseEntity<ApiResponse<List<Map<String, Any?>>>> {
        val auctions = auctionRepository.findAllByLeagueId(id)
        val data = auctions.map { a ->
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
        }
        return ResponseEntity.ok(com.crichere.common.response.ResponseHelper.success(data = data))
    }

    @GetMapping("/{id}/franchises")
    fun getFranchises(@PathVariable id: UUID): ResponseEntity<ApiResponse<List<com.crichere.domain.franchise.dto.FranchiseResponse>>> {
        return getLeagueFranchisesQuery.execute(id)
            .map { franchises -> 
                franchises.map { f ->
                    com.crichere.domain.franchise.dto.FranchiseResponse(
                        id = f.id,
                        leagueId = f.leagueId,
                        name = f.name,
                        logoUrl = f.logoUrl,
                        ownerId = f.ownerId,
                        totalPurse = f.totalPurse,
                        remainingPurse = f.remainingPurse
                    )
                }
            }
            .toResponseEntity()
    }

    @GetMapping("/{id}/players")
    fun getPlayers(
        @PathVariable id: UUID,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ResponseEntity<ApiResponse<com.crichere.domain.player.dto.LeaguePlayerListResponse>> {
        return getLeaguePlayersQuery.execute(id, org.springframework.data.domain.PageRequest.of(page, size))
            .map { resultPage ->
                com.crichere.domain.player.dto.LeaguePlayerListResponse(
                    players = resultPage.content.map { player ->
                        com.crichere.domain.player.dto.LeaguePlayerResponse(
                            id = player.id,
                            leagueId = player.leagueId,
                            userId = player.userId,
                            basePrice = resolveBasePriceQuery.execute(player),
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
                )
            }
            .toResponseEntity()
    }

    @PatchMapping("/{id}/players/{playerId}/eligible")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #id)")
    fun updatePlayerEligibility(
        @PathVariable id: UUID,
        @PathVariable playerId: UUID,
        @RequestBody request: Map<String, Boolean>
    ): ResponseEntity<ApiResponse<com.crichere.domain.player.dto.LeaguePlayerResponse>> {
        val eligible = request["eligible"] ?: return ResponseEntity.badRequest().body(
            ApiResponse(success = false, error = com.crichere.common.response.ApiError("error.eligible_required", listOf("eligible field is required")))
        )
        
        return updatePlayerEligibilityUseCase.execute(id, playerId, eligible)
            .map { player ->
                com.crichere.domain.player.dto.LeaguePlayerResponse(
                    id = player.id,
                    leagueId = player.leagueId,
                    userId = player.userId,
                    basePrice = resolveBasePriceQuery.execute(player),
                    basePriceOverride = player.basePriceOverride,
                    tag = player.tag,
                    status = player.status,
                    category = player.category,
                    auctionEligible = player.auctionEligible
                )
            }
            .toResponseEntity()
    }

    @DeleteMapping("/{id}/players/{playerId}")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #id)")
    fun removePlayer(
        @PathVariable id: UUID,
        @PathVariable playerId: UUID
    ): ResponseEntity<ApiResponse<Unit>> {
        return removePlayerUseCase.execute(id, playerId)
            .toResponseEntity("Player removed from league", "success.player_removed")
    }
}
