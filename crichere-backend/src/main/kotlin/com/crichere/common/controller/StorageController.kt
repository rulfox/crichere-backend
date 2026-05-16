package com.crichere.common.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.auth.dto.PresignedUrlRequest
import com.crichere.domain.auth.service.UserService
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/storage")
@Tag(name = "Storage")
class StorageController(private val userService: UserService) {

    @PostMapping("/presigned-url")
    fun getPresignedUrl(
        @RequestBody request: PresignedUrlRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Map<String, String>> {
        val extension = request.fileName.substringAfterLast(".", "jpg")
        val (url, key) = userService.generatePhotoUploadUrl(UUID.fromString(user.username), extension)
        return ResponseHelper.success(data = mapOf("url" to url, "s3Key" to key))
    }
}
