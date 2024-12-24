//
//  CreateChatUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// Parameters required for creating a chat.
struct CreateChatParams {
    /// The ID of the target user with whom the chat will be created.
    let targetUserId: String
}

/// A use case responsible for creating a new chat between two users.
struct CreateChatUseCase {
    
    /// The repository responsible for handling messaging operations.
    let messagingRepository: MessagingRepository
    
    /// The repository responsible for authentication-related operations.
    let authRepository: AuthenticationRepository
    
    /// Executes the use case to create a new chat.
    /// - Parameter params: An instance of `CreateChatParams` containing the target user's ID.
    /// - Returns: A `String` representing the ID of the newly created chat.
    /// - Throws: An error if the operation fails, including:
    ///   - `AuthenticationException.invalidSession`: If the current user session is invalid.
    ///   - Other errors from the `MessagingRepository` or `AuthenticationRepository`.
    ///
    /// This method first retrieves the current user's ID from the authentication repository.
    /// If the user ID is successfully retrieved, it proceeds to create a new chat by
    /// invoking the messaging repository with the necessary details.
    func execute(params: CreateChatParams) async throws -> String {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw AuthenticationException.invalidSession(message: "Invalid user session", cause: nil)
        }
        return try await messagingRepository.createChat(
            data: CreateChat(
                id: UUID().uuidString,
                firstUserId: userId,
                secondUserId: params.targetUserId
            )
        )
    }
}

