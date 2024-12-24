//
//  DeleteChatUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// Parameters required to delete a specific chat.
struct DeleteChatParams {
    /// The unique identifier of the chat to be deleted.
    let chatId: String
}

/// A use case responsible for deleting a chat.
struct DeleteChatUseCase {
    
    /// The messaging repository used to interact with the messaging data source.
    let messagingRepository: MessagingRepository

    /// Executes the use case to delete a chat.
    ///
    /// This method removes the specified chat from the messaging system using the messaging repository.
    /// - Parameter params: A `DeleteChatParams` object containing the identifier of the chat to be deleted.
    /// - Throws: An error if the operation fails while deleting the chat in the `MessagingRepository`.
    func execute(params: DeleteChatParams) async throws {
        try await messagingRepository.deleteChat(chatId: params.chatId)
    }
}
