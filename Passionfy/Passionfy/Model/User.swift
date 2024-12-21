//
//  User.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import Foundation

struct User: Decodable, Identifiable, Hashable {
    var id: String
    var username: String
    var birthdate: String
    var phoneNumber: String
    var occupation: String
    var gender: Gender
    let preference: Preference
    let interest: Interest
    var profileImageUrls: [String]
    let city: String
    let country: String
    var bio: String
}
