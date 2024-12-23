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
    private let userMatchDataSource: UserMatchDataSource
    private let storageFilesDataSource: StorageFilesDataSource
        
    // Mappers for transforming user data between domain and data models
    private let userMapper: UserMapper
    private let createUserMapper: CreateUserMapper
    private let updateUserMapper: UpdateUserMapper
        
    /// Initializes the `UserRepositoryImpl` class with the necessary dependencies.
    ///
    /// This constructor is used to inject all the required data sources and mappers that the `UserRepositoryImpl` class needs
    /// to perform its operations. These dependencies allow the class to handle user profile updates, user creation, file uploads,
    /// user match interactions, and transformation of data between domain models and data models.
    ///
    /// - Parameters:
    ///   - userDataSource: The data source responsible for handling user-related operations, such as fetching and updating user data.
    ///   - storageFilesDataSource: The data source for managing file storage, typically for handling image uploads.
    ///   - userMatchDataSource: The data source responsible for managing user interactions like "likes" and "dislikes", and determining matches.
    ///   - userMapper: A mapper used to transform raw user data into domain objects (e.g., User objects).
    ///   - createUserMapper: A mapper used to transform data from the domain layer to the data layer when creating a new user.
    ///   - updateUserMapper: A mapper used to transform data from the domain layer to the data layer when updating an existing user's profile.

    init(
        userDataSource: UserDataSource,
        storageFilesDataSource: StorageFilesDataSource,
        userMatchDataSource: UserMatchDataSource,
        userMapper: UserMapper,
        createUserMapper: CreateUserMapper,
        updateUserMapper: UpdateUserMapper
    ) {
        self.userDataSource = userDataSource
        self.storageFilesDataSource = storageFilesDataSource
        self.userMatchDataSource = userMatchDataSource
        self.userMapper = userMapper
        self.createUserMapper = createUserMapper
        self.updateUserMapper = updateUserMapper
    }
    
    
    func updateUser(data: UpdateUser) async throws -> User {
        do {
            let profileImageUrls = try await uploadProfileImages(data.profileImages)
            let updatedUserData = try await userDataSource.updateUser(data: updateUserMapper.map(UpdateUserDataMapper(profileImageUrls: profileImageUrls, data: data)))
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
            let profileImageUrls = try await uploadProfileImages(data.profileImages)
            let createdUserData = try await userDataSource.createUser(data: createUserMapper.map(CreateUserDataMapper(profileImageUrls: profileImageUrls, data: data)))
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
    
    // Like a user and check if a match happens.
    /// - Parameters:
    ///   - userId: The ID of the user who is liking.
    ///   - targetUserId: The ID of the user being liked.
    /// - Returns: A boolean indicating whether both users have liked each other (match).
    /// - Throws: An error if the operation fails.
    func likeUser(userId: String, targetUserId: String) async throws -> Bool {
        do {
            return try await userMatchDataSource.likeUser(userId: userId, targetUserId: targetUserId)
        } catch {
            throw UserRepositoryError.likeDislikeFailed(message: "Failed to process like operation.")
        }
    }
        
    // Dislike a user.
    /// - Parameters:
    ///   - userId: The ID of the user who is disliking.
    ///   - targetUserId: The ID of the user being disliked.
    /// - Throws: An error if the operation fails.
    func dislikeUser(userId: String, targetUserId: String) async throws {
        do {
            return try await userMatchDataSource.dislikeUser(userId: userId, targetUserId: targetUserId)
        } catch {
            throw UserRepositoryError.likeDislikeFailed(message: "Failed to process dislike operation.")
        }
    }
      
    // Get the list of matches for a user.
    /// - Parameter userId: The ID of the user whose matches are to be fetched.
    /// - Returns: An array of user  that the user has matched with.
    /// - Throws: An error if the operation fails.
    func getUserMatches(userId: String) async throws -> [User] {
        do {
            let userIds = try await userMatchDataSource.getUserMatches(userId: userId)
            let userDataList = try await userDataSource.getUserByIdList(userIds: userIds)
            return userDataList.map { userMapper.map($0) }
        } catch {
            throw UserRepositoryError.fetchMatchesFailed(message: "Failed to fetch user matches.")
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
