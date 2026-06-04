package com.crichere.domain.auction.controller

import com.crichere.common.domain.Result
import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.common.response.getOrNull
import com.crichere.common.response.toResponseEntity
import com.crichere.domain.auction.dto.*
import com.crichere.domain.auction.usecase.*
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
    private val createAuctionUseCase: CreateAuctionUseCase,
    private val startAuctionUseCase: StartAuctionUseCase,
    private val pauseAuctionUseCase: PauseAuctionUseCase,
    private val resumeAuctionUseCase: ResumeAuctionUseCase,
    private val completeAuctionUseCase: CompleteAuctionUseCase,
    private val cancelAuctionUseCase: CancelAuctionUseCase,
    private val extendTimerUseCase: ExtendTimerUseCase,
    private val startRoundUseCase: StartRoundUseCase,
    private val putPlayerUseCase: PutPlayerUseCase,
    private val placeBidUseCase: PlaceBidUseCase,
    private val undoBidUseCase: UndoBidUseCase,
    private val sellPlayerUseCase: SellPlayerUseCase,
    private val undoSoldUseCase: UndoSoldUseCase,
    private val preAssignUseCase: PreAssignUseCase,
    private val unsoldPlayerUseCase: UnsoldPlayerUseCase,
    private val forceAssignUseCase: ForceAssignUseCase,
    private val startTimerUseCase: StartTimerUseCase,
    private val stopTimerUseCase: StopTimerUseCase,
    private val updateCategoryIncrementsUseCase: UpdateCategoryIncrementsUseCase,
    private val addRoundUseCase: AddRoundUseCase,
    private val updateRoundUseCase: UpdateRoundUseCase,
    private val deleteRoundUseCase: DeleteRoundUseCase,
    private val completeRoundUseCase: CompleteRoundUseCase,
    private val updatePlayerPoolUseCase: UpdatePlayerPoolUseCase,
    private val withdrawPlayerUseCase: WithdrawPlayerUseCase,
    private val deleteAuctionUseCase: DeleteAuctionUseCase,
    private val regeneratePublicViewTokenUseCase: RegeneratePublicViewTokenUseCase,
    private val auctionQueryUseCases: AuctionQueryUseCases,
    private val auctionComplexQueryUseCases: AuctionComplexQueryUseCases,
    private val getTimerStateQuery: GetTimerStateQuery,
    private val exportService: com.crichere.domain.auction.service.ExportService,
    @param:org.springframework.beans.factory.annotation.Value("\${app.base-url:http://localhost:8080}")
    private val baseUrl: String
) {

    @PostMapping("/leagues/{leagueId}")
    @ResponseStatus(org.springframework.http.HttpStatus.CREATED)
    @PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #leagueId)")
    fun createAuction(
        @PathVariable leagueId: UUID,
        @Valid @RequestBody request: AuctionCreateRequest
    ): org.springframework.http.ResponseEntity<ApiResponse<AuctionResponse>> {
        return createAuctionUseCase.execute(leagueId, request.auctioneerId, request.rounds)
            .map { mapToResponse(it) }
            .toResponseEntity(successStatus = org.springframework.http.HttpStatus.CREATED)
    }

    @GetMapping("/{id}")
    fun getAuction(@PathVariable id: UUID): org.springframework.http.ResponseEntity<ApiResponse<AuctionResponse>> {
        return auctionQueryUseCases.getAuction(id)
            .map { mapToResponse(it) }
            .toResponseEntity()
    }

    @GetMapping("/{id}/state")
    fun getAuctionState(@PathVariable id: UUID): org.springframework.http.ResponseEntity<ApiResponse<AuctionStateSnapshot>> {
        return auctionComplexQueryUseCases.getStateSnapshot(id).toResponseEntity()
    }

    @PatchMapping("/{id}/start")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun startAuction(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<AuctionResponse>> {
        return startAuctionUseCase.execute(id, UUID.fromString(user.username))
            .map { mapToResponse(it) }
            .toResponseEntity()
    }

    @PatchMapping("/{id}/pause")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun pauseAuction(
        @PathVariable id: UUID,
        @RequestBody(required = false) request: PauseAuctionRequest?,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<AuctionResponse>> {
        return pauseAuctionUseCase.execute(id, request?.reason, UUID.fromString(user.username))
            .map { mapToResponse(it) }
            .toResponseEntity()
    }

    @PatchMapping("/{id}/resume")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun resumeAuction(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<AuctionResponse>> {
        return resumeAuctionUseCase.execute(id, UUID.fromString(user.username))
            .map { mapToResponse(it) }
            .toResponseEntity()
    }

    @PatchMapping("/{id}/complete")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun completeAuction(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<AuctionResponse>> {
        return completeAuctionUseCase.execute(id, UUID.fromString(user.username))
            .map { mapToResponse(it) }
            .toResponseEntity()
    }

    @PatchMapping("/{id}/cancel")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun cancelAuction(
        @PathVariable id: UUID,
        @RequestBody(required = false) request: CancelAuctionRequest?,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<AuctionResponse>> {
        return cancelAuctionUseCase.execute(id, request?.reason, UUID.fromString(user.username))
            .map { mapToResponse(it) }
            .toResponseEntity()
    }

    @PatchMapping("/{id}/timer/extend")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun extendTimer(
        @PathVariable id: UUID,
        @Valid @RequestBody request: TimerExtendRequest,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<TimerStateResponse>> {
        return extendTimerUseCase.execute(id, request.additionalSeconds, UUID.fromString(user.username)).toResponseEntity()
    }

    @PatchMapping("/{id}/rounds/{roundId}/start")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun startRound(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<Unit>> {
        return startRoundUseCase.execute(id, roundId, UUID.fromString(user.username))
            .map { Unit }
            .toResponseEntity(message = "Round started")
    }

    @PostMapping("/{id}/player/put")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun putPlayer(
        @PathVariable id: UUID,
        @RequestBody(required = false) request: PutPlayerRequest?,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<PlayerAuctionStateResponse>> {
        return putPlayerUseCase.execute(id, request?.leaguePlayerId, UUID.fromString(user.username))
            .map { mapToStateResponse(it) }
            .toResponseEntity()
    }

    @PostMapping("/{id}/bid")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun placeBid(
        @PathVariable id: UUID,
        @Valid @RequestBody request: BidRequest,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<BidResponse>> {
        return placeBidUseCase.execute(id, request.franchiseId, request.bidAmount, UUID.fromString(user.username))
            .map { bid -> BidResponse(bid.id, bid.auctionId, bid.roundId, bid.leaguePlayerId, bid.franchiseId, bid.bidAmount, bid.status, bid.recordedBy, bid.bidAt) }
            .toResponseEntity()
    }

    @PatchMapping("/{id}/bid/undo")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun undoBid(
        @PathVariable id: UUID,
        @Valid @RequestBody request: UndoBidRequest,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<PlayerAuctionStateResponse>> {
        return undoBidUseCase.execute(id, request.reason, UUID.fromString(user.username))
            .map { mapToStateResponse(it) }
            .toResponseEntity()
    }

    @PostMapping("/{id}/player/sold")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun sellPlayer(
        @PathVariable id: UUID,
        @Valid @RequestBody request: PlayerSoldRequest,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<PlayerAuctionStateResponse>> {
        return sellPlayerUseCase.execute(id, request.leaguePlayerId, request.franchiseId, request.finalPrice, UUID.fromString(user.username))
            .map { mapToStateResponse(it) }
            .toResponseEntity()
    }

    @PatchMapping("/{id}/player/undo-sold")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun undoSold(
        @PathVariable id: UUID,
        @Valid @RequestBody request: UndoSoldRequest,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<PlayerAuctionStateResponse>> {
        return undoSoldUseCase.execute(id, request.leaguePlayerId, request.reason, UUID.fromString(user.username))
            .map { mapToStateResponse(it) }
            .toResponseEntity()
    }

    @PostMapping("/{id}/player/pre-assign")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun preAssign(
        @PathVariable id: UUID,
        @Valid @RequestBody request: PreAssignRequest,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<PlayerAuctionStateResponse>> {
        return preAssignUseCase.execute(id, request.leaguePlayerId, request.franchiseId, request.assignmentType, request.price, UUID.fromString(user.username))
            .map { mapToStateResponse(it) }
            .toResponseEntity()
    }

    @PostMapping("/{id}/player/unsold")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun unsoldPlayer(
        @PathVariable id: UUID,
        @Valid @RequestBody request: UnsoldPlayerRequest,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<PlayerAuctionStateResponse>> {
        return unsoldPlayerUseCase.execute(id, request.leaguePlayerId, UUID.fromString(user.username))
            .map { mapToStateResponse(it) }
            .toResponseEntity()
    }

    @PostMapping("/{id}/player/force-assign")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun forceAssign(
        @PathVariable id: UUID,
        @Valid @RequestBody request: ForceAssignRequest,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<PlayerAuctionStateResponse>> {
        return forceAssignUseCase.execute(id, request.leaguePlayerId, request.franchiseId, request.price, UUID.fromString(user.username))
            .map { mapToStateResponse(it) }
            .toResponseEntity()
    }

    @PostMapping("/{id}/timer/start")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun startTimer(
        @PathVariable id: UUID,
        @RequestBody(required = false) request: TimerStartRequest?,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<TimerStateResponse>> {
        return startTimerUseCase.execute(id, request?.durationSeconds, UUID.fromString(user.username)).toResponseEntity()
    }

    @PostMapping("/{id}/timer/stop")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun stopTimer(
        @PathVariable id: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<Unit>> {
        return stopTimerUseCase.execute(id, UUID.fromString(user.username))
            .map { Unit }
            .toResponseEntity(message = "Timer stopped")
    }

    @GetMapping("/{id}/timer/state")
    fun getTimerState(@PathVariable id: UUID): org.springframework.http.ResponseEntity<ApiResponse<TimerStateResponse>> {
        return getTimerStateQuery.execute(id).toResponseEntity()
    }

    @PostMapping("/{id}/rounds/{roundId}/category-increments")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun updateCategoryIncrements(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @RequestBody request: List<CategoryIncrementRequest>
    ): org.springframework.http.ResponseEntity<ApiResponse<List<CategoryIncrementResponse>>> {
        return updateCategoryIncrementsUseCase.execute(roundId, request)
            .map { increments -> increments.map { CategoryIncrementResponse(it.id, it.roundId, it.category, it.tag, it.bidIncrement) } }
            .toResponseEntity()
    }

    @GetMapping("/{id}/rounds/{roundId}/category-increments")
    fun getCategoryIncrements(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID
    ): org.springframework.http.ResponseEntity<ApiResponse<List<CategoryIncrementResponse>>> {
        return auctionQueryUseCases.getCategoryIncrements(roundId)
            .map { increments -> increments.map { CategoryIncrementResponse(it.id, it.roundId, it.category, it.tag, it.bidIncrement) } }
            .toResponseEntity()
    }

    @GetMapping("/{id}/audit-log")
    fun getAuditLog(
        @PathVariable id: UUID,
        @RequestParam(required = false) fromSequence: Long?
    ): org.springframework.http.ResponseEntity<ApiResponse<List<AuditLogResponse>>> {
        val result = if (fromSequence != null) {
            auctionQueryUseCases.getAuditLogsSince(id, fromSequence)
        } else {
            auctionQueryUseCases.getAuditLogs(id)
        }
        return result.map { logs -> logs.map { AuditLogResponse(it.id, it.auctionId, it.sequenceNumber, it.action, it.payload, it.actorId, it.createdAt) } }
            .toResponseEntity()
    }

    @PostMapping("/{id}/rounds")
    @ResponseStatus(org.springframework.http.HttpStatus.CREATED)
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun addRound(
        @PathVariable id: UUID,
        @Valid @RequestBody request: RoundConfigDto
    ): org.springframework.http.ResponseEntity<ApiResponse<Unit>> {
        return addRoundUseCase.execute(id, request)
            .map { Unit }
            .toResponseEntity(successStatus = org.springframework.http.HttpStatus.CREATED, message = "Round added")
    }

    @GetMapping("/{id}/rounds")
    fun getRounds(@PathVariable id: UUID): org.springframework.http.ResponseEntity<ApiResponse<List<RoundConfigDto>>> {
        return auctionQueryUseCases.getRounds(id).map { rounds ->
            rounds.map { r ->
                val slabs = auctionQueryUseCases.getRoundSlabs(r.id).getOrNull() ?: emptyList()
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
                    bidIncrementSlabs = slabs
                )
            }
        }.toResponseEntity()
    }

    @GetMapping("/{id}/rounds/{roundId}")
    fun getRound(@PathVariable id: UUID, @PathVariable roundId: UUID): org.springframework.http.ResponseEntity<ApiResponse<RoundConfigDto>> {
        return auctionQueryUseCases.getRound(roundId).map { r ->
            val slabs = auctionQueryUseCases.getRoundSlabs(roundId).getOrNull() ?: emptyList()
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
                bidIncrementSlabs = slabs
            )
        }.toResponseEntity()
    }

    @PutMapping("/{id}/rounds/{roundId}")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun updateRound(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @Valid @RequestBody request: RoundConfigDto
    ): org.springframework.http.ResponseEntity<ApiResponse<Unit>> {
        return updateRoundUseCase.execute(roundId, request)
            .map { Unit }
            .toResponseEntity(message = "Round updated")
    }

    @DeleteMapping("/{id}/rounds/{roundId}")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun deleteRound(@PathVariable id: UUID, @PathVariable roundId: UUID): org.springframework.http.ResponseEntity<ApiResponse<Unit>> {
        return deleteRoundUseCase.execute(roundId)
            .map { Unit }
            .toResponseEntity(message = "Round deleted")
    }

    @PatchMapping("/{id}/rounds/{roundId}/complete")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun completeRound(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<Unit>> {
        return completeRoundUseCase.execute(id, roundId, UUID.fromString(user.username))
            .map { Unit }
            .toResponseEntity(message = "Round completed")
    }

    @GetMapping("/{id}/rounds/{roundId}/player-pool")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun getPlayerPool(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID
    ): org.springframework.http.ResponseEntity<ApiResponse<List<PlayerAuctionStateResponse>>> {
        return auctionComplexQueryUseCases.getPlayerPool(id, roundId).toResponseEntity()
    }

    @PatchMapping("/{id}/rounds/{roundId}/player-pool")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun updatePlayerPool(
        @PathVariable id: UUID,
        @PathVariable roundId: UUID,
        @Valid @RequestBody request: UpdatePlayerPoolRequest
    ): org.springframework.http.ResponseEntity<ApiResponse<Unit>> {
        return updatePlayerPoolUseCase.execute(roundId, request.playerIds)
            .map { Unit }
            .toResponseEntity(message = "Player pool updated")
    }

    @PostMapping("/{id}/player/withdraw")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun withdrawPlayer(
        @PathVariable id: UUID,
        @Valid @RequestBody request: WithdrawPlayerRequest,
        @AuthenticationPrincipal user: UserDetails
    ): org.springframework.http.ResponseEntity<ApiResponse<PlayerAuctionStateResponse>> {
        // Need to fetch from DB and map to response, or just change UI to handle Unit. 
        // We will just do a temporary fetch from ComplexQueryUseCases (not ideal but works for refactor).
        // Actually, we can return the state snapshot's current player if available, or just map manually.
        // But since this is a refactor, I will just call `withdrawPlayerUseCase` then fetch.
        val res = withdrawPlayerUseCase.execute(id, request.leaguePlayerId, request.reason, UUID.fromString(user.username))
        return res.map { 
            // In a real CQRS system we wouldn't return domain entities from command, but here we just return dummy or query again.
            // But wait, the frontend doesn't actually need PlayerAuctionStateResponse most times. 
            // I'll just map it to a basic one. Or better, fetch from query side!
            auctionComplexQueryUseCases.getStateSnapshot(id).getOrNull()?.currentPlayer ?: PlayerAuctionStateResponse(
                it.id, it.auctionId, it.leaguePlayerId, it.state, it.currentHighestBid, it.currentHighestBidderId, it.finalPrice, it.soldToFranchiseId, "Unknown", null, 0, null
            )
        }.toResponseEntity()
    }

    @GetMapping("/{id}/bids/{leaguePlayerId}")
    fun getBidHistory(
        @PathVariable id: UUID,
        @PathVariable leaguePlayerId: UUID
    ): org.springframework.http.ResponseEntity<ApiResponse<List<BidResponse>>> {
        return auctionComplexQueryUseCases.getBidHistory(id, leaguePlayerId)
            .map { history -> history.map { b -> BidResponse(b.id, b.auctionId, b.roundId, b.leaguePlayerId, b.franchiseId, b.bidAmount, b.status, b.recordedBy, b.bidAt) } }
            .toResponseEntity()
    }

    @GetMapping("/{id}/summary")
    fun getAuctionSummary(@PathVariable id: UUID): org.springframework.http.ResponseEntity<ApiResponse<AuctionSummaryResponse>> {
        return auctionComplexQueryUseCases.getDetailedAuctionSummary(id).toResponseEntity()
    }

    @GetMapping("/{id}/summary/franchises/{franchiseId}")
    fun getFranchiseSummary(
        @PathVariable id: UUID,
        @PathVariable franchiseId: UUID
    ): org.springframework.http.ResponseEntity<ApiResponse<FranchiseDetailedSummaryResponse>> {
        return auctionComplexQueryUseCases.getFranchiseDetailedSummary(id, franchiseId).toResponseEntity()
    }

    @GetMapping("/{id}/summary/unsold")
    fun getUnsoldPlayers(
        @PathVariable id: UUID,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): org.springframework.http.ResponseEntity<ApiResponse<UnsoldPlayersResponse>> {
        return auctionComplexQueryUseCases.getUnsoldPlayers(id, org.springframework.data.domain.PageRequest.of(page, size)).toResponseEntity()
    }

    @GetMapping("/{id}/summary/export/pdf", produces = ["application/pdf"])
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
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
        val pdf = exportService.exportFranchiseSquadPdf(id, franchiseId)
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
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun deleteAuction(@PathVariable id: UUID): org.springframework.http.ResponseEntity<ApiResponse<Unit>> {
        return deleteAuctionUseCase.execute(id)
            .map { Unit }
            .toResponseEntity(message = "Auction deleted")
    }

    @PostMapping("/{id}/regenerate-view-token")
    @PreAuthorize("@auctionAuth.canManage(#id, authentication)")
    fun regenerateViewToken(@PathVariable id: UUID): org.springframework.http.ResponseEntity<ApiResponse<AuctionResponse>> {
        return regeneratePublicViewTokenUseCase.execute(id)
            .map { mapToResponse(it) }
            .toResponseEntity()
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

    private fun mapToStateResponse(state: com.crichere.domain.auction.entity.PlayerAuctionState) = PlayerAuctionStateResponse(
        state.id, state.auctionId, state.leaguePlayerId, state.state, state.currentHighestBid, state.currentHighestBidderId, state.finalPrice, state.soldToFranchiseId, "Unknown", null, 0, null
    )
}
