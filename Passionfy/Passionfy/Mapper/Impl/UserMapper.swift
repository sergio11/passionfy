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
            phone: input.phoneNumber,
            birthdate: input.birthdate,
            fullname: input.fullname,
            profileImageUrls: input.profileImageUrls,
            bio: input.bio,
            location: input.location
        )
    }
}
