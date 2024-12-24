//
//  DeleteAllMessagesUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// Parameters required to delete all messages within a chat.
struct DeleteAllMessageParams {
    /// The unique identifier of the chat from which all messages will be deleted.
    let chatId: String
}

/// A use case responsible for deleting all messages in a chat.
struct DeleteAllMessageUseCase {
    
    /// The messaging repository used to interact with the messaging data source.
    let messagingRepository: MessagingRepository
    
    /// Executes the use case to delete all messages in a specific chat.
    ///
    /// This method removes all messages from the chat identified by its `chatId`.
    /// - Parameter params: A `DeleteAllMessageParams` object containing the identifier of the chat.
    /// - Throws: An error if the operation fails while deleting all messages in the `MessagingRepository`.
    func execute(params: DeleteAllMessageParams) async throws {
        try await messagingRepository.deleteAllMessages(forChatId: params.chatId)
    }
}
