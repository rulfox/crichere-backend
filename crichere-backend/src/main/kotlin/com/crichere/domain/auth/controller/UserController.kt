package com.crichere.domain.auth.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.auth.dto.*
import com.crichere.domain.auth.service.UserService
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.http.HttpStatus
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/users")
@Tag(name = "User Management")
class UserController(private val userService: UserService) {

    @GetMapping("/{id}")
    fun getUser(@PathVariable id: UUID): ApiResponse<UserResponse> {
        val user = userService.getUserById(id)
        val response = UserResponse(
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
        return ResponseHelper.success(data = response)
    }

    @PutMapping("/{id}/basic")
    fun updateBasicInfo(
        @PathVariable id: UUID,
        @RequestBody request: UserBasicInfoRequest
    ): ApiResponse<Nothing> {
        userService.updateBasicInfo(id, request.name, request.email)
        return ResponseHelper.success(message = "Basic info updated", messageKey = "success.user_updated")
    }

    @PutMapping("/{id}/cricket-profile")
    fun updateCricketProfile(
        @PathVariable id: UUID,
        @RequestBody request: CricketProfileRequest
    ): ApiResponse<Nothing> {
        userService.updateCricketProfile(id, request)
        return ResponseHelper.success(message = "Cricket profile updated", messageKey = "success.profile_updated")
    }

    @PutMapping("/{id}/photo")
    fun updatePhoto(
        @PathVariable id: UUID,
        @RequestBody request: Map<String, String>
    ): ApiResponse<Nothing> {
        val s3Key = request["s3Key"] ?: throw com.crichere.common.exception.BusinessLogicException("S3 key is required", "error.missing_s3_key")
        userService.updatePhoto(id, s3Key)
        return ResponseHelper.success(message = "Profile photo updated", messageKey = "success.photo_updated")
    }

    @GetMapping("/search")
    fun searchUsers(@RequestParam query: String): ApiResponse<List<UserResponse>> {
        val users = userService.searchUsers(query)
        val response = users.map { user ->
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
        return ResponseHelper.success(data = response)
    }

    @PostMapping("/ghost")
    @ResponseStatus(HttpStatus.CREATED)
    fun createGhost(
        @RequestBody request: GhostPlayerRequest,
        @AuthenticationPrincipal admin: UserDetails
    ): ApiResponse<UUID> {
        val user = userService.createGhostPlayer(request.phone, request.name, UUID.fromString(admin.username))
        return ResponseHelper.success(data = user.id, message = "Ghost player created")
    }
}
