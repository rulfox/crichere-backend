package com.crichere.domain.auth.dto

import com.crichere.domain.auth.enums.*
import java.time.LocalDate
import java.util.*

data class OtpSendRequest(val phone: String)
data class OtpVerifyRequest(val phone: String, val code: String)
data class TokenRefreshRequest(val refreshToken: String)
data class ClaimProfileRequest(val name: String, val playingRole: PlayingRole)

data class UserBasicInfoRequest(val name: String?, val email: String?)
data class CricketProfileRequest(
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

data class GhostPlayerRequest(val phone: String, val name: String)
data class PresignedUrlRequest(val fileName: String, val contentType: String)
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
