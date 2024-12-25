//
//  CreateUserDTO.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

internal struct CreateUserDTO: Decodable {
    let userId: String
    let username: String
    let birthdate: String
    let phoneNumber: String
    let occupation: String
    let gender: String
    let preference: String
    let interest: String
    let coords: UserCoordinatesDTO
    let city: String
    let country: String
    let profileImageUrls: [String]
}
