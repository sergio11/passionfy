//
//  LikeUserUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 23/12/24.
//

import Foundation

struct LikeUserParams {
    let targetUserId: String
}

enum LikeUserError: Error {
    case likeFailed
}

/// An entity responsible for handling the "like" operation for a user.
struct LikeUserUseCase {
    /// The repository responsible for user-related operations.
    let userRepository: UserRepository
    
    /// The repository responsible for authentication-related operations.
    let authRepository: AuthenticationRepository
    
    /// Executes the "like" operation asynchronously.
    /// - Parameter params: An instance of `LikeUserParams` containing the target user's ID to be liked.
    /// - Returns: A `Bool` indicating whether the like operation was successful.
    /// - Throws: An error if the "like" operation fails (e.g., fetching the current user's ID or performing the like).
    func execute(params: LikeUserParams) async throws -> Bool {
        guard let currentUserId = try await authRepository.getCurrentUserId() else {
            throw LikeUserError.likeFailed
        }
        do {
            return try await userRepository.likeUser(userId: currentUserId, targetUserId: params.targetUserId)
        } catch {
            throw LikeUserError.likeFailed
        }
    }
}

