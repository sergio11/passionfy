//
//  GetChatMessagesUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// Parameters required to retrieve messages from a specific chat.
struct GetChatMessagesParams {
    /// The unique identifier of the chat whose messages are to be retrieved.
    let chatId: String
}

/// A use case responsible for fetching messages from a specific chat.
struct GetChatMessagesUseCase {
    
    /// The messaging repository used to interact with the messaging data source.
    let messagingRepository: MessagingRepository
    
    /// Executes the use case to retrieve messages for a chat.
    ///
    /// This method fetches all messages associated with the specified chat ID from the messaging repository.
    /// - Parameter params: A `GetChatMessagesParams` object containing the identifier of the chat whose messages are to be retrieved.
    /// - Returns: An array of `ChatMessage` objects representing the messages in the specified chat.
    /// - Throws: An error if the operation fails while fetching messages from the `MessagingRepository`.
    func execute(params: GetChatMessagesParams) async throws -> [ChatMessage] {
        return try await messagingRepository.getMessages(forChatId: params.chatId)
    }
}
