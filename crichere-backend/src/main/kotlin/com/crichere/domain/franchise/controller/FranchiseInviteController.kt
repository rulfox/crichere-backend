package com.crichere.domain.franchise.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.toResponseEntity
import com.crichere.domain.franchise.dto.InviteValidationResponse
import com.crichere.domain.franchise.usecase.ValidateFranchiseInviteQuery
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/public/invites")
class FranchiseInviteController(
    private val validateFranchiseInviteQuery: ValidateFranchiseInviteQuery
) {

    @GetMapping("/validate")
    fun validateInvite(@RequestParam token: UUID): ResponseEntity<ApiResponse<InviteValidationResponse>> {
        return validateFranchiseInviteQuery.execute(token)
            .toResponseEntity()
    }
}
