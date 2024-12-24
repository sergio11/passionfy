//
//  SearchUsersUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import Foundation

/// Parameters required for executing a user search operation.
struct SearchUsersParams {
    /// The search term used to find users.
    let term: String
}

/// Use case responsible for searching users based on a provided term.
///
/// The `SearchUsersUseCase` orchestrates the user search operation by interacting
/// with the `UserRepository` to find users whose data matches the given search term.
/// It also handles potential errors during the search process.
struct SearchUsersUseCase {
    /// The repository responsible for user profile-related operations.
    let userRepository: UserRepository
    
    /// The repository responsible for authentication-related operations.
    let authRepository: AuthenticationRepository
    
    /// Executes the user search operation.
    ///
    /// - Parameter params: An instance of `SearchUsersParams` containing the search term.
    /// - Returns: An array of `User` objects representing the users found during the search.
    /// - Throws: If the search operation fails, providing a detailed error message.
    func execute(params: SearchUsersParams) async throws -> [User] {
        return try await userRepository.searchUsers(searchTerm: params.term)
    }
}
