//
//  UserProfileRepositoryImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

/// Class responsible for managing user profile-related operations.
///
/// This class provides functionality to handle various user profile operations such as creating a new user,
/// updating user information, uploading files (e.g., profile pictures), managing user matches, reporting users,
/// and performing authentication-related tasks. It interacts with multiple data sources for handling different aspects
/// of the user profile system, including user data, file storage, user matching, and messaging.
///
/// The class also uses mappers to transform data between domain models and data models.
internal class UserRepositoryImpl: UserRepository {
    
    // MARK: - Properties

    /// The data source responsible for handling user-related operations, such as fetching and updating user data.
    private let userDataSource: UserDataSource
    
    /// The data source for managing file storage, typically for handling image uploads (e.g., profile pictures).
    private let storageFilesDataSource: StorageFilesDataSource
    
    /// The data source for managing reported users.
    private let reportedUsersDataSource: ReportedUsersDataSource
    
    /// The data source for performing authentication-related operations, such as login and registration.
    private let authDataSource: AuthenticationDataSource
    
    /// The data source responsible for managing user interactions like "likes", "dislikes", and determining matches.
    private let userMatchDataSource: UserMatchDataSource
    
    /// The data source for handling messaging-related tasks (e.g., chats and messages).
    private let messagingDataSource: MessagingDataSource

    // MARK: - Mappers

    /// A mapper used to transform raw user data into domain objects (e.g., `User` objects).
    private let userMapper: UserMapper
    
    /// A mapper used to transform data from the domain layer to the data layer when creating a new user.
    private let createUserMapper: CreateUserMapper
    
    /// A mapper used to transform data from the domain layer to the data layer when updating an existing user's profile.
    private let updateUserMapper: UpdateUserMapper
    
    // MARK: - Initializer

    /// Initializes the `UserRepositoryImpl` class with the necessary dependencies.
    ///
    /// This constructor is used to inject all the required data sources and mappers that the `UserRepositoryImpl` class needs
    /// to perform its operations. These dependencies allow the class to handle user profile updates, user creation, file uploads,
    /// user match interactions, and transformation of data between domain models and data models.
    ///
    /// - Parameters:
    ///   - userDataSource: The data source responsible for handling user-related operations, such as fetching and updating user data.
    ///   - storageFilesDataSource: The data source for managing file storage, typically for handling image uploads.
    ///   - reportedUsersDataSource: The data source for reported users.
    ///   - authDataSource: The data source for performing auth-related operations.
    ///   - userMatchDataSource: The data source responsible for managing user interactions like "likes" and "dislikes", and determining matches.
    ///   - userMapper: A mapper used to transform raw user data into domain objects (e.g., `User` objects).
    ///   - createUserMapper: A mapper used to transform data from the domain layer to the data layer when creating a new user.
    ///   - updateUserMapper: A mapper used to transform data from the domain layer to the data layer when updating an existing user's profile.
    init(
        userDataSource: UserDataSource,
        storageFilesDataSource: StorageFilesDataSource,
        reportedUsersDataSource: ReportedUsersDataSource,
        authDataSource: AuthenticationDataSource,
        userMatchDataSource: UserMatchDataSource,
        messagingDataSource: MessagingDataSource,
        userMapper: UserMapper,
        createUserMapper: CreateUserMapper,
        updateUserMapper: UpdateUserMapper
    ) {
        self.userDataSource = userDataSource
        self.storageFilesDataSource = storageFilesDataSource
        self.reportedUsersDataSource = reportedUsersDataSource
        self.authDataSource = authDataSource
        self.messagingDataSource = messagingDataSource
        self.userMatchDataSource = userMatchDataSource
        self.userMapper = userMapper
        self.createUserMapper = createUserMapper
        self.updateUserMapper = updateUserMapper
    }
    
    
    /// Updates the user's profile with new data, including uploading profile images and obtaining their corresponding URLs.
    /// The method processes an array of profile image data along with their index, uploads the images, and associates the URLs with the respective indices.
    /// It then updates the user's profile with the new information, including the URLs of the uploaded images.
    ///
    /// - Parameter data: The `UpdateUser` object containing the new user data to be updated, including profile image data and other user details.
    /// - Returns: A `User` object representing the updated user profile with the uploaded profile image URLs.
    /// - Throws: An error if either the image upload or the user update process fails. The error will contain information about the failure, such as network issues or invalid data.
    func updateUser(data: UpdateUser) async throws -> User {
        do {
            let userData = try await userDataSource.getUserById(userId: data.id)
            let currentProfileImageUrls = userData.profileImageUrls.enumerated().map { (index, image) in
                (index, image)
            }
            var newProfileImageUrls: [(Int, String)]? = nil
            if let profileImages = data.profileImages {
                newProfileImageUrls = try await uploadProfileImagesWithIndices(profileImages)
            }
            
            let updateUserDataMapper = UpdateUserDataMapper(
                currentProfileImageUrls: currentProfileImageUrls,
                newProfileImageUrls: newProfileImageUrls,
                data: data
            )
            
            let updatedUserDTO = updateUserMapper.map(updateUserDataMapper)
            let updatedUserData = try await userDataSource.updateUser(data: updatedUserDTO)
            
            return userMapper.map(updatedUserData)
            
        } catch {
            print("Error updating user profile: \(error.localizedDescription)")
            throw UserException.profileUpdateFailed(message: "Error updating user profile", cause: error)
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
            throw UserException.userCreationFailed(message: "Error creating user", cause: error)
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
        } catch UserDataSourceException.userNotFound(let message, let cause) {
            throw UserException.userNotFound(message: "User not found - \(message)", cause: cause)
        } catch {
            print("Error retrieving user: \(error.localizedDescription)")
            throw UserException.invalidData(message: "Error retrieving user", cause: error)
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
            throw UserException.usernameCheckFailed(message: "An error ocurred while checking the username availability", cause: error)
        }
    }
    
