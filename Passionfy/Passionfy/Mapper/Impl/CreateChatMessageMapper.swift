//
//  CreateChatMessageMapper.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

class CreateChatMessageMapper: Mapper {
    typealias Input = CreateChatMessage
    typealias Output = CreateChatMessageDTO
    
    func map(_ input: CreateChatMessage) -> CreateChatMessageDTO {
        return CreateChatMessageDTO(
            messageId: input.id,
            chatId: input.chatId,
            senderId: input.senderId,
            text: input.text
        )
    }
}
