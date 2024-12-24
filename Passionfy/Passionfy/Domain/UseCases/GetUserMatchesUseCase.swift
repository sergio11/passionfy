//
//  GetUserMatchesUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 23/12/24.
//

import Foundation

/// A use case that handles the retrieval of user matches for the authenticated user.
///
/// This struct encapsulates the business logic required to fetch the matches for a specific user.
/// It depends on the `UserRepository` to fetch user matches and the `AuthenticationRepository` to identify the current authenticated user.
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
    func execute() async throws -> [User] {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw AuthenticationException.invalidSession(message: "Invalid user session", cause: nil)
        }
        return try await userRepository.getUserMatches(userId: userId)
    }
}

