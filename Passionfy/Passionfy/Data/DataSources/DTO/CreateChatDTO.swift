//
//  CreateChatDTO.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

internal struct CreateChatDTO: Codable {
    let chatId: String
    let firstUserId: String
    let secondUserId: String
}
