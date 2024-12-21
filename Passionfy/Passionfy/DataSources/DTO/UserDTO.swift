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
    var occupation: String
    var gender: String
    let preference: String
    let interest: String
    var profileImageUrls: [String]
    let city: String
    let country: String
    var bio: String
}
