//
//  ChatMessageMapper.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

class ChatMessageMapper: Mapper {
    typealias Input = MessageDTO
    typealias Output = ChatMessage
    
    func map(_ input: MessageDTO) -> ChatMessage {
        return ChatMessage(
            id: input.id,
            senderId: input.senderId,
            createdAt: input.createdAt.dateValue(),
            text: input.text,
            isRead: input.isRead
        )
    }
}
