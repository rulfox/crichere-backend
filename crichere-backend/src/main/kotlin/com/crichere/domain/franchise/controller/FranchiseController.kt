package com.crichere.domain.franchise.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.toResponseEntity
import com.crichere.domain.franchise.dto.*
import com.crichere.domain.franchise.entity.Franchise
import com.crichere.domain.franchise.usecase.*
import com.crichere.domain.franchise.mapper.toResponse
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*
import org.springframework.beans.factory.annotation.Value

@RestController
@RequestMapping("/franchises")
@Tag(name = "Franchise Management")
class FranchiseController(
    private val createFranchiseUseCase: CreateFranchiseUseCase,
    private val getFranchiseQuery: GetFranchiseQuery,
    private val updateFranchiseUseCase: UpdateFranchiseUseCase,
    private val createFranchiseInviteUseCase: CreateFranchiseInviteUseCase,
    private val getFranchiseInvitesQuery: GetFranchiseInvitesQuery,
    private val acceptFranchiseInviteUseCase: AcceptFranchiseInviteUseCase,
    private val getFranchiseSquadQuery: GetFranchiseSquadQuery,
    @param:Value("\${app.base-url:http://localhost:8080}") private val baseUrl: String
) {

    private fun getInviteUrl(token: UUID): String = "$baseUrl/api/v1/public/invites/validate?token=$token"

    @PostMapping
    @org.springframework.security.access.prepost.PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN_' + #request.leagueId)")
    fun createFranchise(@Valid @RequestBody request: FranchiseCreateRequest): ResponseEntity<ApiResponse<FranchiseResponse>> {
        val franchiseToCreate = Franchise(
            leagueId = request.leagueId,
            name = request.name,
            logoUrl = request.logoUrl,
            ownerId = request.ownerId,
            totalPurse = request.totalPurse,
            remainingPurse = request.totalPurse
        )
        
        return createFranchiseUseCase.execute(franchiseToCreate)
            .map { it.toResponse() }
            .toResponseEntity("Franchise created successfully", "success.franchise_created", org.springframework.http.HttpStatus.CREATED)
    }

    @GetMapping("/{id}")
    fun getFranchise(@PathVariable id: UUID): ResponseEntity<ApiResponse<FranchiseResponse>> {
        return getFranchiseQuery.execute(id)
            .map { it.toResponse() }
            .toResponseEntity()
    }

    @PatchMapping("/{id}")
    @org.springframework.security.access.prepost.PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('FRANCHISE_OWNER_' + #id)")
    fun updateFranchise(
        @PathVariable id: UUID,
        @Valid @RequestBody request: FranchiseUpdateRequest
    ): ResponseEntity<ApiResponse<FranchiseResponse>> {
        return updateFranchiseUseCase.execute(id, request)
            .map { it.toResponse() }
            .toResponseEntity("Franchise updated successfully")
    }

    @GetMapping("/{id}/invites")
    @org.springframework.security.access.prepost.PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('FRANCHISE_OWNER_' + #id)")
    fun getInvites(@PathVariable id: UUID): ResponseEntity<ApiResponse<List<FranchiseInviteResponse>>> {
        return getFranchiseInvitesQuery.execute(id)
            .map { invites -> invites.map { it.toResponse(getInviteUrl(it.token)) } }
            .toResponseEntity()
    }

    @GetMapping("/{id}/squad")
    fun getSquad(@PathVariable id: UUID): ResponseEntity<ApiResponse<FranchiseSquadResponse>> {
        val franchiseResult = getFranchiseQuery.execute(id)
        if (franchiseResult is com.crichere.common.domain.Result.Failure) {
            return franchiseResult.toResponseEntity()
        }
        val franchise = (franchiseResult as com.crichere.common.domain.Result.Success).data
        
        return getFranchiseSquadQuery.execute(id)
            .map { squad ->
                FranchiseSquadResponse(
                    franchiseId = id,
                    franchiseName = franchise.name,
                    players = squad
                )
            }
            .toResponseEntity()
    }

    @PostMapping("/{id}/invites")
    @org.springframework.security.access.prepost.PreAuthorize("hasRole('PLATFORM_ADMIN') or hasRole('LEAGUE_ADMIN') or hasRole('FRANCHISE_OWNER_' + #id)")
    fun createInvite(
        @PathVariable id: UUID,
        @Valid @RequestBody request: FranchiseInviteRequest
    ): ResponseEntity<ApiResponse<FranchiseInviteResponse>> {
        return createFranchiseInviteUseCase.execute(id, request.email)
            .map { it.toResponse(getInviteUrl(it.token)) }
            .toResponseEntity("Invite created successfully", "success.invite_created", org.springframework.http.HttpStatus.CREATED)
    }

    @PostMapping("/accept")
    @org.springframework.security.access.prepost.PreAuthorize("isAuthenticated()")
    fun acceptInvite(
        @Valid @RequestBody request: InviteAcceptRequest,
        @org.springframework.security.core.annotation.AuthenticationPrincipal userDetails: org.springframework.security.core.userdetails.UserDetails
    ): ResponseEntity<ApiResponse<FranchiseResponse>> {
        val userId = UUID.fromString(userDetails.username)
        return acceptFranchiseInviteUseCase.execute(request.token, userId)
            .map { it.toResponse() }
            .toResponseEntity("Invite accepted successfully", "success.invite_accepted")
    }
}
