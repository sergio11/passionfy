//
//  AuthenticationRepositoryError.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// Enum representing errors that can occur in the `AuthenticationRepository`.
enum AuthenticationException: Error {
    /// Error indicating that sign-in failed.
    case signInFailed(message: String, cause: Error?)
    /// Error indicating that verification failed.
    case verificationFailed(message: String, cause: Error?)
    /// Error indicating that sign-out failed.
    case signOutFailed(message: String, cause: Error?)
    /// Error indicating that fetching the current user ID failed.
    case currentUserFetchFailed(message: String, cause: Error?)
    /// Error indicating that session is not valid
    case invalidSession(message: String, cause: Error?)
}
