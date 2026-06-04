package com.crichere.domain.admin.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.admin.error.AdminDomainError
import com.crichere.domain.auth.entity.User
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.league.entity.League
import com.crichere.domain.league.enums.LeagueStatus
import com.crichere.domain.league.repository.LeagueRepository
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

interface AdminQueryUseCases {
    fun getUsers(profileStatus: ProfileStatus?, search: String?, pageable: Pageable): Result<Page<User>, AdminDomainError>
    fun getLeagues(status: LeagueStatus?, search: String?, pageable: Pageable): Result<Page<League>, AdminDomainError>
    fun getSubscriptions(pageable: Pageable): Result<Page<League>, AdminDomainError>
}

@Service
class AdminQueryUseCasesImpl(
    private val userRepository: UserRepository,
    private val leagueRepository: LeagueRepository
) : AdminQueryUseCases {

    @Transactional(readOnly = true)
    override fun getUsers(profileStatus: ProfileStatus?, search: String?, pageable: Pageable): Result<Page<User>, AdminDomainError> {
        val page = if (search != null) {
            userRepository.findByNameContainingIgnoreCaseOrPhoneContaining(search, search, pageable)
        } else if (profileStatus != null) {
            userRepository.findByProfileStatus(profileStatus, pageable)
        } else {
            userRepository.findAll(pageable)
        }
        return Result.Success(page)
    }

    @Transactional(readOnly = true)
    override fun getLeagues(status: LeagueStatus?, search: String?, pageable: Pageable): Result<Page<League>, AdminDomainError> {
        val page = if (search != null) {
            leagueRepository.findByNameContainingIgnoreCase(search, pageable)
        } else if (status != null) {
            leagueRepository.findByStatus(status, pageable)
        } else {
            leagueRepository.findAll(pageable)
        }
        return Result.Success(page)
    }

    @Transactional(readOnly = true)
    override fun getSubscriptions(pageable: Pageable): Result<Page<League>, AdminDomainError> {
        return Result.Success(leagueRepository.findAll(pageable))
    }
}
