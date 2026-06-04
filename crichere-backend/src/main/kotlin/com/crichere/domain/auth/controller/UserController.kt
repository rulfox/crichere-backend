package com.crichere.domain.auth.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.auth.dto.*
import com.crichere.domain.auth.usecase.*
import com.crichere.domain.franchise.repository.FranchiseRepository
import com.crichere.domain.auth.repository.UserFranchiseMembershipRepository
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springframework.http.HttpStatus
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/users")
@Tag(name = "User Management")
class UserController(
    private val getUserProfileQuery: GetUserProfileQuery,
    private val getUserLeaguesQuery: GetUserLeaguesQuery,
    private val searchUsersQuery: SearchUsersQuery,
    private val updateBasicInfoUseCase: UpdateBasicInfoUseCase,
    private val updateCricketProfileUseCase: UpdateCricketProfileUseCase,
    private val updatePhotoUseCase: UpdatePhotoUseCase,
    private val createGhostPlayerUseCase: CreateGhostPlayerUseCase,
    private val franchiseRepository: FranchiseRepository,
    private val franchiseMembershipRepository: UserFranchiseMembershipRepository
) {

    @GetMapping("/{id}")
    fun getUser(@PathVariable id: UUID): ApiResponse<UserResponse> {
        val result = getUserProfileQuery.execute(id)
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(data = result.data)
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.NOT_FOUND.name, error.message, error.messageKey ?: "error.not_found")
        }
    }

    @GetMapping("/{id}/franchises")
    fun getUserFranchises(@PathVariable id: UUID): ApiResponse<List<com.crichere.domain.franchise.dto.FranchiseResponse>> {
        val owned = franchiseRepository.findByOwnerId(id)
        val memberOf = franchiseMembershipRepository.findAllByUserId(id).map { it.franchiseId }
        val membershipFranchises = if (memberOf.isNotEmpty()) franchiseRepository.findAllById(memberOf) else emptyList()
        val combined = (owned + membershipFranchises).distinctBy { it.id }
        return ResponseHelper.success(data = combined.map { f ->
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

    @GetMapping("/{id}/leagues")
    fun getUserLeagues(@PathVariable id: UUID): ApiResponse<List<com.crichere.domain.league.dto.LeagueResponse>> {
        val result = getUserLeaguesQuery.execute(id)
        return if (result is com.crichere.common.domain.Result.Success) {
            val leagues = result.data
            ResponseHelper.success(data = leagues.map { league ->
                com.crichere.domain.league.dto.LeagueResponse(
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
                    auctionIds = emptyList()
                )
            })
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @PutMapping("/{id}/basic")
    @org.springframework.security.access.prepost.PreAuthorize("hasRole('PLATFORM_ADMIN') or #id.toString() == authentication.name")
    fun updateBasicInfo(
        @PathVariable id: UUID,
        @Valid @RequestBody request: UserBasicInfoRequest
    ): ApiResponse<Nothing> {
        val result = updateBasicInfoUseCase.execute(id, request.name, request.email)
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(message = "Basic info updated", messageKey = "success.user_updated")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @PutMapping("/{id}/cricket-profile")
    @org.springframework.security.access.prepost.PreAuthorize("hasRole('PLATFORM_ADMIN') or #id.toString() == authentication.name")
    fun updateCricketProfile(
        @PathVariable id: UUID,
        @Valid @RequestBody request: CricketProfileRequest
    ): ApiResponse<Nothing> {
        val result = updateCricketProfileUseCase.execute(id, request)
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(message = "Cricket profile updated", messageKey = "success.profile_updated")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @PutMapping("/{id}/photo")
    @org.springframework.security.access.prepost.PreAuthorize("hasRole('PLATFORM_ADMIN') or #id.toString() == authentication.name")
    fun updatePhoto(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, String>
    ): ApiResponse<Nothing> {
        val s3Key = request["s3Key"] ?: throw com.crichere.common.exception.BusinessLogicException("S3 key is required", "error.missing_s3_key")
        val result = updatePhotoUseCase.execute(id, s3Key)
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success(message = "Profile photo updated", messageKey = "success.photo_updated")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }

    @GetMapping("/search")
    @org.springframework.security.access.prepost.PreAuthorize("isAuthenticated()")
    fun searchUsers(
        @RequestParam query: String,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int
    ): ApiResponse<com.crichere.common.response.PageResponse<UserResponse>> {
        val resultPageResult = searchUsersQuery.execute(query, org.springframework.data.domain.PageRequest.of(page, size))
        if (resultPageResult is com.crichere.common.domain.Result.Failure) {
            val error = resultPageResult.error
            return ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
        val resultPage = (resultPageResult as com.crichere.common.domain.Result.Success).data
        val response = resultPage.map { user ->
            UserResponse(
                id = user.id,
                phone = user.phone,
                name = user.name,
                email = user.email,
                profileStatus = user.profileStatus,
                profilePhoto = user.profilePhoto,
                playingRole = user.playingRole,
                battingStyle = user.battingStyle,
                bowlingStyle = user.bowlingStyle,
                bowlingType = user.bowlingType,
                experienceLevel = user.experienceLevel,
                jerseyNumber = user.jerseyNumber,
                dateOfBirth = user.dateOfBirth,
                gender = user.gender,
                city = user.city,
                state = user.state
            )
        }
        return ResponseHelper.success(data = com.crichere.common.response.PageResponse(
            content = response.content,
            totalElements = response.totalElements,
            totalPages = response.totalPages,
            pageNumber = response.number,
            pageSize = response.size
        ))
    }

    @PostMapping("/ghost")
    @ResponseStatus(HttpStatus.CREATED)
    @org.springframework.security.access.prepost.PreAuthorize("hasRole('LEAGUE_ADMIN') or hasRole('PLATFORM_ADMIN')")
    fun createGhost(
        @Valid @RequestBody request: GhostPlayerRequest,
        @AuthenticationPrincipal admin: UserDetails
    ): ApiResponse<UUID> {
        val result = createGhostPlayerUseCase.execute(request.phone, request.name, UUID.fromString(admin.username))
        return if (result is com.crichere.common.domain.Result.Success) {
            ResponseHelper.success<UUID>(data = result.data.id, message = "Ghost player created")
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }
}
