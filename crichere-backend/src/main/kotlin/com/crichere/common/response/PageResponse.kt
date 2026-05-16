package com.crichere.common.response

data class PageResponse<T>(
    val content: List<T>,
    val totalElements: Long,
    val totalPages: Int,
    val pageNumber: Int,
    val pageSize: Int
)
