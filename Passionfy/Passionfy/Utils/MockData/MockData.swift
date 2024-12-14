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
            birthdate: "1986-05-16",
            phoneNumber: "+15551234567",
            occupation: "Actress",
            gender: .female,
            preference: .seriousRelationship,
            interest: .men,
            profileImageUrls: [
                "example",
                "example"
            ],
            location: "Los Angeles, CA",
            bio: "Lover of cinema and fine art. 🌟"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "DavidBeckham",
            birthdate: "1975-05-02",
            phoneNumber: "+447556547890",
            occupation: "Athlete",
            gender: .male,
            preference: .longTermPartner,
            interest: .women,
            profileImageUrls: [
                "example",
                "example"
            ],
            location: "London, UK",
            bio: "Football is life. 🏆"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "Conor",
            birthdate: "1988-07-14",
            phoneNumber: "+353876321456",
            occupation: "MMA Fighter",
            gender: .male,
            preference: .casualDating,
            interest: .women,
            profileImageUrls: [
                "example",
                "example"
            ],
            location: "Dublin, Ireland",
            bio: "Knockout artist and whiskey enthusiast. 🥃"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "TaylorSwift",
            birthdate: "1989-12-13",
            phoneNumber: "+15559876543",
            occupation: "Singer",
            gender: .female,
            preference: .exploringOptions,
            interest: .everyone,
            profileImageUrls: [
                "example",
                "example"
            ],
            location: "Nashville, TN",
            bio: "Writing songs about life and love. 🎶"
        )
    ]
}
