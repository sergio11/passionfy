//
//  UpdateUserDTO.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

internal struct UpdateUserDTO {
    var userId: String
    var username: String?
    var birthdate: String?
    var occupation: String?
    var gender: String?
    let preference: String?
    let interest: String?
    let coords: UserCoordinatesDTO?
    let city: String?
    let country: String?
    var profileImageUrls: [(Int, String)]?
    var bio: String?
}
