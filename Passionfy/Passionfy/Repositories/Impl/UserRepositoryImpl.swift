//
//  UserProfileRepositoryImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

/// Class responsible for managing user profile-related operations.
internal class UserRepositoryImpl: UserRepository {
    
    private let userDataSource: UserDataSource
    private let storageFilesDataSource: StorageFilesDataSource
    private let userMapper: UserMapper
    
    /// Initializes the `UserRepositoryImpl` with the required data sources and mapper.
    /// - Parameters:
    ///   - userDataSource: Data source for user-related operations.
    ///   - storageFilesDataSource: Data source for handling file storage operations.
    ///   - userMapper: Mapper to convert data source models to domain models.
    init(userDataSource: UserDataSource, storageFilesDataSource: StorageFilesDataSource, userMapper: UserMapper) {
        self.userDataSource = userDataSource
        self.storageFilesDataSource = storageFilesDataSource
        self.userMapper = userMapper
    }
    
    
    func updateUser(data: UpdateUser) async throws -> User {
        do {
            // Upload profile images if provided
            let profileImageUrls = try await uploadProfileImages(data.profileImages)

            // Create the DTO with provided information
            let updateUserDTO = UpdateUserDTO(
                userId: data.id,
                username: data.username,
                birthdate: data.birthdate,
                occupation: data.occupation,
                gender: data.gender?.rawValue,
                preference: data.preference?.rawValue,
                interest: data.interest?.rawValue,
                profileImageUrls: profileImageUrls.isEmpty ? nil : profileImageUrls,
                bio: data.bio
            )

            // Update user data in the data source
            let updatedUserData = try await userDataSource.updateUser(data: updateUserDTO)
            return userMapper.map(updatedUserData)
        } catch {
            print("Error updating user profile: \(error.localizedDescription)")
            throw error
        }
    }
    
    /// Creates a new user profile.
    /// - Parameter data: An instance of `CreateUser` containing user details.
    /// - Returns: The newly created `User` object.
    /// - Throws: An error if image upload or user creation fails.
    func createUser(data: CreateUser) async throws -> User {
        do {
            // Upload profile images if provided
            let profileImageUrls = try await uploadProfileImages(data.profileImages)

            // Create the DTO with provided information
            let createUserDTO = CreateUserDTO(
                userId: data.id,
                username: data.username,
                birthdate: data.birthdate,
                phoneNumber: data.phoneNumber,
                occupation: data.occupation,
                gender: data.gender.rawValue,
                preference: data.preference.rawValue,
                interest: data.interest.rawValue,
                profileImageUrls: profileImageUrls
            )

            // Create user data in the data source
            let createdUserData = try await userDataSource.createUser(data: createUserDTO)
            return userMapper.map(createdUserData)
        } catch {
            print("Error creating user: \(error.localizedDescription)")
            throw error
        }
    }
    
    /// Retrieves a user's data by their ID.
    /// - Parameter userId: The ID of the user to fetch.
    /// - Returns: A `User` object containing the user's data.
    /// - Throws: An error if the user cannot be found or data retrieval fails.
    func getUser(userId: String) async throws -> User {
        do {
            let userData = try await userDataSource.getUserById(userId: userId)
            return userMapper.map(userData)
        } catch UserDataSourceError.userNotFound {
            throw UserRepositoryError.userNotFound
        } catch {
            print("Error retrieving user: \(error.localizedDescription)")
            throw UserRepositoryError.invalidData
        }
    }
    

    /// Checks if a username is available.
    /// - Parameter username: The username to check.
    /// - Returns: A boolean indicating availability.
    /// - Throws: An error if the check fails.
    func checkUsernameAvailability(username: String) async throws -> Bool {
        do {
            return try await userDataSource.checkUsernameAvailability(username: username)
        } catch {
            throw UserRepositoryError.usernameCheckFailed
        }
    }
    
    /// Retrieves user suggestions based on the authenticated user's preferences.
    /// - Parameter authUserId: The ID of the authenticated user.
    /// - Returns: An array of `User` objects representing the suggested users.
    /// - Throws: An error if fetching suggestions or determining interest fails.
    func getSuggestions(authUserId: String) async throws -> [User] {
        do {
            // Fetch the authenticated user's data
            let authUserData: User
            do {
                let data = try await userDataSource.getUserById(userId: authUserId)
                authUserData = userMapper.map(data)
            } catch UserDataSourceError.userNotFound {
                throw UserRepositoryError.userNotFound
            } catch {
                throw UserRepositoryError.suggestionFetchFailed
            }
            
            // Determine the target gender and interest for matching
            guard let targetGender = determineTargetGender(for: authUserData.interest) else {
                throw UserRepositoryError.suggestionFetchFailed
            }
            let targetInterest = determineTargetInterest(for: authUserData.gender)
            
            print("getSuggestions -> authUserId: \(authUserId) - targetGender: \(targetGender) - targetInterest: \(String(describing: targetInterest))")
            
            // Fetch suggestions from the data source
            do {
                let suggestedUserData = try await userDataSource.getSuggestions(
                    authUserId: authUserId,
                    targetGender: targetGender,
                    targetInterest: targetInterest,
                    ignoredUserIds: [] // TODO: Add logic for ignored user IDs
                )
                
                print("suggestedUserData -> size: \(suggestedUserData.count)")

                // Map and return the filtered suggestions
                return suggestedUserData.map { userMapper.map($0) }
            } catch {
                throw UserRepositoryError.suggestionFetchFailed
            }
        } catch {
            print("Error fetching suggestions: \(error.localizedDescription)")
            throw error
        }
    }
    
    /// Searches for users based on a provided search term asynchronously.
    ///
    /// - Parameter searchTerm: A string representing the term to search for (e.g., username).
    /// - Returns: An array of `User` objects that match the search criteria.
    /// - Throws: An error if the search operation fails.
    func searchUsers(searchTerm: String) async throws -> [User] {
        do {
            let result = try await userDataSource.searchUsers(searchTerm: searchTerm)
            let users = result.map { userMapper.map($0) }
            return users
        } catch {
            throw UserRepositoryError.searchUsersFailed(message: error.localizedDescription)
        }
    }

    /// Determines the target gender based on the user's interest.
    /// - Parameter interest: The user's interest.
    /// - Returns: The target gender as a string, or `nil` if the interest allows all genders.
    private func determineTargetGender(for interest: Interest) -> String? {
        switch interest {
            case .men: return Gender.male.rawValue
            case .women: return Gender.female.rawValue
            case .everyone: return nil // Allow all genders
            case .nonBinary: return Gender.nonBinary.rawValue
        }
    }

    /// Determines the target interest based on the user's gender.
    /// - Parameter gender: The user's gender.
    /// - Returns: The target interest as a string, or `nil` if the gender allows all preferences.
    private func determineTargetInterest(for gender: Gender) -> String? {
        switch gender {
            case .male:
                return Interest.men.rawValue
            case .female:
                return Interest.women.rawValue
            case .nonBinary, .genderqueer, .agender, .twoSpirit, .bigender, .other, .custom:
                return Interest.everyone.rawValue // Non-binary or fluid genders might be interested in all options
        }
    }
    
    private func uploadProfileImages(_ images: [Data]?) async throws -> [String] {
        // If no images are provided, return an empty array
        guard let images = images else { return [] }
        do {
            // Upload each image and return their URLs
            return try await images.asyncMap { try await storageFilesDataSource.uploadImage(imageData: $0) }
        } catch {
            // Throw a specific error if image upload fails
            throw UserRepositoryError.imageUploadFailed
        }
    }
}
