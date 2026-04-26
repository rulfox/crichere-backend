package com.crichere.domain.auth.dto

import com.crichere.domain.auth.enums.*
import jakarta.validation.constraints.*
import java.time.LocalDate
import java.util.*

data class OtpSendRequest(
    @field:NotBlank
    @field:Pattern(regexp = "^[6-9]\\d{9}$", message = "must be a valid 10-digit Indian mobile number")
    val phone: String
)

data class OtpVerifyRequest(
    @field:NotBlank
    @field:Pattern(regexp = "^[6-9]\\d{9}$", message = "must be a valid 10-digit Indian mobile number")
    val phone: String,

    @field:NotBlank
    @field:Size(min = 4, max = 6)
    val code: String
)

data class TokenRefreshRequest(
    @field:NotBlank
    val refreshToken: String
)

data class ClaimProfileRequest(
    @field:NotBlank
    @field:Size(max = 100)
    val name: String,
    val playingRole: PlayingRole
)

data class UserBasicInfoRequest(
    @field:Size(max = 100)
    val name: String?,

    @field:Email
    @field:Size(max = 255)
    val email: String?
)

data class CricketProfileRequest(
    val playingRole: PlayingRole?,
    val battingStyle: BattingStyle?,
    val bowlingStyle: BowlingStyle?,
    val bowlingType: BowlingType?,
    val experienceLevel: ExperienceLevel?,

    @field:Positive
    val jerseyNumber: Int?,
    val dateOfBirth: LocalDate?,

    @field:Size(max = 50)
    val gender: String?,

    @field:Size(max = 100)
    val city: String?,

    @field:Size(max = 100)
    val state: String?
)

data class GhostPlayerRequest(
    @field:NotBlank
    @field:Pattern(regexp = "^[6-9]\\d{9}$", message = "must be a valid 10-digit Indian mobile number")
    val phone: String,

    @field:NotBlank
    @field:Size(max = 100)
    val name: String
)

data class PresignedUrlRequest(
    @field:NotBlank
    @field:Size(max = 255)
    val fileName: String,

    @field:NotBlank
    @field:Size(max = 100)
    val contentType: String
)

data class PresignedUrlResponse(val url: String, val key: String)

data class UserResponse(
    val id: UUID,
    val phone: String,
    val name: String?,
    val email: String?,
    val profileStatus: ProfileStatus,
    val profilePhoto: String?,
    val playingRole: PlayingRole?,
    val battingStyle: BattingStyle?,
    val bowlingStyle: BowlingStyle?,
    val bowlingType: BowlingType?,
    val experienceLevel: ExperienceLevel?,
    val jerseyNumber: Int?,
    val dateOfBirth: LocalDate?,
    val gender: String?,
    val city: String?,
    val state: String?
)
