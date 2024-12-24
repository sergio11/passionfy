//
//  MessageDTO.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation
import FirebaseFirestore

internal struct MessageDTO: Identifiable, Codable {
    let id: String
    let senderId: String
    let createdAt: Timestamp
    let text: String
    let isRead: Bool
}