    /// Retrieves user suggestions based on the authenticated user's preferences.
    /// - Parameter authUserId: The ID of the authenticated user.
    /// - Returns: An array of `User` objects representing the suggested users.
    /// - Throws: An error if fetching suggestions or determining interest fails.
    func getSuggestions(authUserId: String) async throws -> [User] {
        do {
            // Fetch users reported by the authenticated user
            let reportedUsers = try await reportedUsersDataSource.getUsersReportedBy(userId: authUserId)
            // Fetch users who have reported the authenticated user
            let blockedBy = try await reportedUsersDataSource.getUsersWhoReported(userId: authUserId)
            
            // Fetch the authenticated user's data
            let data = try await userDataSource.getUserById(userId: authUserId)
            let authUserData = userMapper.map(data)
            
            // Fetch the user's matches
            let userMatches = try await userMatchDataSource.getUserMatches(userId: authUserId)
        
            let ignoredUserIds = Set(reportedUsers + blockedBy + userMatches)
            
            // Determine the target gender and interest for matching
            guard let targetGender = determineTargetGender(for: authUserData.interest) else {
                throw UserException.suggestionFetchFailed(message: "Error determining target gender", cause: nil)
            }
            let targetInterest = determineTargetInterest(for: authUserData.gender)
            
            let suggestedUserData = try await userDataSource.getSuggestions(
                authUserId: authUserId,
                targetGender: targetGender,
                targetInterest: targetInterest,
                ignoredUserIds: ignoredUserIds
            )
            return suggestedUserData.map { userMapper.map($0) }
            
        } catch {
            print("Error fetching suggestions: \(error.localizedDescription)")
            throw UserException.suggestionFetchFailed(message: "Error fetching suggestions", cause: error)
        }
    }
    
    /// Searches for users based on a provided search term asynchronously.
    ///
    /// - Parameter searchTerm: A string representing the term to search for (e.g., username).
    /// - Returns: An array of `User` objects that match the search criteria.
    /// - Throws: An error if the search operation fails.
    func searchUsers(searchTerm: String) async throws -> [User] {
        do {
            let authUserId = try await authDataSource.getCurrentUserId()
            let reportedUsers = try await reportedUsersDataSource.getUsersReportedBy(userId: authUserId)
            let blockedBy = try await reportedUsersDataSource.getUsersWhoReported(userId: authUserId)
            let ignoredUserIds = Set(reportedUsers + blockedBy + [authUserId])
            let result = try await userDataSource.searchUsers(
                searchTerm: searchTerm,
                ignoredUserIds: ignoredUserIds
            )
            return result.map { userMapper.map($0) }
        } catch {
            throw UserException.searchUsersFailed(message: "An error ocurred when trying to search users", cause: error)
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
            throw UserException.likeDislikeFailed(message: "Failed to process like operation.", cause: error)
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
            throw UserException.likeDislikeFailed(message: "Failed to process dislike operation.", cause: error)
        }
    }
      
    // Get the list of matches for a user.
    /// - Parameter userId: The ID of the user whose matches are to be fetched.
    /// - Returns: An array of user  that the user has matched with.
    /// - Throws: An error if the operation fails.
    func getUserMatches(userId: String) async throws -> [User] {
        do {
            let userIds = try await userMatchDataSource.getUserMatches(userId: userId)
            if !userIds.isEmpty {
                let userDataList = try await userDataSource.getUserByIdList(userIds: userIds)
                return userDataList.map { userMapper.map($0) }
            } else {
                return []
            }
        } catch {
            throw UserException.fetchMatchesFailed(message: "Failed to fetch user matches.", cause: error)
        }
    }
    
    /// Cancels a match between two users by removing both users from each other's liked list.
    /// - Parameters:
    ///   - userId: The ID of the user who wants to cancel the match.
    ///   - targetUserId: The ID of the user whose match is being canceled.
    /// - Throws: An error if the operation fails.
    func cancelMatch(userId: String, targetUserId: String) async throws {
        do {
            try await userMatchDataSource.cancelMatch(userId: userId, targetUserId: targetUserId)
            try await messagingDataSource.deleteChatAndMessages(forUserId: userId, targetUserId: targetUserId)
        } catch {
            throw UserException.cancelMatchFailed(message: "Failed to cancel match.", cause: error)
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
            throw UserException.imageUploadFailed(message: "An error ocurred when trying to upload profile image", cause: error)
        }
    }
    
    private func uploadProfileImagesWithIndices(_ images: [(Int, Data)]) async throws -> [(Int, String)] {
        // If no images are provided, return an empty array
        guard !images.isEmpty else { return [] }
        
        do {
            // Upload each image and return their URLs along with the original indices
            let uploadedImageUrls = try await images.asyncMap { (index, imageData) in
                let imageUrl = try await storageFilesDataSource.uploadImage(imageData: imageData)
                return (index, imageUrl)
            }
            
            return uploadedImageUrls
        } catch {
            throw UserException.imageUploadFailed(message: "An error ocurred when trying to upload profile image", cause: error)
        }
    }
}
