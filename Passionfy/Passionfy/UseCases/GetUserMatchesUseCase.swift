//
//  GetUserMatchesUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 23/12/24.
//

import Foundation

/// Enum that defines the possible errors that can occur while fetching user matches.
enum GetUserMatchesError: Error {
    /// The operation failed to fetch the user matches.
    case fetchFailed
}

/// A use case that handles the retrieval of user matches for the authenticated user.
///
/// This struct encapsulates the business logic required to fetch the matches for a specific user.
/// It depends on the `UserRepository` to fetch user matches and the `AuthenticationRepository` to identify the current authenticated user.
///
/// - Note: This use case is typically invoked from a higher-level controller or service that handles user interactions.
///
/// - Dependencies:
///   - `userRepository`: A repository responsible for handling user data operations such as retrieving user matches.
///   - `authRepository`: A repository responsible for managing authentication-related operations, including getting the current user ID.
struct GetUserMatchesUseCase {
    
    // MARK: - Properties
    
    /// The repository that handles user data operations.
    let userRepository: UserRepository
    
    /// The repository responsible for authentication-related operations.
    let authRepository: AuthenticationRepository
    
    // MARK: - Methods
    
    /// Executes the use case to fetch the current user's matches.
    ///
    /// This method retrieves the current user's ID using the `AuthenticationRepository` and then fetches the
    /// list of matches for that user using the `UserRepository`. If either the user ID retrieval or the fetching
    /// of matches fails, it throws an error.
    ///
    /// - Returns: An array of `User` objects representing the matches of the current user.
    /// - Throws: `GetUserMatchesError.fetchFailed` if the operation fails to retrieve the user ID or the user matches.
    func execute() async throws -> [User] {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw GetUserMatchesError.fetchFailed
        }
        
        do {
            return try await userRepository.getUserMatches(userId: userId)
        } catch {
            throw GetUserMatchesError.fetchFailed
        }
    }
}

