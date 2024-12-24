//
//  UserDataSourceError.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// Enum representing errors that can occur in the `UserDataSource`.
enum UserDataSourceException: Error {
    /// Error indicating that saving user data failed.
    case saveFailed(message: String, cause: Error?)
    /// Error indicating that the user was not found.
    case userNotFound(message: String, cause: Error?)
    /// Error indicating that the provided user ID is invalid.
    case invalidUserId(message: String, cause: Error?)
    /// Error indicating that the search operation failed.
    case searchFailed(message: String, cause: Error?)
}
