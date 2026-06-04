package com.crichere.common.domain

/**
 * A sealed class representing the outcome of a business use case.
 * It forces the calling layer (e.g., controllers) to explicitly handle both Success and Failure paths,
 * preventing exceptions from being used for expected business logic control flow.
 */
sealed class Result<out T, out E : DomainError> {
    data class Success<out T>(val data: T) : Result<T, Nothing>()
    data class Failure<out E : DomainError>(val error: E) : Result<Nothing, E>()

    /**
     * Executes the given [action] if this is a [Success].
     * Returns this [Result] for chaining.
     */
    inline fun onSuccess(action: (T) -> Unit): Result<T, E> {
        if (this is Success) action(data)
        return this
    }

    /**
     * Executes the given [action] if this is a [Failure].
     * Returns this [Result] for chaining.
     */
    inline fun onFailure(action: (E) -> Unit): Result<T, E> {
        if (this is Failure) action(error)
        return this
    }

    /**
     * Maps the data of a [Success] to a new type using the given [transform] function.
     * If this is a [Failure], the error is returned unmodified.
     */
    inline fun <R> map(transform: (T) -> R): Result<R, E> {
        return when (this) {
            is Success -> Success(transform(data))
            is Failure -> this
        }
    }

    /**
     * Transforms this [Result] into another value using [onSuccess] if it's a [Success],
     * or [onFailure] if it's a [Failure].
     */
    inline fun <R> fold(onSuccess: (T) -> R, onFailure: (E) -> R): R {
        return when (this) {
            is Success -> onSuccess(data)
            is Failure -> onFailure(error)
        }
    }
}
