//
//  ChatMapper.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

class ChatMapper: Mapper {
    typealias Input = ChatDTO
    typealias Output = Chat
    
    func map(_ input: ChatDTO) -> Chat {
        return Chat(
            id: input.id,
            firstUserId: input.firstUserId,
            secondUserId: input.secondUserId,
            createdAt: input.createdAt,
            updatedAt: input.updatedAt,
            lastMessage: input.lastMessage,
            lastMessageUserId: input.lastMessageUserId
        )
    }
}
