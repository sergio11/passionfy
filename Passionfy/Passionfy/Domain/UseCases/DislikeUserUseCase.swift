//
//  DislikeUserUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 23/12/24.
//

import Foundation

struct DislikeUserParams {
    let targetUserId: String
}

/// An entity responsible for handling the "dislike" operation for a user.
struct DislikeUserUseCase {
    /// The repository responsible for user-related operations.
    let userRepository: UserRepository
    
    /// The repository responsible for authentication-related operations.
    let authRepository: AuthenticationRepository
    
    /// Executes the "like" operation asynchronously.
    /// - Parameter params: An instance of `LikeUserParams` containing the target user's ID to be liked.
    /// - Throws: An error if the "like" operation fails (e.g., fetching the current user's ID or performing the like).
    func execute(params: DislikeUserParams) async throws -> Void {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw AuthenticationException.invalidSession(message: "Invalid user session", cause: nil)
        }
        try await userRepository.dislikeUser(userId: userId, targetUserId: params.targetUserId)
    }
}
