package com.crichere.domain.auction.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.auction.dto.*
import com.crichere.domain.auction.service.AuctionService
import com.crichere.domain.league.entity.Auction
import io.swagger.v3.oas.annotations.tags.Tag
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
    private val exportService: com.crichere.domain.auction.service.ExportService
) {

    @PostMapping("/leagues/{leagueId}")
    @PreAuthorize("hasRole('LEAGUE_ADMIN')")
    fun createAuction(
        @PathVariable leagueId: UUID,
        @RequestBody request: AuctionCreateRequest
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
    fun startAuction(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<AuctionResponse> {
        val auction = auctionService.startAuction(id, UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToResponse(auction))
    }

    @PatchMapping("/{id}/pause")
    fun pauseAuction(
        @PathVariable id: UUID,
        @RequestBody(required = false) request: Map<String, String>?,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<AuctionResponse> {
        val auction = auctionService.pauseAuction(id, request?.get("reason"), UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToResponse(auction))
    }

    @PatchMapping("/{id}/resume")
    fun resumeAuction(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<AuctionResponse> {
        val auction = auctionService.resumeAuction(id, UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToResponse(auction))
    }

    @PatchMapping("/{id}/complete")
    fun completeAuction(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<AuctionResponse> {
        val auction = auctionService.completeAuction(id, UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToResponse(auction))
    }

    @PatchMapping("/{id}/rounds/{roundId}/start")
    fun startRound(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Nothing> {
        auctionService.startRound(id, roundId, UUID.fromString(user.username))
        return ResponseHelper.success(message = "Round started")
    }

    @PostMapping("/{id}/player/put")
    fun putPlayer(
        @PathVariable id: UUID,
        @RequestBody(required = false) request: Map<String, UUID>?,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.putPlayer(id, request?.get("leaguePlayerId"), UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToStateResponse(state))
    }

    @PostMapping("/{id}/bid")
    fun placeBid(
        @PathVariable id: UUID,
        @RequestBody request: BidRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<BidResponse> {
        val bid = auctionService.placeBid(id, request.franchiseId, request.bidAmount, UUID.fromString(user.username))
        return ResponseHelper.success(data = BidResponse(
            bid.id, bid.auctionId, bid.roundId, bid.leaguePlayerId, bid.franchiseId, bid.bidAmount, bid.status, bid.recordedBy, bid.bidAt
        ))
    }

    @PatchMapping("/{id}/bid/undo")
    fun undoBid(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, String>,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.undoBid(id, request["reason"]!!, UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToStateResponse(state))
    }

    @PostMapping("/{id}/player/sold")
    fun sellPlayer(
        @PathVariable id: UUID,
        @RequestBody request: PlayerSoldRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.sellPlayer(id, request.leaguePlayerId, request.franchiseId, request.finalPrice, UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToStateResponse(state))
    }

    @PatchMapping("/{id}/player/undo-sold")
    fun undoSold(
        @PathVariable id: UUID,
        @RequestBody request: UndoSoldRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.undoSold(id, request.leaguePlayerId, request.reason, UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToStateResponse(state))
    }

    @PostMapping("/{id}/player/unsold")
    fun unsoldPlayer(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, UUID>,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.unsoldPlayer(id, request["leaguePlayerId"]!!, UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToStateResponse(state))
    }

    @PostMapping("/{id}/player/force-assign")
    @PreAuthorize("hasRole('LEAGUE_ADMIN')")
    fun forceAssign(
        @PathVariable id: UUID,
        @RequestBody request: ForceAssignRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<PlayerAuctionStateResponse> {
        val state = auctionService.forceAssign(id, request.leaguePlayerId, request.franchiseId, request.price, UUID.fromString(user.username))
        return ResponseHelper.success(data = mapToStateResponse(state))
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
    @PreAuthorize("hasRole('LEAGUE_ADMIN')")
    fun addRound(
        @PathVariable id: UUID,
        @RequestBody request: RoundConfigDto
    ): ApiResponse<Nothing> {
        auctionService.addRound(id, request)
        return ResponseHelper.success(message = "Round added")
    }

    @PutMapping("/{id}/rounds/{roundId}")
    @PreAuthorize("hasRole('LEAGUE_ADMIN')")
    fun updateRound(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @RequestBody request: RoundConfigDto
    ): ApiResponse<Nothing> {
        auctionService.updateRound(roundId, request)
        return ResponseHelper.success(message = "Round updated")
    }

    @PatchMapping("/{id}/rounds/{roundId}/complete")
    fun completeRound(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Nothing> {
        auctionService.completeRound(id, roundId, UUID.fromString(user.username))
        return ResponseHelper.success(message = "Round completed")
    }

    @GetMapping("/{id}/rounds/{roundId}/player-pool")
    @PreAuthorize("hasRole('AUCTIONEER')")
    fun getPlayerPool(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID
    ): ApiResponse<List<PlayerAuctionStateResponse>> {
        val pool = auctionService.getPlayerPool(id, roundId)
        return ResponseHelper.success(data = pool.map { mapToStateResponse(it) })
    }

    @PostMapping("/{id}/player/withdraw")
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
        return ResponseHelper.success(data = mapToStateResponse(state))
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
    @PreAuthorize("hasAnyRole('LEAGUE_ADMIN', 'AUCTIONEER')")
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
    @PreAuthorize("hasRole('LEAGUE_ADMIN')")
    fun deleteAuction(@PathVariable id: UUID): ApiResponse<Nothing> {
        auctionService.deleteAuction(id)
        return ResponseHelper.success(message = "Auction deleted")
    }

    private fun mapToResponse(auction: Auction) = AuctionResponse(
        auction.id, auction.leagueId, auction.auctioneerId, auction.status, auction.currentRoundId, auction.currentLeaguePlayerId, auction.startedAt, auction.completedAt
    )

    private fun mapToStateResponse(s: com.crichere.domain.auction.entity.PlayerAuctionState) = PlayerAuctionStateResponse(
        s.id, s.auctionId, s.leaguePlayerId, s.state, s.currentHighestBid, s.currentHighestBidderId, s.finalPrice, s.soldToFranchiseId
    )
}
