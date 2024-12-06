//
//  UserDTO.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

internal struct UserDTO: Decodable {
    var userId: String
    var username: String
    var birthdate: String
    var phoneNumber: String
    var fullname: String
    var location: String?
    var bio: String?
    var profileImageUrls: [String]
}
