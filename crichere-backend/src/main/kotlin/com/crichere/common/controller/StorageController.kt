package com.crichere.common.controller

import com.crichere.common.response.ApiResponse
import com.crichere.common.response.ResponseHelper
import com.crichere.domain.auth.dto.PresignedUrlRequest
import com.crichere.domain.auth.usecase.GeneratePhotoUploadUrlQuery
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.http.HttpStatus
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/storage")
@Tag(name = "Storage")
class StorageController(private val generatePhotoUploadUrlQuery: GeneratePhotoUploadUrlQuery) {

    @PostMapping("/presigned-url")
    fun getPresignedUrl(
        @RequestBody request: PresignedUrlRequest,
        @AuthenticationPrincipal user: UserDetails
    ): ApiResponse<Map<String, String>> {
        val extension = request.fileName.substringAfterLast(".", "jpg")
        val result = generatePhotoUploadUrlQuery.execute(UUID.fromString(user.username), extension)
        return if (result is com.crichere.common.domain.Result.Success) {
            val (url, key) = result.data
            ResponseHelper.success(data = mapOf("url" to url, "s3Key" to key))
        } else {
            val error = (result as com.crichere.common.domain.Result.Failure).error
            ResponseHelper.error(HttpStatus.BAD_REQUEST.name, error.message, error.messageKey ?: "error.bad_request")
        }
    }
}
