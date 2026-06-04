package com.crichere.domain.auth.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.auth.dto.CricketProfileRequest
import com.crichere.domain.auth.entity.User
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.auth.error.AuthDomainError
import com.crichere.domain.auth.repository.UserRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

interface UpdateBasicInfoUseCase {
    fun execute(userId: UUID, name: String?, email: String?): Result<Unit, AuthDomainError>
}

interface UpdateCricketProfileUseCase {
    fun execute(userId: UUID, request: CricketProfileRequest): Result<Unit, AuthDomainError>
}

interface UpdatePhotoUseCase {
    fun execute(userId: UUID, s3Key: String): Result<Unit, AuthDomainError>
}

interface CreateGhostPlayerUseCase {
    fun execute(phone: String, name: String, adminUserId: UUID): Result<User, AuthDomainError>
}

@Service
class UpdateBasicInfoUseCaseImpl(
    private val userRepository: UserRepository
) : UpdateBasicInfoUseCase {
    
    @Transactional
    override fun execute(userId: UUID, name: String?, email: String?): Result<Unit, AuthDomainError> {
        val userOpt = userRepository.findById(userId)
        if (userOpt.isEmpty) {
            return Result.Failure(AuthDomainError.UserNotFound(userId))
        }
        val user = userOpt.get()
        user.name = name ?: user.name
        user.email = email ?: user.email
        userRepository.save(user)
        return Result.Success(Unit)
    }
}

@Service
class UpdateCricketProfileUseCaseImpl(
    private val userRepository: UserRepository
) : UpdateCricketProfileUseCase {
    
    @Transactional
    override fun execute(userId: UUID, request: CricketProfileRequest): Result<Unit, AuthDomainError> {
        val userOpt = userRepository.findById(userId)
        if (userOpt.isEmpty) {
            return Result.Failure(AuthDomainError.UserNotFound(userId))
        }
        val user = userOpt.get()
        
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
        return Result.Success(Unit)
    }
}

@Service
class UpdatePhotoUseCaseImpl(
    private val userRepository: UserRepository
) : UpdatePhotoUseCase {
    
    @Transactional
    override fun execute(userId: UUID, s3Key: String): Result<Unit, AuthDomainError> {
        val userOpt = userRepository.findById(userId)
        if (userOpt.isEmpty) {
            return Result.Failure(AuthDomainError.UserNotFound(userId))
        }
        val user = userOpt.get()
        user.profilePhoto = s3Key
        userRepository.save(user)
        return Result.Success(Unit)
    }
}

@Service
class CreateGhostPlayerUseCaseImpl(
    private val userRepository: UserRepository
) : CreateGhostPlayerUseCase {
    
    @Transactional
    override fun execute(phone: String, name: String, adminUserId: UUID): Result<User, AuthDomainError> {
        val existing = userRepository.findByPhone(phone)
        if (existing != null) {
            return Result.Success(existing)
        }
        
        val ghost = User(
            phone = phone,
            name = name,
            profileStatus = ProfileStatus.GHOST,
            createdBy = adminUserId
        )
        return Result.Success(userRepository.save(ghost))
    }
}
