//
//  UserProfileRepositoryImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

/// Class responsible for managing user profile-related operations.
internal class UserProfileRepositoryImpl: UserProfileRepository {
    
    private let userDataSource: UserDataSource
    private let storageFilesDataSource: StorageFilesDataSource
    private let userMapper: UserMapper
    
    /// Initializes an instance of `UserProfileRepositoryImpl`.
        /// - Parameters:
        ///   - userDataSource: The data source for user-related operations.
        ///   - storageFilesDataSource: The data source for file storage operations.
        ///   - userMapper: The mapper used to map user-related data objects.
    init(userDataSource: UserDataSource, storageFilesDataSource: StorageFilesDataSource, userMapper: UserMapper) {
        self.userDataSource = userDataSource
        self.storageFilesDataSource = storageFilesDataSource
        self.userMapper = userMapper
    }
    
    /// Updates the user profile asynchronously.
        /// - Parameters:
        ///   - userId: The ID of the user to be updated.
        ///   - fullname: The new full name of the user.
        ///   - username: The new username of the user.
        ///   - location: The new location of the user.
        ///   - bio: The new bio of the user.
        ///   - birthdate: The new birthdate of the user.
        ///   - selectedImage: The new profile image of the user as `Data`.
        /// - Returns: The updated `User` object.
        /// - Throws: An error if the operation fails.
    func updateUser(userId: String, fullname: String, username: String?, location: String?, bio: String?, birthdate: String?, selectedImage: Data?) async throws -> User {
        do {
            var profileImageUrl: String? = nil
            if let selectedImage = selectedImage {
                profileImageUrl = try await storageFilesDataSource.uploadImage(imageData: selectedImage)
            }
            let userData = try await userDataSource.updateUser(data: UpdateUserDTO(userId: userId, fullname: fullname, username: username, location: location, bio: bio, birthdate: birthdate, profileImageUrls: []))
            return userMapper.map(userData)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func createUser(data: CreateUser) async throws -> User {
        do {
            let profileImageUrls: [String] = try await data.profileImages.asyncMap {
                try await storageFilesDataSource.uploadImage(imageData: $0)
            }
            let userData = try await userDataSource.createUser(data: CreateUserDTO(userId: data.id, username: data.username, birthdate: data.birthdate, phoneNumber: data.phoneNumber, occupation: data.occupation, gender: data.gender.rawValue, preference: data.preference.rawValue, interest: data.interest.rawValue, profileImageUrls: profileImageUrls))
            return userMapper.map(userData)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Fetches user data asynchronously based on the provided user ID.
    /// - Parameter userId: The ID of the user to retrieve.
    /// - Returns: A `User` object containing the user data.
    /// - Throws: An error if the user data cannot be retrieved.
    func getUser(userId: String) async throws -> User {
        do {
            let userData = try await userDataSource.getUserById(userId: userId)
            return userMapper.map(userData)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /// Fetches user suggestions asynchronously for the provided authenticated user ID.
    /// - Parameter authUserId: The ID of the authenticated user for whom to fetch suggestions.
    /// - Returns: An array of `User` objects representing the fetched user suggestions.
    /// - Throws: An error if the user suggestions cannot be retrieved.
    func getSuggestions(authUserId: String) async throws -> [User] {
        do {
            let userData = try await userDataSource.getSuggestions(authUserId: authUserId)
            let users = userData.map { userMapper.map($0) }
            return users
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }

    /// Checks the availability of a username asynchronously.
    /// - Parameter username: The username to check for availability.
    /// - Returns: A boolean value indicating whether the username is available or not.
    /// - Throws: An error if the availability check fails.
    func checkUsernameAvailability(username: String) async throws -> Bool {
        do {
            return try await userDataSource.checkUsernameAvailability(username: username)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
