package com.crichere.domain.league.mapper

import com.crichere.domain.league.dto.LeagueResponse
import com.crichere.domain.league.entity.League

/**
 * Maps a League entity to a LeagueResponse DTO.
 * 
 * @param auctionIds List of auction IDs associated with this league to be included in the response.
 * @return The mapped LeagueResponse.
 */
fun League.toResponse(auctionIds: List<java.util.UUID> = emptyList()): LeagueResponse {
    return LeagueResponse(
        id = this.id,
        name = this.name,
        format = this.format,
        rulesUrl = this.rulesUrl,
        mustSellAll = this.mustSellAll,
        playerOrderMode = this.playerOrderMode,
        waitingListMode = this.waitingListMode,
        logoUrl = this.logoUrl,
        bannerUrl = this.bannerUrl,
        status = this.status,
        auctionDate = this.auctionDate,
        createdBy = this.createdBy,
        auctionIds = auctionIds
    )
}
