//
//  CreateChatDTO+Dictionary.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation
import FirebaseFirestore

internal extension CreateChatDTO {
    func asDictionary() -> [String: Any] {
        let now = Timestamp(date: Date())
        return [
            "id": chatId,
            "firstUserId": firstUserId,
            "secondUserId": secondUserId,
            "participantIds": [firstUserId, secondUserId],
            "createdAt": now,
            "updatedAt": now
        ]
    }
}
