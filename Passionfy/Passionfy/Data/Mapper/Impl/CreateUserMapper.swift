//
//  CreateUserMapper.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import Foundation

class CreateUserMapper: Mapper {
    typealias Input = CreateUserDataMapper
    typealias Output = CreateUserDTO
    
    func map(_ input: CreateUserDataMapper) -> CreateUserDTO {
        return CreateUserDTO(
            userId: input.data.id,
            username: input.data.username,
            birthdate: input.data.birthdate,
            phoneNumber: input.data.phoneNumber,
            occupation: input.data.occupation,
            gender: input.data.gender.rawValue,
            preference: input.data.preference.rawValue,
            interest: input.data.interest.rawValue,
            coords: UserCoordinatesDTO(
                latitude: input.data.coords.latitude,
                longitude: input.data.coords.longitude
            ),
            city: input.data.city,
            country: input.data.country,
            profileImageUrls: input.profileImageUrls
        )
    }
}

struct CreateUserDataMapper {
    let profileImageUrls: [String]
    let data: CreateUser
}
