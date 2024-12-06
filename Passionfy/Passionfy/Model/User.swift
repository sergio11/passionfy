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
    var phone: String
    var birthdate: String
    var fullname: String
    var profileImageUrls: [String]
    var bio: String?
    var location: String?
}
