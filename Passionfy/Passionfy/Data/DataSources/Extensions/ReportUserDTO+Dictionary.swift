//
//  ReportUserDTO+Dictionary.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import Foundation
import FirebaseFirestore

internal extension ReportUserDTO {
    func asDictionary() -> [String: Any] {
        return [
            "reportedId": reportedId,
            "reason": reason,
            "timestamp": Timestamp(date: Date())
        ]
    }
}

