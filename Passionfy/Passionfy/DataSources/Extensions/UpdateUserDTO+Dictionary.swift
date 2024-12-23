//
//  UpdateUserDTO+Dictionary.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

internal extension UpdateUserDTO {
    func asDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "userId": userId
        ]

        if let username = username {
            dictionary["username"] = username
        }
        
        if let birthdate = birthdate {
            dictionary["birthdate"] = birthdate
        }
        
        if let occupation = occupation {
            dictionary["occupation"] = occupation
        }
        
        if let gender = gender {
            dictionary["gender"] = gender
        }
        
        if let preference = preference {
            dictionary["preference"] = preference
        }
        
        if let interest = interest {
            dictionary["interest"] = interest
        }
        
        if let bio = bio {
            dictionary["bio"] = bio
        }
        
        if let city = city {
            dictionary["city"] = city
        }
        
        if let country = country {
            dictionary["country"] = country
        }
        
        if let coords = coords {
            let coordsDictionary: [String: Any] = [
                "latitude": coords.latitude,
                "longitude": coords.longitude
            ]
            dictionary["coords"] = coordsDictionary
        }
        
        if let profileImageUrls = profileImageUrls {
            dictionary["profileImageUrls"] = profileImageUrls.map { $0.1 }
        }
        
        return dictionary
    }
}
