//
//  GetSuggestionsUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

/// An entity responsible for fetching user suggestions.
struct GetSuggestionsUseCase {
    let userRepository: UserRepository
    let authRepository: AuthenticationRepository
    
    /// Executes the process of fetching user suggestions asynchronously.
        /// - Returns: An array of `User` objects representing the fetched user suggestions.
        /// - Throws: An error if the user suggestions fetching operation fails.
    func execute() async throws -> [User] {
        let userId = try await authRepository.getCurrentUserId()
        return try await userRepository.getSuggestions(authUserId: userId)
    }
}
