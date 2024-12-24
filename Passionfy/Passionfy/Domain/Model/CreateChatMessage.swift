//
//  CreateChatMessage.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

internal struct CreateChatMessage: Identifiable {
    let id: String
    let chatId: String
    let senderId: String
    let text: String
}
