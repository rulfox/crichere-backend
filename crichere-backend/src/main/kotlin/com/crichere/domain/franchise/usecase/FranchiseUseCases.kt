package com.crichere.domain.franchise.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.franchise.dto.FranchiseUpdateRequest
import com.crichere.domain.franchise.entity.Franchise
import com.crichere.domain.franchise.error.FranchiseDomainError
import com.crichere.domain.franchise.repository.FranchiseRepository
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

interface CreateFranchiseUseCase {
    fun execute(franchise: Franchise): Result<Franchise, FranchiseDomainError>
}

@Service
class CreateFranchiseUseCaseImpl(
    private val franchiseRepository: FranchiseRepository
) : CreateFranchiseUseCase {
    @Transactional
    override fun execute(franchise: Franchise): Result<Franchise, FranchiseDomainError> {
        return Result.Success(franchiseRepository.save(franchise))
    }
}

interface GetFranchiseQuery {
    fun execute(id: UUID): Result<Franchise, FranchiseDomainError>
}

@Service
class GetFranchiseQueryImpl(
    private val franchiseRepository: FranchiseRepository
) : GetFranchiseQuery {
    @Transactional(readOnly = true)
    override fun execute(id: UUID): Result<Franchise, FranchiseDomainError> {
        val franchise = franchiseRepository.findByIdOrNull(id)
            ?: return Result.Failure(FranchiseDomainError.FranchiseNotFound(id))
        return Result.Success(franchise)
    }
}

interface UpdateFranchiseUseCase {
    fun execute(id: UUID, request: FranchiseUpdateRequest): Result<Franchise, FranchiseDomainError>
}

@Service
class UpdateFranchiseUseCaseImpl(
    private val franchiseRepository: FranchiseRepository,
    private val getFranchiseQuery: GetFranchiseQuery
) : UpdateFranchiseUseCase {
    @Transactional
    override fun execute(id: UUID, request: FranchiseUpdateRequest): Result<Franchise, FranchiseDomainError> {
        val franchiseResult = getFranchiseQuery.execute(id)
        if (franchiseResult is Result.Failure) return franchiseResult

        val franchise = (franchiseResult as Result.Success).data
        request.name?.let { franchise.name = it }
        request.logoUrl?.let { franchise.logoUrl = it }
        request.totalPurse?.let { 
            val spent = franchise.totalPurse - franchise.remainingPurse
            franchise.totalPurse = it
            franchise.remainingPurse = it - spent
        }
        return Result.Success(franchiseRepository.save(franchise))
    }
}
