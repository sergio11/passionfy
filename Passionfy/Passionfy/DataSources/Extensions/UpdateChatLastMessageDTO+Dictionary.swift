//
//  UpdateChatLastMessageDTO+Dictionary.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation
import FirebaseFirestore

internal extension UpdateChatLastMessageDTO {
    func asDictionary() -> [String: Any] {
        let now = Timestamp(date: Date())
        return [
            "lastMessage": lastMessage,
            "lastMessageUserId": userId,
            "updatedAt": now
        ]
    }
}
