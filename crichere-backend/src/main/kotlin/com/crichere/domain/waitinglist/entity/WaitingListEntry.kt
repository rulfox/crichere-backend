package com.crichere.domain.waitinglist.entity

import com.crichere.domain.waitinglist.enums.WaitingListStatus
import com.crichere.domain.waitinglist.enums.WaitingListType
import jakarta.persistence.*
import java.time.Instant
import java.util.*

@Entity
@Table(name = "waiting_list_entries")
class WaitingListEntry(
    @Id
    val id: UUID = UUID.randomUUID(),

    @Column(name = "league_id", nullable = false)
    val leagueId: UUID,

    @Column(name = "user_id", nullable = false)
    val userId: UUID,

    @Column(name = "franchise_id")
    val franchiseId: UUID? = null,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    val type: WaitingListType,

    @Column(nullable = false)
    var position: Int,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    var status: WaitingListStatus = WaitingListStatus.WAITING,

    @Column(nullable = false, updatable = false)
    val createdAt: Instant = Instant.now(),

    @Column(name = "promoted_at")
    var promotedAt: Instant? = null
)
