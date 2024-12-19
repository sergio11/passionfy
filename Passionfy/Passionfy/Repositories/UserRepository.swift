//
//  UserProfileRepository.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

/// Errors that can occur in the UserRepository operations.
enum UserRepositoryError: Error {
    // General errors
    case userNotFound        // The requested user does not exist in the data source.
    case invalidData         // The provided data is invalid or corrupted.

    // Update user errors
    case profileUpdateFailed // The profile update operation failed.
    case imageUploadFailed   // Failed to upload the user's profile image.
    
    // Create user errors
    case userCreationFailed  // The user creation operation failed.
    
    // Username availability errors
    case usernameUnavailable // The requested username is not available.
    case usernameCheckFailed // Failed to check the username's availability.
    
    // Suggestions errors
    case suggestionFetchFailed // Failed to fetch user suggestions.
}

/// A repository for user profile-related operations.
protocol UserRepository {
    /// Updates the user's profile information asynchronously.
    /// - Parameters:
    ///   - userId: The ID of the user whose profile is being updated.
    ///   - fullname: The full name of the user.
    ///   - username: The username of the user, if provided.
    ///   - location: The location of the user, if provided.
    ///   - bio: The bio of the user, if provided.
    ///   - birthdate: The birthdate of the user, if provided.
    ///   - selectedImage: The selected profile image data, if provided.
    /// - Returns: A `User` object representing the updated user profile.
    /// - Throws: An error if the profile update fails.
    func updateUser(userId: String, fullname: String, username: String?, location: String?, bio: String?, birthdate: String?, selectedImage: Data?) async throws -> User

    // Creates a new user asynchronously.
        ///
        /// This method handles the creation of a new user profile, including the upload of multiple profile images.
        /// The uploaded image URLs are saved in the user's profile.
        ///
        /// - Parameters:
        ///   - data: An instance of `CreateUser` containing the user's details, including their profile images, username,
        ///           birthdate, phone number, occupation, gender, preference, and interest.
        /// - Returns: The newly created `User` object.
        /// - Throws: An error if the operation fails, such as issues with uploading images or creating the user in the data source.
    func createUser(data: CreateUser) async throws -> User

    /// Retrieves user information asynchronously.
    /// - Parameter userId: The ID of the user to retrieve.
    /// - Returns: A `User` object representing the retrieved user.
    /// - Throws: An error if user retrieval fails.
    func getUser(userId: String) async throws -> User

    /// Checks the availability of a username asynchronously.
    /// - Parameter username: The username to check for availability.
    /// - Returns: A boolean value indicating whether the username is available or not.
    /// - Throws: An error if the availability check fails.
    func checkUsernameAvailability(username: String) async throws -> Bool

    /// Fetches user suggestions for the specified authenticated user asynchronously.
    /// - Parameter authUserId: The ID of the authenticated user for whom to fetch suggestions.
    /// - Returns: An array of `User` objects representing user suggestions.
    /// - Throws: An error if suggestion retrieval fails.
    func getSuggestions(authUserId: String) async throws -> [User]
}
