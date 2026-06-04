package com.crichere.common.domain

/**
 * Base interface for all domain-specific errors.
 * 
 * Instead of throwing exceptions for business logic violations, Use Cases should return
 * a specific DomainError through the Result wrapper. This ensures that the caller (e.g., a Controller)
 * handles the error explicitly.
 */
interface DomainError {
    val message: String
    val messageKey: String?
}

/**
 * Common domain errors that might apply across multiple modules.
 */
sealed class CommonDomainError : DomainError {
    
    /**
     * Represents a scenario where a requested resource could not be found.
     * Maps to HTTP 404 Not Found.
     */
    data class ResourceNotFound(
        override val message: String,
        override val messageKey: String? = null
    ) : CommonDomainError()

    /**
     * Represents a scenario where the requested operation violates a business rule.
     * Maps to HTTP 400 Bad Request or 422 Unprocessable Entity.
     */
    data class BusinessRuleViolation(
        override val message: String,
        override val messageKey: String? = null
    ) : CommonDomainError()
    
    /**
     * Represents a scenario where the user is not authorized to perform the action.
     * Maps to HTTP 403 Forbidden.
     */
    data class UnauthorizedAccess(
        override val message: String,
        override val messageKey: String? = null
    ) : CommonDomainError()
}
