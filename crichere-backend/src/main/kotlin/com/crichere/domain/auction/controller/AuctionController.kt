package com.crichere.domain.auction.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.auction.dto.*
import com.crichere.domain.auction.service.AuctionService
import com.crichere.domain.league.entity.Auction
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/auctions")
@Tag(name = "Auction Management")
class AuctionController(
    private val auctionService: AuctionService,
    private val exportService: com.crichere.domain.auction.service.ExportService,
    @org.springframework.beans.factory.annotation.Value("\${app.base-url:http://localhost:8080}")
    private val baseUrl: String
) {

    @PostMapping("/leagues/{leagueId}")
    @ResponseStatus(org.springframework.http.HttpStatus.CREATED)
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun createAuction(
        @PathVariable leagueId: UUID,
        @Valid @RequestBody request: AuctionCreateRequest
    ): ApiResponse<AuctionResponse> {
        val auction = auctionService.createAuction(leagueId, request.auctioneerId, request.rounds)
        return ResponseHelper.success(data = mapToResponse(auction))
    }

    @GetMapping("/{id}")
    fun getAuction(@PathVariable id: UUID): ApiResponse<AuctionResponse> {
        val auction = auctionService.getAuction(id)
        return ResponseHelper.success(data = mapToResponse(auction))
    }

    @GetMapping("/{id}/state")
    fun getAuctionState(@PathVariable id: UUID): ApiResponse<AuctionStateSnapshot> {
        return ResponseHelper.success(data = auctionService.getStateSnapshot(id))
    }

    @PatchMapping("/{id}/start")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun startAuction(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<AuctionResponse> {
        val auction = auctionService.startAuction(id, UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToResponse(auction))
    }

    @PatchMapping("/{id}/pause")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun pauseAuction(
        @PathVariable id: UUID,
        @RequestBody(required = false) request: Map<String, String>?,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<AuctionResponse> {
        val auction = auctionService.pauseAuction(id, request?.get("reason"), UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToResponse(auction))
    }

    @PatchMapping("/{id}/resume")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun resumeAuction(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<AuctionResponse> {
        val auction = auctionService.resumeAuction(id, UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToResponse(auction))
    }

    @PatchMapping("/{id}/complete")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun completeAuction(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<AuctionResponse> {
        val auction = auctionService.completeAuction(id, UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToResponse(auction))
    }

    @PatchMapping("/{id}/rounds/{roundId}/start")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun startRound(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Nothing> {
        auctionService.startRound(id, roundId, UUID.fromString(user.username))
        return ResponseHelper.success(message = "Round started")
    }

    @PostMapping("/{id}/player/put")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun putPlayer(
        @PathVariable id: UUID,
        @RequestBody(required = false) request: Map<String, UUID>?,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.putPlayer(id, request?.get("leaguePlayerId"), UUID.fromString(user.username))
        return ResponseHelper.success(data = auctionService.mapToStateResponse(state))
    }

    @PostMapping("/{id}/bid")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun placeBid(
        @PathVariable id: UUID,
        @Valid @RequestBody request: BidRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<BidResponse> {
        val bid = auctionService.placeBid(id, request.franchiseId, request.bidAmount, UUID.fromString(user.username))
        return ResponseHelper.success(data = BidResponse(
            bid.id, bid.auctionId, bid.roundId, bid.leaguePlayerId, bid.franchiseId, bid.bidAmount, bid.status, bid.recordedBy, bid.bidAt
        ))
    }

    @PatchMapping("/{id}/bid/undo")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun undoBid(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, String>,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.undoBid(id, request["reason"]!!, UUID.fromString(user.username))
        return ResponseHelper.success(data = auctionService.mapToStateResponse(state))
    }

    @PostMapping("/{id}/player/sold")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun sellPlayer(
        @PathVariable id: UUID,
        @Valid @RequestBody request: PlayerSoldRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.sellPlayer(id, request.leaguePlayerId, request.franchiseId, request.finalPrice, UUID.fromString(user.username))
        return ResponseHelper.success(data = auctionService.mapToStateResponse(state))
    }

    @PatchMapping("/{id}/player/undo-sold")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun undoSold(
        @PathVariable id: UUID,
        @Valid @RequestBody request: UndoSoldRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.undoSold(id, request.leaguePlayerId, request.reason, UUID.fromString(user.username))
        return ResponseHelper.success(data = auctionService.mapToStateResponse(state))
    }

    @PostMapping("/{id}/player/pre-assign")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN')")
    fun preAssign(
        @PathVariable id: UUID,
        @Valid @RequestBody request: PreAssignRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.preAssign(
            id, request.leaguePlayerId, request.franchiseId, 
            request.assignmentType, request.price, UUID.fromString(user.username)
        )
        return ResponseHelper.success(data = auctionService.mapToStateResponse(state))
    }

    @PostMapping("/{id}/player/unsold")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun unsoldPlayer(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, UUID>,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.unsoldPlayer(id, request["leaguePlayerId"]!!, UUID.fromString(user.username))
        return ResponseHelper.success(data = auctionService.mapToStateResponse(state))
    }

    @PostMapping("/{id}/player/force-assign")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN')")
    fun forceAssign(
        @PathVariable id: UUID,
        @Valid @RequestBody request: ForceAssignRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.forceAssign(id, request.leaguePlayerId, request.franchiseId, request.price, UUID.fromString(user.username))
        return ResponseHelper.success(data = auctionService.mapToStateResponse(state))
    }

    @PostMapping("/{id}/timer/start")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun startTimer(
        @PathVariable id: UUID,
        @RequestBody(required = false) request: TimerStartRequest?,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<TimerStateResponse> {
        val state = auctionService.startTimer(id, request?.durationSeconds, UUID.fromString(user.username))
        return ResponseHelper.success(data = state)
    }

    @PostMapping("/{id}/timer/stop")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun stopTimer(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Nothing> {
        auctionService.stopTimer(id, UUID.fromString(user.username))
        return ResponseHelper.success(message = "Timer stopped")
    }

    @GetMapping("/{id}/timer/state")
    fun getTimerState(@PathVariable id: UUID): ApiResponse<TimerStateResponse> {
        return ResponseHelper.success(data = auctionService.getTimerState(id))
    }

    @PostMapping("/{id}/rounds/{roundId}/category-increments")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN')")
    fun updateCategoryIncrements(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @RequestBody request: List<CategoryIncrementRequest>
    ): ApiResponse<List<CategoryIncrementResponse>> {
        val increments = auctionService.updateCategoryIncrements(roundId, request)
        return ResponseHelper.success(data = increments.map { 
            CategoryIncrementResponse(it.id, it.roundId, it.category, it.tag, it.bidIncrement)
        })
    }

    @GetMapping("/{id}/rounds/{roundId}/category-increments")
    fun getCategoryIncrements(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID
    ): ApiResponse<List<CategoryIncrementResponse>> {
        val increments = auctionService.getCategoryIncrements(roundId)
        return ResponseHelper.success(data = increments.map { 
            CategoryIncrementResponse(it.id, it.roundId, it.category, it.tag, it.bidIncrement)
        })
    }

    @GetMapping("/{id}/audit-log")
    fun getAuditLog(
        @PathVariable id: UUID,
        @RequestParam(required = false) fromSequence: Long?
    ): ApiResponse<List<AuditLogResponse>> {
        val logs = auctionService.getAuditLogs(id, fromSequence)
        return ResponseHelper.success(data = logs.map { log ->
            AuditLogResponse(log.id, log.auctionId, log.sequenceNumber, log.action, log.payload, log.actorId, log.createdAt)
        })
    }

    @PostMapping("/{id}/rounds")
    @ResponseStatus(org.springframework.http.HttpStatus.CREATED)
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN')")
    fun addRound(
        @PathVariable id: UUID,
        @Valid @RequestBody request: RoundConfigDto
    ): ApiResponse<Nothing> {
        auctionService.addRound(id, request)
        return ResponseHelper.success(message = "Round added")
    }

    @GetMapping("/{id}/rounds")
    fun getRounds(@PathVariable id: UUID): ApiResponse<List<RoundConfigDto>> {
        val rounds = auctionService.getRounds(id)
        return ResponseHelper.success(data = rounds.map { r ->
            RoundConfigDto(
                roundNumber = r.roundNumber,
                name = r.name,
                currencyType = r.currencyType,
                purseAmount = r.purseAmount,
                purseSource = r.purseSource,
                bidMode = r.bidMode,
                playerPoolSource = r.playerPoolSource,
                franchiseEligibilityRule = r.franchiseEligibilityRule,
                completionTrigger = r.completionTrigger,
                countdownSeconds = r.countdownSeconds,
                antiSnipeSeconds = r.antiSnipeSeconds,
                bidIncrementSlabs = emptyList() // Slabs should be fetched separately or included
            )
        })
    }

    @GetMapping("/{id}/rounds/{roundId}")
    fun getRound(@PathVariable id: UUID, @PathVariable roundId: UUID): ApiResponse<RoundConfigDto> {
        val r = auctionService.getRound(roundId)
        return ResponseHelper.success(data = RoundConfigDto(
            roundNumber = r.roundNumber,
            name = r.name,
            currencyType = r.currencyType,
            purseAmount = r.purseAmount,
            purseSource = r.purseSource,
            bidMode = r.bidMode,
            playerPoolSource = r.playerPoolSource,
            franchiseEligibilityRule = r.franchiseEligibilityRule,
            completionTrigger = r.completionTrigger,
            countdownSeconds = r.countdownSeconds,
            antiSnipeSeconds = r.antiSnipeSeconds,
            bidIncrementSlabs = emptyList()
        ))
    }

    @PutMapping("/{id}/rounds/{roundId}")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN')")
    fun updateRound(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @Valid @RequestBody request: RoundConfigDto
    ): ApiResponse<Nothing> {
        auctionService.updateRound(roundId, request)
        return ResponseHelper.success(message = "Round updated")
    }

    @DeleteMapping("/{id}/rounds/{roundId}")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN')")
    fun deleteRound(@PathVariable id: UUID, @PathVariable roundId: UUID): ApiResponse<Nothing> {
        auctionService.deleteRound(roundId)
        return ResponseHelper.success(message = "Round deleted")
    }

    @PatchMapping("/{id}/rounds/{roundId}/complete")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun completeRound(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Nothing> {
        auctionService.completeRound(id, roundId, UUID.fromString(user.username))
        return ResponseHelper.success(message = "Round completed")
    }

    @GetMapping("/{id}/rounds/{roundId}/player-pool")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun getPlayerPool(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID
    ): ApiResponse<List<PlayerAuctionStateResponse>> {
        val pool = auctionService.getPlayerPool(id, roundId)
        return ResponseHelper.success(data = pool.map { auctionService.mapToStateResponse(it) })
    }

    @PatchMapping("/{id}/rounds/{roundId}/player-pool")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun updatePlayerPool(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @RequestBody request: Map<String, List<UUID>>
    ): ApiResponse<Nothing> {
        val playerIds = request["playerIds"] ?: throw com.crichere.common.exception.BusinessLogicException("playerIds field is required", "error.player_ids_required")
        auctionService.updatePlayerPool(roundId, playerIds)
        return ResponseHelper.success(message = "Player pool updated")
    }

    @PostMapping("/{id}/player/withdraw")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun withdrawPlayer(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, Any>,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.withdrawPlayer(
            id, 
            UUID.fromString(request["leaguePlayerId"].toString()), 
            request["reason"].toString(), 
            UUID.fromString(user.username)
        )
        return ResponseHelper.success(data = auctionService.mapToStateResponse(state))
    }

    @GetMapping("/{id}/bids/{leaguePlayerId}")
    fun getBidHistory(
        @PathVariable id: UUID,
        @PathVariable leaguePlayerId: UUID
    ): ApiResponse<List<BidResponse>> {
        val history = auctionService.getBidHistory(id, leaguePlayerId)
        return ResponseHelper.success(data = history.map { b -> 
            BidResponse(b.id, b.auctionId, b.roundId, b.leaguePlayerId, b.franchiseId, b.bidAmount, b.status, b.recordedBy, b.bidAt)
        })
    }

    @GetMapping("/{id}/summary")
    fun getAuctionSummary(@PathVariable id: UUID): ApiResponse<AuctionSummaryResponse> {
        return ResponseHelper.success(data = auctionService.getDetailedAuctionSummary(id))
    }

    @GetMapping("/{id}/summary/franchises/{franchiseId}")
    fun getFranchiseSummary(
        @PathVariable id: UUID,
        @PathVariable franchiseId: UUID
    ): ApiResponse<FranchiseDetailedSummaryResponse> {
        return ResponseHelper.success(data = auctionService.getFranchiseDetailedSummary(id, franchiseId))
    }

    @GetMapping("/{id}/summary/unsold")
    fun getUnsoldPlayers(
        @PathVariable id: UUID,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<UnsoldPlayersResponse> {
        return ResponseHelper.success(data = auctionService.getUnsoldPlayers(id, org.springframework.data.domain.PageRequest.of(page, size)))
    }

    @GetMapping("/{id}/summary/export/pdf", produces = ["application/pdf"])
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('AUCTIONEER')")
    fun exportSummaryPdf(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ByteArray> {
        val pdf = exportService.exportAuctionSummaryPdf(id)
        return org.springframework.http.ResponseEntity.ok()
            .header(org.springframework.http.HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"auction-summary.pdf\"")
            .contentType(org.springframework.http.MediaType.APPLICATION_PDF)
            .body(pdf)
    }

    @GetMapping("/{id}/summary/franchises/{franchiseId}/export/pdf", produces = ["application/pdf"])
    fun exportFranchisePdf(
        @PathVariable id: UUID,
        @PathVariable franchiseId: UUID
    ): org.springframework.http.ResponseEntity<ByteArray> {
        // Dummy implementation for now, using the same export logic or similar
        val pdf = exportService.exportAuctionSummaryPdf(id) 
        return org.springframework.http.ResponseEntity.ok()
            .header(org.springframework.http.HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"franchise-squad.pdf\"")
            .contentType(org.springframework.http.MediaType.APPLICATION_PDF)
            .body(pdf)
    }

    @GetMapping("/{id}/summary/franchises/{franchiseId}/export/image", produces = ["image/png"])
    fun exportFranchiseImage(
        @PathVariable id: UUID,
        @PathVariable franchiseId: UUID
    ): org.springframework.http.ResponseEntity<ByteArray> {
        val image = exportService.exportFranchiseSquadImage(id, franchiseId)
        return org.springframework.http.ResponseEntity.ok()
            .header(org.springframework.http.HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"franchise-squad.png\"")
            .contentType(org.springframework.http.MediaType.IMAGE_PNG)
            .body(image)
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN')")
    fun deleteAuction(@PathVariable id: UUID): ApiResponse<Nothing> {
        auctionService.deleteAuction(id)
        return ResponseHelper.success(message = "Auction deleted")
    }

    @PostMapping("/{id}/regenerate-view-token")
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN')")
    fun regenerateViewToken(@PathVariable id: UUID): ApiResponse<AuctionResponse> {
        val auction = auctionService.regeneratePublicViewToken(id)
        return ResponseHelper.success(data = mapToResponse(auction))
    }

    private fun mapToResponse(auction: Auction) = AuctionResponse(
        auction.id, 
        auction.leagueId, 
        auction.auctioneerId, 
        auction.status, 
        auction.currentRoundId, 
        auction.currentLeaguePlayerId, 
        auction.startedAt, 
        auction.completedAt,
        "$baseUrl/api/v1/public/auctions/${auction.id}/display",
        "$baseUrl/api/v1/public/auctions/view/${auction.publicViewToken}",
        auction.publicViewToken
    )
}
