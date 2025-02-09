//
//  UserDataSource.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

/// Protocol defining operations for managing user data.
protocol UserDataSource {
    /// Updates user data asynchronously.
    /// - Parameter data: The data of the user to be updated.
    /// - Returns: A `UserDTO` object representing the updated user.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func updateUser(data: UpdateUserDTO) async throws -> UserDTO
    
    /// Creates a new user asynchronously.
    /// - Parameter data: The data of the user to be created.
    /// - Returns: A `UserDTO` object representing the created user.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func createUser(data: CreateUserDTO) async throws -> UserDTO
    
    /// Retrieves user data from Firestore based on the provided user ID asynchronously.
    /// - Parameter userId: The ID of the user to retrieve.
    /// - Returns: A `UserDTO` object containing the user data.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func getUserById(userId: String) async throws -> UserDTO
    
    /// Retrieves user data for a list of user IDs asynchronously.
    /// - Parameter userIds: An array of user IDs to retrieve user data for.
    /// - Returns: An array of `UserDTO` objects containing the user data.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func getUserByIdList(userIds: [String]) async throws -> [UserDTO]
    
    /// Retrieves suggestions for users based on the specified gender, target interest, and a list of ignored user IDs.
    /// - Parameters:
    ///   - authUserId: The ID of the authenticated user.
    ///   - targetGender: The gender to filter suggestions.
    ///   - targetInterest: The interest to filter suggestions based on the authenticated user's gender.
    ///   - ignoredUserIds: A set of user IDs to exclude from the suggestions (e.g., matches, blocked users).
    /// - Returns: An array of `UserDTO` objects representing user suggestions.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func getSuggestions(authUserId: String, targetGender: String?, targetInterest: String?, ignoredUserIds: Set<String>) async throws -> [UserDTO]
    
    /// Checks the availability of a username asynchronously.
    /// - Parameter username: The username to check for availability.
    /// - Returns: A Boolean value indicating whether the username is available.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func checkUsernameAvailability(username: String) async throws -> Bool
    
    /// Searches for users based on a provided search term asynchronously.
    ///
    /// - Parameters:
    ///   - searchTerm: A string representing the term to search for (e.g., username).
    ///   - ignoredUserIds: A set of user IDs to exclude from the suggestions (e.g., matches, blocked users).
    /// - Returns: An array of `UserDTO` objects that match the search criteria.
    /// - Throws: An error if the search operation fails, including errors specified in `UserDataSourceError`.
    func searchUsers(searchTerm: String, ignoredUserIds: Set<String>) async throws -> [UserDTO]
}
