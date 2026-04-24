package com.crichere.domain.auth.repository

import com.crichere.domain.auth.entity.User
import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface UserRepository : JpaRepository<User, UUID> {
    fun findByPhone(phone: String): User?
    fun findByEmail(email: String): User?
    fun existsByPhone(phone: String): Boolean
}
