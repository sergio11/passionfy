//
//  Chat.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

struct Chat : Identifiable, Decodable {
    let id: String
    let firstUser: User
    let secondUser: User
    let createdAt: Date
    let updatedAt: Date
    let lastMessage: String?
    let lastMessageUserId: String?
}
