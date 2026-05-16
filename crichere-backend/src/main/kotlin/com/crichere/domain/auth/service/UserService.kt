package com.crichere.domain.auth.service

import com.crichere.common.exception.ResourceNotFoundException
import com.crichere.domain.auth.dto.CricketProfileRequest
import com.crichere.domain.auth.entity.User
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.auth.repository.UserRepository
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import software.amazon.awssdk.services.s3.model.PutObjectRequest
import software.amazon.awssdk.services.s3.presigner.S3Presigner
import software.amazon.awssdk.services.s3.presigner.model.PutObjectPresignRequest
import java.time.Duration
import java.util.*

@Service
class UserService(
    private val userRepository: UserRepository,
    private val userLeagueMembershipRepository: com.crichere.domain.auth.repository.UserLeagueMembershipRepository,
    private val leagueRepository: com.crichere.domain.league.repository.LeagueRepository,
    private val s3Presigner: S3Presigner,
    @Value("\${crichere.s3.bucket}") private val bucketName: String
) {

    fun getUserById(id: UUID): User {
        return userRepository.findById(id).orElseThrow {
            ResourceNotFoundException("User not found", "error.user_not_found")
        }
    }

    fun getUserLeagues(userId: UUID): List<com.crichere.domain.league.entity.League> {
        val memberships = userLeagueMembershipRepository.findAllByUserId(userId)
        return memberships.map { leagueRepository.findById(it.leagueId).get() }
    }

    @Transactional
    fun updateBasicInfo(id: UUID, name: String?, email: String?) {
        val user = getUserById(id)
        user.name = name
        user.email = email
        userRepository.save(user)
    }

    @Transactional
    fun updateCricketProfile(id: UUID, request: CricketProfileRequest) {
        val user = getUserById(id)
        user.playingRole = request.playingRole ?: user.playingRole
        user.battingStyle = request.battingStyle ?: user.battingStyle
        user.bowlingStyle = request.bowlingStyle ?: user.bowlingStyle
        user.bowlingType = request.bowlingType ?: user.bowlingType
        user.experienceLevel = request.experienceLevel ?: user.experienceLevel
        user.jerseyNumber = request.jerseyNumber ?: user.jerseyNumber
        user.dateOfBirth = request.dateOfBirth ?: user.dateOfBirth
        user.gender = request.gender ?: user.gender
        user.city = request.city ?: user.city
        user.state = request.state ?: user.state
        userRepository.save(user)
    }

    @Transactional
    fun updatePhoto(id: UUID, s3Key: String) {
        val user = getUserById(id)
        user.profilePhoto = s3Key
        userRepository.save(user)
    }

    fun searchUsers(query: String, pageable: org.springframework.data.domain.Pageable): org.springframework.data.domain.Page<User> {
        return userRepository.findByNameContainingIgnoreCaseOrPhoneContaining(query, query, pageable)
    }

    fun generatePhotoUploadUrl(userId: UUID, extension: String): Pair<String, String> {
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
        return Pair(presignedRequest.url().toString(), key)
    }
    
    @Transactional
    fun createGhostPlayer(phone: String, name: String, adminUserId: UUID): User {
        val existing = userRepository.findByPhone(phone)
        if (existing != null) return existing
        
        val ghost = User(
            phone = phone,
            name = name,
            profileStatus = com.crichere.domain.auth.enums.ProfileStatus.GHOST,
            createdBy = adminUserId
        )
        return userRepository.save(ghost)
    }
}
