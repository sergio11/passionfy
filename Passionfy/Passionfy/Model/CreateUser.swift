//
//  CreateUser.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 14/12/24.
//

import Foundation

struct CreateUser: Identifiable, Hashable {
    var id: String
    var username: String
    var birthdate: String
    var occupation: String
    var gender: Gender
    var phoneNumber: String
    let preference: Preference
    let interest: Interest
    let profileImages: [Data]
}
