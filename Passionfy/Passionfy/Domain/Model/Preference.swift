//
//  Preference.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 13/12/24.
//

import Foundation

enum Preference: String, CaseIterable, Decodable {
    case friendship = "Friendship"
    case casualDating = "Casual Dating"
    case seriousRelationship = "Serious Relationship"
    case exploringOptions = "Exploring Options"
    case longTermPartner = "Long-term Partner"
    case activityPartner = "Activity Partner"
}
