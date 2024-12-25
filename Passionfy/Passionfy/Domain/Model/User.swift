//
//  User.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import Foundation

struct User: Decodable, Identifiable, Hashable {
    let id: String
    let username: String
    let birthdate: String
    let phoneNumber: String
    let occupation: String
    let gender: Gender
    let preference: Preference
    let interest: Interest
    let profileImageUrls: [String]
    let city: String
    let country: String
    let bio: String
    let hobbies: [String]
}
