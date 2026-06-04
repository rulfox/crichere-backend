package com.crichere.domain.auth.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.auth.dto.UserResponse
import com.crichere.domain.auth.error.AuthDomainError
import com.crichere.domain.auth.repository.UserLeagueMembershipRepository
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.repository.LeagueRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import software.amazon.awssdk.services.s3.model.PutObjectRequest
import software.amazon.awssdk.services.s3.presigner.S3Presigner
import software.amazon.awssdk.services.s3.presigner.model.PutObjectPresignRequest
import org.springframework.beans.factory.annotation.Value
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import java.time.Duration
import java.util.UUID

interface GetUserProfileQuery {
    fun execute(userId: UUID): Result<UserResponse, AuthDomainError>
}

interface GetUserLeaguesQuery {
    fun execute(userId: UUID): Result<List<League>, AuthDomainError>
}

interface SearchUsersQuery {
    fun execute(query: String, pageable: Pageable): Result<Page<com.crichere.domain.auth.entity.User>, AuthDomainError>
}

interface GeneratePhotoUploadUrlQuery {
    fun execute(userId: UUID, extension: String): Result<Pair<String, String>, AuthDomainError>
}

@Service
class GetUserProfileQueryImpl(
    private val userRepository: UserRepository
) : GetUserProfileQuery {
    @Transactional(readOnly = true)
    override fun execute(userId: UUID): Result<UserResponse, AuthDomainError> {
        val userOpt = userRepository.findById(userId)
        if (userOpt.isEmpty) {
            return Result.Failure(AuthDomainError.UserNotFound(userId))
        }
        val user = userOpt.get()
        return Result.Success(UserResponse(
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
        ))
    }
}

@Service
class GetUserLeaguesQueryImpl(
    private val userLeagueMembershipRepository: UserLeagueMembershipRepository,
    private val leagueRepository: LeagueRepository
) : GetUserLeaguesQuery {
    @Transactional(readOnly = true)
    override fun execute(userId: UUID): Result<List<League>, AuthDomainError> {
        val memberships = userLeagueMembershipRepository.findAllByUserId(userId)
        val leagues = memberships.map { leagueRepository.findById(it.leagueId).get() }
        return Result.Success(leagues)
    }
}

@Service
class SearchUsersQueryImpl(
    private val userRepository: UserRepository
) : SearchUsersQuery {
    @Transactional(readOnly = true)
    override fun execute(query: String, pageable: Pageable): Result<Page<com.crichere.domain.auth.entity.User>, AuthDomainError> {
        return Result.Success(userRepository.findByNameContainingIgnoreCaseOrPhoneContaining(query, query, pageable))
    }
}

@Service
class GeneratePhotoUploadUrlQueryImpl(
    private val s3Presigner: S3Presigner,
    @param:Value("\${crichere.s3.bucket}") private val bucketName: String
) : GeneratePhotoUploadUrlQuery {
    override fun execute(userId: UUID, extension: String): Result<Pair<String, String>, AuthDomainError> {
        val key = "profiles/$userId/photo-${System.currentTimeMillis()}.$extension"
        
        val putObjectRequest = PutObjectRequest.builder()
            .bucket(bucketName)
            .key(key)
            .build()

        val presignRequest = PutObjectPresignRequest.builder()
            .signatureDuration(Duration.ofMinutes(15))
            .putObjectRequest(putObjectRequest)
            .build()

        val presignedRequest = s3Presigner.presignPutObject(presignRequest)
        return Result.Success(Pair(presignedRequest.url().toString(), key))
    }
}
