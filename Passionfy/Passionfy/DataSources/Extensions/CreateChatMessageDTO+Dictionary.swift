//
//  CreateChatMessageDTO+Dictionary.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation
import FirebaseFirestore

internal extension CreateChatMessageDTO {
    func asDictionary() -> [String: Any] {
        let now = Timestamp(date: Date())
        return [
            "id": messageId,
            "senderId": senderId,
            "createdAt": now,
            "text": text,
            "isRead": false
        ]
    }
}
