package com.crichere.domain.league.service

import com.crichere.domain.auth.entity.User
import com.crichere.domain.auth.enums.ProfileStatus
import com.crichere.domain.auth.repository.UserRepository
import com.crichere.domain.league.dto.BulkImportResponse
import com.crichere.domain.league.dto.PlayerImportRequest
import com.crichere.domain.league.repository.LeagueRepository
import com.crichere.domain.player.entity.LeaguePlayer
import com.crichere.domain.player.enums.LeaguePlayerStatus
import com.crichere.domain.player.repository.LeaguePlayerRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.UUID

@Service
class BulkImportService(
    private val userRepository: UserRepository,
    private val leaguePlayerRepository: LeaguePlayerRepository,
    private val leagueRepository: LeagueRepository,
    private val leagueService: LeagueService
) {

    @Transactional
    fun importPlayers(leagueId: UUID, playersData: List<PlayerImportRequest>): BulkImportResponse {
        val league = leagueRepository.findById(leagueId).orElseThrow { Exception("League not found") }
        
        var added = 0
        var skipped = 0
        val errors = mutableListOf<String>()

        playersData.forEach { data ->
            try {
                // 1. Check if user exists by phone
                var user = userRepository.findByPhone(data.phone)
                
                if (user == null) {
                    // Create GHOST user
                    user = userRepository.save(User(
                        phone = data.phone,
                        name = data.name,
                        profileStatus = ProfileStatus.GHOST
                    ))
                } else if (user.profileStatus == ProfileStatus.GHOST) {
                    // Update GHOST user name if provided
                    user.name = data.name
                    userRepository.save(user)
                }

                // 2. Check if already in league
                if (leaguePlayerRepository.existsByLeagueIdAndUserId(leagueId, user.id)) {
                    skipped++
                    errors.add("Player with phone ${data.phone} already in league")
                } else {
                    // 3. Create LeaguePlayer
                    leaguePlayerRepository.save(LeaguePlayer(
                        leagueId = leagueId,
                        userId = user.id,
                        basePriceOverride = data.basePrice,
                        tag = data.tag,
                        category = data.category,
                        status = LeaguePlayerStatus.APPROVED,
                        auctionEligible = true
                    ))
                    added++
                }
            } catch (e: Exception) {
                skipped++
                errors.add("Error importing ${data.phone}: ${e.message}")
            }
        }

        return BulkImportResponse(added, skipped, errors)
    }
}
