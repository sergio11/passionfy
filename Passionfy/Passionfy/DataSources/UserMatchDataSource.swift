//
//  UserMatchDataSource.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 23/12/24.
//

import Foundation

/// Enum representing errors that can occur in the `UserMatchDataSource`.
enum UserMatchDataSourceError: Error {
    
    /// Error indicating that the like operation failed.
    case likeUserFailed(message: String)
    
    /// Error indicating that the dislike operation failed.
    case dislikeUserFailed(message: String)
}

/// Protocol defining the data source for managing user match interactions.
protocol UserMatchDataSource {
    
    /// Adds a like for a user and checks if both users have made a match.
    /// - Parameters:
    ///   - userId: The ID of the user who is liking.
    ///   - targetUserId: The ID of the user being liked.
    /// - Returns: A Boolean indicating whether both users have made a match.
    /// - Throws: An error if the operation fails.
    func likeUser(userId: String, targetUserId: String) async throws -> Bool
    
    /// Adds a dislike for a user.
    /// - Parameters:
    ///   - userId: The ID of the user who is disliking.
    ///   - targetUserId: The ID of the user being disliked.
    /// - Throws: An error if the operation fails.
    func dislikeUser(userId: String, targetUserId: String) async throws
    
    /// Checks if two users have made a match by checking if both have liked each other.
    /// - Parameters:
    ///   - userId: The ID of the first user.
    ///   - targetUserId: The ID of the second user.
    /// - Returns: A Boolean indicating whether both users have liked each other (match).
    /// - Throws: An error if the operation fails.
    func hasMatchBetween(userId: String, targetUserId: String) async throws -> Bool
    
    /// Retrieves the list of user IDs that the specified user has liked.
    /// - Parameter userId: The ID of the user whose likes are to be retrieved.
    /// - Returns: A list of user IDs that the user has liked.
    /// - Throws: An error if the operation fails.
    func getUserLikes(userId: String) async throws -> [String]
    
    /// Retrieves the list of user IDs that the specified user has disliked.
    /// - Parameter userId: The ID of the user whose dislikes are to be retrieved.
    /// - Returns: A list of user IDs that the user has disliked.
    /// - Throws: An error if the operation fails.
    func getUserDislikes(userId: String) async throws -> [String]
    
    /// Retrieves the list of user IDs who have matched with the specified user.
    /// - Parameter userId: The ID of the user whose matches are to be retrieved.
    /// - Returns: A list of user IDs that the user has matched with.
    /// - Throws: An error if the operation fails.
    func getUserMatches(userId: String) async throws -> [String]
}


