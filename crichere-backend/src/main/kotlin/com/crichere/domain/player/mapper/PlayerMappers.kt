package com.crichere.domain.player.mapper

import com.crichere.domain.player.dto.LeaguePlayerResponse
import com.crichere.domain.player.entity.LeaguePlayer

fun LeaguePlayer.toResponse(): LeaguePlayerResponse {
    return LeaguePlayerResponse(
        id = this.id,
        leagueId = this.leagueId,
        userId = this.userId,
        basePrice = this.basePrice,
        basePriceOverride = this.basePriceOverride,
        tag = this.tag,
        status = this.status,
        category = this.category,
        auctionEligible = this.auctionEligible
    )
}
