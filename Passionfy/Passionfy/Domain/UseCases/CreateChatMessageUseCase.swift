//
//  CreateChatMessageUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 25/12/24.
//

import Foundation

struct CreateChatMessageParams {
    let chatId: String
    let text: String
}

struct CreateChatMessageUseCase {
    
    let messagingRepository: MessagingRepository
    let authRepository: AuthenticationRepository
    
    func execute(params: CreateChatMessageParams) async throws -> ChatMessage {
        let userId = try await authRepository.getCurrentUserId()
        return try await messagingRepository.sendMessage(
            data: CreateChatMessage(
                id: UUID().uuidString,
                chatId: params.chatId,
                senderId: userId,
                text: params.text
            )
        )
    }
}
