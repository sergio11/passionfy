//
//  ChatMessageMapper.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

class ChatMessageMapper: Mapper {
    typealias Input = ChatMessageDataMapper
    typealias Output = ChatMessage
    
    func map(_ input: ChatMessageDataMapper) -> ChatMessage {
        return ChatMessage(
            id: input.messageDTO.id,
            createByAuthUser: input.messageDTO.senderId == input.authUserId,
            createdAt: input.messageDTO.createdAt.dateValue(),
            text: input.messageDTO.text,
            isRead: input.messageDTO.isRead
        )
    }
}

struct ChatMessageDataMapper {
    let messageDTO: MessageDTO
    let authUserId: String
}
