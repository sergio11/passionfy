//
//  UserMapper.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

class UserMapper: Mapper {
    typealias Input = UserDTO
    typealias Output = User
    
    func map(_ input: UserDTO) -> User {
        return User(
            id: input.userId,
            username: input.username,
            birthdate: input.birthdate,
            phoneNumber: input.phoneNumber,
            occupation: input.occupation,
            gender: Gender(rawValue: input.gender) ?? .other,
            preference: Preference(rawValue: input.preference) ?? .exploringOptions,
            interest: Interest(rawValue: input.interest) ?? .everyone,
            profileImageUrls: input.profileImageUrls,
            city: input.city,
            country: input.country,
            bio: input.bio,
            hobbies: input.hobbies
        )
    }
}
