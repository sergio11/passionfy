//
//  Chat.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

struct Chat : Identifiable, Decodable {
    let id: String
    let currentUser: User
    let otherUser: User
    let createdAt: Date
    let updatedAt: Date
    let unreadMessagesCount: Int
    let lastMessage: String
    let lastMessageUserId: String
}
