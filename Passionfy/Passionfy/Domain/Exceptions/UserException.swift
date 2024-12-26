//
//  UserRepositoryError.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// Errors that can occur in the UserRepository operations.
enum UserException: Error {
    // General errors
    case userNotFound(message: String, cause: Error?)       // The requested user does not exist in the data source.
    case invalidData(message: String, cause: Error?)        // The provided data is invalid or corrupted.

    // Update user errors
    case profileUpdateFailed(message: String, cause: Error?) // The profile update operation failed.
    case imageUploadFailed(message: String, cause: Error?)   // Failed to upload the user's profile image.
    
    // Create user errors
    case userCreationFailed(message: String, cause: Error?)  // The user creation operation failed.
    
    // Username availability errors
    case usernameUnavailable(message: String, cause: Error?) // The requested username is not available.
    case usernameCheckFailed(message: String, cause: Error?) // Failed to check the username's availability.
    
    // Suggestions errors
    case suggestionFetchFailed(message: String, cause: Error?) // Failed to fetch user suggestions.
    
    /// Error when searching for users fails.
    case searchUsersFailed(message: String, cause: Error?)
    
    /// Error when a "like" or "dislike" operation fails
    case likeDislikeFailed(message: String, cause: Error?)
    
    /// Error when fetching matches fails.
    case fetchMatchesFailed(message: String, cause: Error?)
    
    /// Error when cancel match fails.
    case cancelMatchFailed(message: String, cause: Error?)
}

