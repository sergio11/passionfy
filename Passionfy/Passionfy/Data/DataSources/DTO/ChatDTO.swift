//
//  ChatDTO.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation
import FirebaseFirestore

internal struct ChatDTO: Identifiable, Decodable {
    let id: String
    let firstUserId: String
    let secondUserId: String
    let createdAt: Timestamp
    let updatedAt: Timestamp
    let participantIds: [String]
    let lastMessage: String
    let lastMessageUserId: String
}
