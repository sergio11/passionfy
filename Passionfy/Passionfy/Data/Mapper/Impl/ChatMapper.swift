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
        
        let currentUser = input.authUserId == input.firstUserDTO.userId ?
            userMapper.map(input.firstUserDTO) : userMapper.map(input.secondUserDTO)
        
        let otherUser = input.authUserId != input.firstUserDTO.userId ?
        userMapper.map(input.firstUserDTO) : userMapper.map(input.secondUserDTO)
        
        return Chat(
            id: input.chatDTO.id,
            currentUser: currentUser,
            otherUser: otherUser,
            createdAt: input.chatDTO.createdAt.dateValue(),
            updatedAt: input.chatDTO.updatedAt.dateValue(),
            unreadMessagesCount: input.unreadMessageCount,
            lastMessage: input.chatDTO.lastMessage,
            lastMessageUserId: input.chatDTO.lastMessageUserId
        )
    }
}

struct ChatDataMapper {
    let chatDTO: ChatDTO
    let firstUserDTO: UserDTO
    let secondUserDTO: UserDTO
    let authUserId: String
    let unreadMessageCount: Int
}
