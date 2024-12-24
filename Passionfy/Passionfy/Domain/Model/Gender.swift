//
//  Gender.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 13/12/24.
//

import Foundation

enum Gender: String, CaseIterable, Decodable {
    case male = "Male"
    case female = "Female"
    case nonBinary = "Non-binary"
    case genderqueer = "Genderqueer"
    case agender = "Agender"
    case twoSpirit = "Two-Spirit"
    case bigender = "Bigender"
    case other = "Other"
    case custom = "Custom"
}
