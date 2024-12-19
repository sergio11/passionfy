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
    
    /// Saves user data to Firestore.
        /// - Parameters:
        ///   - data: The data of the user to be saved.
        /// - Returns: A `UserDTO` object representing the saved user.
        /// - Throws: An error if the operation fails.
    func updateUser(data: UpdateUserDTO) async throws -> UserDTO {
        let documentReference = Firestore
            .firestore()
            .collection(usersCollection)
            .document(data.userId)
        do {
            // Save user data to Firestore
            try await documentReference.setData(data.asDictionary(), merge: true)
            // Return the saved user data by fetching it from Firestore
            return try await getUserById(userId: data.userId)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Creates a new user in Firestore with the provided user data.
    /// - Parameter data: The data of the user to be created.
    /// - Returns: A `UserDTO` object representing the created user.
    /// - Throws: An error if the operation fails.
    func createUser(data: CreateUserDTO) async throws -> UserDTO {
        let documentReference = Firestore
                .firestore()
                .collection(usersCollection)
                .document(data.userId)
        do {
            // Save user data to Firestore
            try await documentReference.setData(data.asDictionary())
            // Return the saved user data by fetching it from Firestore
            return try await getUserById(userId: data.userId)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Retrieves user data from Firestore based on the provided user ID.
        /// - Parameter userId: The ID of the user to retrieve.
        /// - Returns: A `UserDTO` object containing the user data.
        /// - Throws: An error if the user data is not found or if the operation fails.
    func getUserById(userId: String) async throws -> UserDTO {
        let documentSnapshot = try await Firestore
            .firestore()
            .collection(usersCollection)
            .document(userId)
            .getDocument()
        // Attempt to decode the document data into a UserDTO object
        guard let userData = try? documentSnapshot.data(as: UserDTO.self) else {
            throw UserDataSourceError.userNotFound
        }
        return userData
    }
    
    /// Retrieves user data for a list of user IDs asynchronously.
    /// - Parameter userIds: An array of user IDs to retrieve user data for.
    /// - Returns: An array of `UserDTO` objects containing the user data.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func getUserByIdList(userIds: [String]) async throws -> [UserDTO] {
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
    }
    
    /// Checks the availability of a username asynchronously.
    /// - Parameter username: The username to check for availability.
    /// - Returns: A Boolean value indicating whether the username is available.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func checkUsernameAvailability(username: String) async throws -> Bool {
        let querySnapshot = try await Firestore
            .firestore()
            .collection(usersCollection)
            .whereField("username", isEqualTo: username)
            .getDocuments()
        return querySnapshot.isEmpty
    }
    
    /// Retrieves suggestions for users based on the specified gender, target interest, and a list of ignored user IDs.
    /// - Parameters:
    ///   - authUserId: The ID of the authenticated user.
    ///   - targetGender: The gender to filter suggestions.
    ///   - targetInterest: The interest to filter suggestions based on the authenticated user's gender.
    ///   - ignoredUserIds: A set of user IDs to exclude from the suggestions (e.g., matches, blocked users).
    /// - Returns: An array of `UserDTO` objects representing user suggestions.
    /// - Throws: An error if the operation fails, including errors specified in `UserDataSourceError`.
    func getSuggestions(authUserId: String, targetGender: String?, targetInterest: String?, ignoredUserIds: Set<String>) async throws -> [UserDTO] {
       
        let documentSnapshot = try await Firestore
            .firestore()
            .collection(usersCollection)
            .document(authUserId)
            .getDocument()
        
        guard let authUserData = try? documentSnapshot.data(as: UserDTO.self) else {
            throw UserDataSourceError.userNotFound
        }
        
        // Combine ignoredUserIds with the authenticated user's ID to exclude them all
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
    }
}
