//
//  UserProfileRepository.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

/// A repository for user profile-related operations.
protocol UserRepository {
   
    /// Updates user information asynchronously.
    /// - Parameter data: An `UpdateUser` object containing the updated user details.
    /// - Returns: A `User` object representing the updated user.
    /// - Throws: An error if the update operation fails.
    func updateUser(data: UpdateUser) async throws -> User

    /// Creates a new user asynchronously.
    /// - Parameter data: A `CreateUser` object containing the details of the new user.
    /// - Returns: A `User` object representing the created user.
    /// - Throws: An error if the user creation fails.
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
    
    /// Searches for users based on a provided search term asynchronously.
    /// - Parameter searchTerm: A string representing the term to search for (e.g., username, fullname).
    /// - Returns: An array of `UserBO` objects that match the search criteria.
    /// - Throws: An error if the search operation fails.
    func searchUsers(searchTerm: String) async throws -> [User]

    // Like a user and check if a match happens.
    /// - Parameters:
    ///   - userId: The ID of the user who is liking.
    ///   - targetUserId: The ID of the user being liked.
    /// - Returns: A boolean indicating whether both users have liked each other (match).
    /// - Throws: An error if the operation fails.
    func likeUser(userId: String, targetUserId: String) async throws -> Bool

    // Dislike a user.
    /// - Parameters:
    ///   - userId: The ID of the user who is disliking.
    ///   - targetUserId: The ID of the user being disliked.
    /// - Throws: An error if the operation fails.
    func dislikeUser(userId: String, targetUserId: String) async throws
    
    // Get the list of matches for a user.
    /// - Parameter userId: The ID of the user whose matches are to be fetched.
    /// - Returns: An array of user  that the user has matched with.
    /// - Throws: An error if the operation fails.
    func getUserMatches(userId: String) async throws -> [User]
    
    /// Cancels a match between two users by removing both users from each other's liked list.
    /// - Parameters:
    ///   - userId: The ID of the user who wants to cancel the match.
    ///   - targetUserId: The ID of the user whose match is being canceled.
    /// - Throws: An error if the operation fails.
    func cancelMatch(userId: String, targetUserId: String) async throws
}
