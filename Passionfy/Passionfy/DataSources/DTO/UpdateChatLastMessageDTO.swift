//
//  UpdateChatLastMessageDTO.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

internal struct UpdateChatLastMessageDTO: Codable {
    let chatId: String
    let lastMessage: String
    let userId: String
}
