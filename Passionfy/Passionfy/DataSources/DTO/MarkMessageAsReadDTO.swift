//
//  MarkMessageAsReadDTO.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

internal struct MarkMessageAsReadDTO: Codable {
    let chatId: String
    let messageId: String
}
