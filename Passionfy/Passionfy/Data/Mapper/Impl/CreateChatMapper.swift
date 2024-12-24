//
//  CreateChatMapper.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

class CreateChatMapper: Mapper {
    typealias Input = CreateChat
    typealias Output = CreateChatDTO
    
    func map(_ input: CreateChat) -> CreateChatDTO {
        return CreateChatDTO(
            chatId: input.id,
            firstUserId: input.firstUserId,
            secondUserId: input.secondUserId
        )
    }
}
