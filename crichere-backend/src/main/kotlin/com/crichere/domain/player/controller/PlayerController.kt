package com.crichere.domain.player.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.toResponseEntity
import com.crichere.domain.player.dto.*
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.usecase.RegisterPlayerUseCase
import com.crichere.domain.player.usecase.GetLeaguePlayerQuery
import com.crichere.domain.player.mapper.toResponse
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/players")
@Tag(name = "Player Management")
class PlayerController(
    private val registerPlayerUseCase: RegisterPlayerUseCase,
    private val getLeaguePlayerQuery: GetLeaguePlayerQuery
) {

    @PostMapping("/register")
    @org.springframework.security.access.prepost.PreAuthorize("hasRole('PLATFORM_ADMIN') or #request.userId.toString() == authentication.name")
    fun registerPlayer(@Valid @RequestBody request: PlayerRegisterRequest): ResponseEntity<ApiResponse<LeaguePlayerResponse>> {
        val playerToRegister = LeaguePlayer(
            leagueId = request.leagueId,
            userId = request.userId,
            basePriceOverride = request.basePrice,
            tag = request.tag,
            category = request.category
        )
        
        return registerPlayerUseCase.execute(playerToRegister)
            .map { it.toResponse() }
            .toResponseEntity("Player registered successfully", "success.player_registered", org.springframework.http.HttpStatus.CREATED)
    }

    @GetMapping("/{id}")
    fun getPlayer(@PathVariable id: UUID): ResponseEntity<ApiResponse<LeaguePlayerResponse>> {
        return getLeaguePlayerQuery.execute(id)
            .map { it.toResponse() }
            .toResponseEntity()
    }
}
