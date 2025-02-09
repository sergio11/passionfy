//
//  CreateUserDTO+Dictionary.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

internal extension CreateUserDTO {
    func asDictionary() -> [String: Any] {
        return [
            "userId": userId,
            "username": username,
            "birthdate": birthdate,
            "phoneNumber": phoneNumber,
            "occupation": occupation,
            "gender": gender,
            "preference": preference,
            "interest": interest,
            "city": city,
            "country": country,
            "coords": [
                "latitude": coords.latitude,
                "longitude": coords.longitude,
            ],
            "bio": "",
            "profileImageUrls": profileImageUrls,
            "hobbies": [String]()
        ]
    }
}
