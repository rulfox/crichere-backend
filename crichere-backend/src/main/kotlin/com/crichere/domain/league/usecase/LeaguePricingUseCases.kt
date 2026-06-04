package com.crichere.domain.league.usecase

import com.crichere.common.domain.Result
import com.crichere.domain.league.dto.CategoryPriceRequest
import com.crichere.domain.league.dto.TagPriceRequest
import com.crichere.domain.league.entity.LeagueCategoryBasePrice
import com.crichere.domain.league.entity.LeagueTagBasePrice
import com.crichere.domain.league.enums.LeagueStatus
import com.crichere.domain.league.error.LeagueDomainError
import com.crichere.domain.league.repository.LeagueCategoryBasePriceRepository
import com.crichere.domain.league.repository.LeagueTagBasePriceRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

interface UpdateCategoryPricesUseCase {
    fun execute(leagueId: UUID, prices: List<CategoryPriceRequest>): Result<List<LeagueCategoryBasePrice>, LeagueDomainError>
}

@Service
class UpdateCategoryPricesUseCaseImpl(
    private val getLeagueQuery: GetLeagueQuery,
    private val categoryPriceRepository: LeagueCategoryBasePriceRepository
) : UpdateCategoryPricesUseCase {
    @Transactional
    override fun execute(leagueId: UUID, prices: List<CategoryPriceRequest>): Result<List<LeagueCategoryBasePrice>, LeagueDomainError> {
        val leagueResult = getLeagueQuery.execute(leagueId)
        if (leagueResult is Result.Failure) return leagueResult

        val league = (leagueResult as Result.Success).data
        if (league.status != LeagueStatus.DRAFT && league.status != LeagueStatus.OPEN) {
            return Result.Failure(LeagueDomainError.InvalidLeagueStatusForPriceUpdate)
        }

        val existing = categoryPriceRepository.findByLeagueId(leagueId)
        categoryPriceRepository.deleteAll(existing)

        val newPrices = prices.map { 
            LeagueCategoryBasePrice(leagueId = leagueId, category = it.category, price = it.price)
        }
        return Result.Success(categoryPriceRepository.saveAll(newPrices))
    }
}

interface GetCategoryPricesQuery {
    fun execute(leagueId: UUID): Result<List<LeagueCategoryBasePrice>, LeagueDomainError>
}

@Service
class GetCategoryPricesQueryImpl(
    private val categoryPriceRepository: LeagueCategoryBasePriceRepository
) : GetCategoryPricesQuery {
    @Transactional(readOnly = true)
    override fun execute(leagueId: UUID): Result<List<LeagueCategoryBasePrice>, LeagueDomainError> {
        return Result.Success(categoryPriceRepository.findByLeagueId(leagueId))
    }
}

interface UpdateTagPricesUseCase {
    fun execute(leagueId: UUID, prices: List<TagPriceRequest>): Result<List<LeagueTagBasePrice>, LeagueDomainError>
}

@Service
class UpdateTagPricesUseCaseImpl(
    private val getLeagueQuery: GetLeagueQuery,
    private val tagPriceRepository: LeagueTagBasePriceRepository
) : UpdateTagPricesUseCase {
    @Transactional
    override fun execute(leagueId: UUID, prices: List<TagPriceRequest>): Result<List<LeagueTagBasePrice>, LeagueDomainError> {
        val leagueResult = getLeagueQuery.execute(leagueId)
        if (leagueResult is Result.Failure) return leagueResult

        val league = (leagueResult as Result.Success).data
        if (league.status != LeagueStatus.DRAFT && league.status != LeagueStatus.OPEN) {
            return Result.Failure(LeagueDomainError.InvalidLeagueStatusForPriceUpdate)
        }

        val existing = tagPriceRepository.findByLeagueId(leagueId)
        tagPriceRepository.deleteAll(existing)

        val newPrices = prices.map { 
            LeagueTagBasePrice(leagueId = leagueId, tag = it.tag, price = it.price)
        }
        return Result.Success(tagPriceRepository.saveAll(newPrices))
    }
}

interface GetTagPricesQuery {
    fun execute(leagueId: UUID): Result<List<LeagueTagBasePrice>, LeagueDomainError>
}

@Service
class GetTagPricesQueryImpl(
    private val tagPriceRepository: LeagueTagBasePriceRepository
) : GetTagPricesQuery {
    @Transactional(readOnly = true)
    override fun execute(leagueId: UUID): Result<List<LeagueTagBasePrice>, LeagueDomainError> {
        return Result.Success(tagPriceRepository.findByLeagueId(leagueId))
    }
}
