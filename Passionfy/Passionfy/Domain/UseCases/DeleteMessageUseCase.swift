//
//  DeleteMessageUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// Parameters required to delete a specific message within a chat.
struct DeleteMessageParams {
    /// The unique identifier of the chat containing the message.
    let chatId: String
    /// The unique identifier of the message to be deleted.
    let messageId: String
}

/// A use case responsible for deleting a message from a chat.
struct DeleteMessageUseCase {
    
    /// The messaging repository used to interact with the messaging data source.
    let messagingRepository: MessagingRepository

    /// Executes the use case to delete a specific message.
    ///
    /// This method removes a message identified by its `messageId` from a specific chat identified by its `chatId`.
    /// - Parameter params: A `DeleteMessageParams` object containing the identifiers of the chat and the message to be deleted.
    /// - Throws: An error if the operation fails while deleting the message in the `MessagingRepository`.
    func execute(params: DeleteMessageParams) async throws {
        try await messagingRepository.deleteMessage(chatId: params.chatId, messageId: params.messageId)
    }
}
