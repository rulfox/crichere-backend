package com.crichere.domain.franchise.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.franchise.dto.*
import com.crichere.domain.franchise.entity.Franchise
import com.crichere.domain.franchise.service.FranchiseService
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/franchises")
@Tag(name = "Franchise Management")
class FranchiseController(
    private val franchiseService: FranchiseService
) {

    @PostMapping
    fun createFranchise(@Valid @RequestBody request: FranchiseCreateRequest): ApiResponse<FranchiseResponse> {
        val franchise = franchiseService.createFranchise(
            Franchise(
                leagueId = request.leagueId,
                name = request.name,
                logoUrl = request.logoUrl,
                ownerId = request.ownerId,
                totalPurse = request.totalPurse,
                remainingPurse = request.totalPurse
            )
        )
        val response = FranchiseResponse(
            id = franchise.id,
            leagueId = franchise.leagueId,
            name = franchise.name,
            logoUrl = franchise.logoUrl,
            ownerId = franchise.ownerId,
            totalPurse = franchise.totalPurse,
            remainingPurse = franchise.remainingPurse
        )
        return ResponseHelper.success(data = response, message = "Franchise created successfully", messageKey = "success.franchise_created")
    }

    @GetMapping("/{id}")
    fun getFranchise(@PathVariable id: UUID): ApiResponse<FranchiseResponse> {
        val franchise = franchiseService.getFranchise(id)
        val response = FranchiseResponse(
            id = franchise.id,
            leagueId = franchise.leagueId,
            name = franchise.name,
            logoUrl = franchise.logoUrl,
            ownerId = franchise.ownerId,
            totalPurse = franchise.totalPurse,
            remainingPurse = franchise.remainingPurse
        )
        return ResponseHelper.success(data = response)
    }

    @PostMapping("/{id}/invites")
    fun createInvite(
        @PathVariable id: UUID,
        @Valid @RequestBody request: FranchiseInviteRequest
    ): ApiResponse<FranchiseInviteResponse> {
        val invite = franchiseService.createInvite(id, request.email)
        val response = FranchiseInviteResponse(
            id = invite.id,
            franchiseId = invite.franchiseId,
            email = invite.email,
            token = invite.token,
            status = invite.status,
            expiresAt = invite.expiresAt
        )
        return ResponseHelper.success(data = response, message = "Invite sent successfully", messageKey = "success.invite_sent")
    }
}
