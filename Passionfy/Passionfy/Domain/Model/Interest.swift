//
//  Interest.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 13/12/24.
//

import Foundation

enum Interest: String, CaseIterable, Decodable {
    case men = "Men"
    case women = "Women"
    case everyone = "Everyone"
    case nonBinary = "Non-binary People"
}
