//
//  CreateUser.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 14/12/24.
//

import Foundation

struct CreateUser: Identifiable, Hashable {
    let id: String
    let username: String
    let birthdate: String
    let occupation: String
    let gender: Gender
    let phoneNumber: String
    let preference: Preference
    let interest: Interest
    let coords: UserCoordinates
    let city: String
    let country: String
    let profileImages: [Data]
}
