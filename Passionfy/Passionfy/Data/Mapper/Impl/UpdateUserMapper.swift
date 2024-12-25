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
        var userCoords: UserCoordinatesDTO?
        if let coords = input.data.coords {
            userCoords = UserCoordinatesDTO(
                latitude: coords.latitude,
                longitude: coords.longitude
            )
        }
        
        var mergedProfileImageUrls: [(Int, String)] = []

        var imageDictionary: [Int: String] = [:]

        if let currentUrls = input.currentProfileImageUrls {
            for (index, url) in currentUrls {
                imageDictionary[index] = url
            }
        }

        if let newUrls = input.newProfileImageUrls {
            for (index, url) in newUrls {
                imageDictionary[index] = url
            }
        }

        mergedProfileImageUrls = imageDictionary.sorted { $0.key < $1.key }
        
        return UpdateUserDTO(
            userId: input.data.id,
            username: input.data.username,
            birthdate: input.data.birthdate,
            occupation: input.data.occupation,
            gender: input.data.gender?.rawValue,
            preference: input.data.preference?.rawValue,
            interest: input.data.interest?.rawValue,
            coords: userCoords,
            city: input.data.city,
            country: input.data.country,
            profileImageUrls: mergedProfileImageUrls,
            bio: input.data.bio,
            hobbies: input.data.hobbies
        )
    }
}

struct UpdateUserDataMapper {
    let currentProfileImageUrls: [(Int, String)]?
    let newProfileImageUrls: [(Int, String)]?
    let data: UpdateUser
}
