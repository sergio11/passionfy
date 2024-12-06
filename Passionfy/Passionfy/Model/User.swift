//
//  User.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import Foundation

struct User: Identifiable, Hashable {
    let id: String
    let fullname: String
    var age: Int
    var profileImageURLs: [String]
}
