//
//  UpdateUserMapper.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import Foundation

class UpdateUserMapper: Mapper {
    typealias Input = UpdateUserDataMapper
    typealias Output = UpdateUserDTO
    
    func map(_ input: UpdateUserDataMapper) -> UpdateUserDTO {
        return UpdateUserDTO(
            userId: input.data.id,
            username: input.data.username,
            birthdate: input.data.birthdate,
            occupation: input.data.occupation,
            gender: input.data.gender?.rawValue,
            preference: input.data.preference?.rawValue,
            interest: input.data.interest?.rawValue,
            profileImageUrls: input.profileImageUrls.isEmpty ? nil : input.profileImageUrls,
            bio: input.data.bio
        )
    }
}

struct UpdateUserDataMapper {
    let profileImageUrls: [String]
    let data: UpdateUser
}
