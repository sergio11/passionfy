//
//  ChatMapper.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

class ChatMapper: Mapper {
    typealias Input = ChatDataMapper
    typealias Output = Chat
    
    let userMapper: UserMapper
    
    init(userMapper: UserMapper) {
        self.userMapper = userMapper
    }
    
    func map(_ input: ChatDataMapper) -> Chat {
        return Chat(
            id: input.chatDTO.id,
            firstUser: userMapper.map(input.firstUserDTO),
            secondUser: userMapper.map(input.secondUserDTO),
            createdAt: input.chatDTO.createdAt.dateValue(),
            updatedAt: input.chatDTO.updatedAt.dateValue(),
            lastMessage: input.chatDTO.lastMessage,
            lastMessageUserId: input.chatDTO.lastMessageUserId
        )
    }
}

struct ChatDataMapper {
    let chatDTO: ChatDTO
    let firstUserDTO: UserDTO
    let secondUserDTO: UserDTO
}
