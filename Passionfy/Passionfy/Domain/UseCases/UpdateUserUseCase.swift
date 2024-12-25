//
//  UpdateUserUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

struct UpdateUserParams {
    let username: String?
    let birthdate: String?
    let occupation: String?
    let bio: String?
    let gender: Gender?
    let preference: Preference?
    let interest: Interest?
    let profileImages: [(index: Int, data: Data)]?
    let userCoordinates: UserCoordinates?
    let userCity: String?
    let userCountry: String?
}

/// An entity responsible for updating user information.
struct UpdateUserUseCase {
    let userRepository: UserRepository
    let authRepository: AuthenticationRepository
    
    /// Executes the user information update asynchronously.
        /// - Parameters:
        ///   - params: Parameters containing the updated user information.
        /// - Returns: The updated user object.
        /// - Throws: An error if the update fails or if the current user session is invalid.
    func execute(params: UpdateUserParams) async throws -> User {
        let userId = try await authRepository.getCurrentUserId()
        return try await userRepository.updateUser(data: UpdateUser(
            id: userId,
            username: params.username,
            birthdate: params.birthdate,
            occupation: params.occupation,
            bio: params.bio,
            gender: params.gender,
            preference: params.preference,
            interest: params.interest,
            coords: params.userCoordinates,
            city: params.userCity,
            country: params.userCountry,
            profileImages: params.profileImages
        ))
    }
}
