//
//  GetUserChatsUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// A use case responsible for retrieving the list of chats for the currently authenticated user.
struct GetUserChatsUseCase {
    
    /// The messaging repository used to fetch chat information.
    let messagingRepository: MessagingRepository
    
    /// The authentication repository used to retrieve the current user's authentication details.
    let authRepository: AuthenticationRepository
    
    /// Executes the use case to retrieve the chats for the authenticated user.
    ///
    /// This method first checks if there is a valid session for the current user.
    /// If a session exists, it fetches the list of chats associated with the user's ID.
    /// - Returns: An array of `Chat` objects representing the user's active chats.
    /// - Throws: An error in the following cases:
    ///   - The user is not authenticated, resulting in an `AuthenticationException.invalidSession`.
    ///   - Any error that occurs while fetching chats from the `MessagingRepository`.
    func execute() async throws -> [Chat] {
        guard let userId = try await authRepository.getCurrentUserId() else {
            throw AuthenticationException.invalidSession(message: "Invalid user session", cause: nil)
        }
        return try await messagingRepository.getChats(forUserId: userId)
    }
}
