//
//  FirestoreUserDataSourceImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation
import Firebase
import FirebaseFirestore

/// A data source responsible for managing user data in Firestore.
internal class FirestoreUserDataSourceImpl: UserDataSource {
    
    private let usersCollection = "passionfy_users"
    
    /// Updates user data in Firestore.
    /// - Parameters:
    ///   - data: The user data to be updated.
    /// - Returns: A `UserDTO` object representing the updated user.
    /// - Throws: An error if the operation fails.
    func updateUser(data: UpdateUserDTO) async throws -> UserDTO {
        do {
            let documentReference = Firestore
                .firestore()
                .collection(usersCollection)
                .document(data.userId)
            try await documentReference.setData(data.asDictionary(), merge: true)
            return try await getUserById(userId: data.userId)
        } catch {
            print("Error updating user: \(error.localizedDescription)")
            throw UserDataSourceException.saveFailed(message: "Error updating user", cause: error)
        }
    }
    
    /// Creates a new user in Firestore with the provided user data.
    /// - Parameter data: The user data to be created.
    /// - Returns: A `UserDTO` object representing the created user.
    /// - Throws: An error if the operation fails.
    func createUser(data: CreateUserDTO) async throws -> UserDTO {
        let documentReference = Firestore
                .firestore()
                .collection(usersCollection)
                .document(data.userId)
        do {
            try await documentReference.setData(data.asDictionary())
            return try await getUserById(userId: data.userId)
        } catch {
            print("Error creating user: \(error.localizedDescription)")
            throw UserDataSourceException.saveFailed(message: "Error creating user", cause: error)
        }
    }
    
    /// Retrieves user data from Firestore based on the provided user ID.
    /// - Parameter userId: The ID of the user to retrieve.
    /// - Returns: A `UserDTO` object containing the user data.
    /// - Throws: An error if the user data is not found or the operation fails.
    func getUserById(userId: String) async throws -> UserDTO {
        do {
            let documentSnapshot = try await Firestore
                .firestore()
                .collection(usersCollection)
                .document(userId)
                .getDocument()
            guard let userData = try? documentSnapshot.data(as: UserDTO.self) else {
                throw UserDataSourceException.userNotFound(message: "User not found for ID \(userId)", cause: nil)
            }
            return userData
        } catch {
            print("Error retrieving user by ID: \(error.localizedDescription)")
            throw UserDataSourceException.userNotFound(message: "Error retrieving user data", cause: error)
        }
    }
    
    /// Retrieves user data for a list of user IDs from Firestore.
    /// - Parameter userIds: A list of user IDs to retrieve.
    /// - Returns: An array of `UserDTO` objects with the user data.
    /// - Throws: An error if the operation fails.
    func getUserByIdList(userIds: [String]) async throws -> [UserDTO] {
        do {
            let querySnapshot = try await Firestore
                .firestore()
                .collection(usersCollection)
                .whereField("userId", in: userIds)
                .getDocuments()
            var usersData: [UserDTO] = []
            for document in querySnapshot.documents {
                if let userData = try? document.data(as: UserDTO.self) {
                    usersData.append(userData)
                }
            }
            return usersData
        } catch {
            print("Error retrieving users by list: \(error.localizedDescription)")
            throw UserDataSourceException.searchFailed(message: "Failed to retrieve users by ID list", cause: error)
        }
    }
    
    /// Checks the availability of a username in Firestore.
    /// - Parameter username: The username to check for availability.
    /// - Returns: A Boolean value indicating whether the username is available.
    /// - Throws: An error if the operation fails.
    func checkUsernameAvailability(username: String) async throws -> Bool {
        do {
            let querySnapshot = try await Firestore
                .firestore()
                .collection(usersCollection)
                .whereField("username", isEqualTo: username)
                .getDocuments()
            return querySnapshot.isEmpty
        } catch {
            print("Error checking username availability: \(error.localizedDescription)")
            throw UserDataSourceException.searchFailed(message: "Error checking username availability", cause: error)
        }
    }
    
    /// Retrieves user suggestions based on the specified gender, target interest, and a list of ignored user IDs.
    /// - Parameters:
    ///   - authUserId: The ID of the authenticated user.
    ///   - targetGender: The gender to filter suggestions.
    ///   - targetInterest: The interest to filter suggestions based on the authenticated user's gender.
    ///   - ignoredUserIds: A set of user IDs to exclude from the suggestions (e.g., matches, blocked users).
    /// - Returns: An array of `UserDTO` objects representing user suggestions.
    /// - Throws: An error if the operation fails.
    func getSuggestions(authUserId: String, targetGender: String?, targetInterest: String?, ignoredUserIds: Set<String>) async throws -> [UserDTO] {
        do {
            var allIgnoredIds = ignoredUserIds
            allIgnoredIds.insert(authUserId)
            var query: Query = Firestore
                .firestore()
                .collection(usersCollection)
                .whereField("userId", notIn: Array(allIgnoredIds))
            
            if let gender = targetGender {
                query = query.whereField("gender", isEqualTo: gender)
            }
            
            if let interest = targetInterest {
                query = query.whereField("interest", isEqualTo: interest)
            }
            
            let querySnapshot = try await query.getDocuments()
            var suggestedUsers: [UserDTO] = []
            for document in querySnapshot.documents {
                if let userData = try? document.data(as: UserDTO.self) {
                    suggestedUsers.append(userData)
                }
            }
            return suggestedUsers
        } catch {
            print("Error fetching suggestions: \(error.localizedDescription)")
            throw UserDataSourceException.searchFailed(message: "Failed to fetch user suggestions", cause: error)
        }
    }
    
    /// Searches for users based on a search term in their username or full name.
    /// - Parameter searchTerm: A string representing the term to search for (e.g., username, full name).
    /// - Returns: An array of `UserDTO` objects that match the search criteria.
    /// - Throws: An error if the search operation fails.
    func searchUsers(searchTerm: String) async throws -> [UserDTO] {
        let firestore = Firestore.firestore()
        do {
            async let usernameSnapshot = firestore
                .collection(usersCollection)
                .whereField("username", isGreaterThanOrEqualTo: searchTerm)
                .whereField("username", isLessThanOrEqualTo: searchTerm + "\u{f8ff}")
                .getDocuments()
            return try await usernameSnapshot.documents.compactMap { try? $0.data(as: UserDTO.self) }
        } catch {
            print("Error searching for users: \(error.localizedDescription)")
            throw UserDataSourceException.searchFailed(message: "Failed to search for users", cause: error)
        }
    }
}
