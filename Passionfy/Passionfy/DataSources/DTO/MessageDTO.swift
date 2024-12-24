//
//  MessageDTO.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

internal struct MessageDTO: Identifiable, Codable {
    let id: String
    let senderId: String
    let createdAt: String
    let text: String
    let isRead: Bool
}
