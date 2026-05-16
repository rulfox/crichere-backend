package com.crichere.domain.player.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.player.dto.*
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.service.PlayerService
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/players")
@Tag(name = "Player Management")
class PlayerController(
    private val playerService: PlayerService
) {

    @PostMapping("/register")
    @org.springframework.security.access.prepost.PreAuthorize("hasRole('PLATFORM_ADMIN') or #request.userId.toString() == authentication.name")
    fun registerPlayer(@Valid @RequestBody request: PlayerRegisterRequest): ApiResponse<LeaguePlayerResponse> {
        val player = playerService.registerPlayer(
            LeaguePlayer(
                leagueId = request.leagueId,
                userId = request.userId,
                basePriceOverride = request.basePrice,
                tag = request.tag,
                category = request.category
            )
        )
        val response = LeaguePlayerResponse(
            id = player.id,
            leagueId = player.leagueId,
            userId = player.userId,
            basePrice = player.basePrice,
            basePriceOverride = player.basePriceOverride,
            tag = player.tag,
            status = player.status,
            category = player.category,
            auctionEligible = player.auctionEligible
        )
        return ResponseHelper.success(data = response, message = "Player registered successfully", messageKey = "success.player_registered")
    }

    @GetMapping("/{id}")
    fun getPlayer(@PathVariable id: UUID): ApiResponse<LeaguePlayerResponse> {
        val player = playerService.getLeaguePlayer(id)
        val response = LeaguePlayerResponse(
            id = player.id,
            leagueId = player.leagueId,
            userId = player.userId,
            basePrice = player.basePrice,
            basePriceOverride = player.basePriceOverride,
            tag = player.tag,
            status = player.status,
            category = player.category,
            auctionEligible = player.auctionEligible
        )
        return ResponseHelper.success(data = response)
    }
}
