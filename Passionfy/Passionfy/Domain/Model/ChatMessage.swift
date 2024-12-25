//
//  ChatMessage.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

struct ChatMessage: Identifiable, Codable {
    let id: String
    let createByAuthUser: Bool
    let createdAt: Date
    let text: String
    let isRead: Bool
}
