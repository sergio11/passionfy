//
//  GetCurrentUserUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

/// An entity responsible for retrieving the current user's information.
struct GetCurrentUserUseCase {
    
    let authRepository: AuthenticationRepository
    let userRepository: UserRepository
    
    /// Executes the process of retrieving the information of the current user asynchronously.
        /// - Returns: The information of the current user.
        /// - Throws: An error if the user information retrieval operation fails, including `userNotFound` if the current user is not found.
    func execute() async throws -> User {
        let userId = try await authRepository.getCurrentUserId()
        return try await userRepository.getUser(userId: userId)
    }
}
