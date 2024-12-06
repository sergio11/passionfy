//
//  MockData.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import Foundation

struct MockData {
    
    static let users: [User] = [
        .init(
            id: NSUUID().uuidString,
            username: "MeganFox",
            phone: "+15551234567",
            birthdate: "1987-05-16",
            fullname: "Megan Fox",
            profileImageUrls: ["example"]
        ),
        .init(
            id: NSUUID().uuidString,
            username: "DavidBeckham",
            phone: "+447556547890",
            birthdate: "1987-03-16",
            fullname: "David Beckham",
            profileImageUrls: ["example"]
        ),
        .init(
            id: NSUUID().uuidString,
            username: "Conor",
            phone: "+353876321456",
            birthdate: "1987-07-14",
            fullname: "Conor McGregor",
            profileImageUrls: ["example"]
        )
    ]
}
