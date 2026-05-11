package com.crichere.domain.franchise.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.franchise.dto.InviteValidationResponse
import com.crichere.domain.franchise.service.FranchiseService
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/public/invites")
class FranchiseInviteController(
    private val franchiseService: FranchiseService
) {

    @GetMapping("/validate")
    fun validateInvite(@RequestParam token: UUID): ApiResponse<InviteValidationResponse> {
        return ResponseHelper.success(data = franchiseService.validateInvite(token))
    }
}
