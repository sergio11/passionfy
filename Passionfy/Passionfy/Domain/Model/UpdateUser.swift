//
//  UpdateUser.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import Foundation

struct UpdateUser: Identifiable {
    let id: String
    let username: String?
    let birthdate: String?
    let occupation: String?
    let bio: String?
    let gender: Gender?
    let preference: Preference?
    let interest: Interest?
    let coords: UserCoordinates?
    let city: String?
    let country: String?
    let profileImages: [(index: Int, data: Data)]?
    let hobbies: [String]?
}
