//
//  SignUpUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

struct SignUpParams {
    let name: String
    let birthdate: String
    let occupation: String
    let gender: Gender
    let selectedPreference: Preference
    let selectedInterest: Interest
    let profileImages: [Data]
    let phoneNumber: String
    let verificationCode: String
    let otpText: String
    let userCoordinates: (latitude: Double, longitude: Double)
    let userCity: String
    let userCountry: String
}

/// An entity responsible for signing up a new user.
struct SignUpUseCase {
    let authRepository: AuthenticationRepository
    let userRepository: UserRepository
    
    /// Executes the process of signing up a new user asynchronously.
        /// - Parameter params: Parameters required for signing up, including name, birthdate, phone number, verification code, and OTP text.
        /// - Returns: The newly signed-up user.
        /// - Throws: An error if the sign-up operation fails.
    func execute(params: SignUpParams) async throws -> User {
        let userId = try await authRepository.verifyOTP(verificationCode: params.verificationCode, otpCode: params.otpText)
        return try await userRepository.createUser(data: CreateUser(
            id: userId,
            username: params.name,
            birthdate: params.birthdate,
            occupation: params.occupation,
            gender: params.gender,
            phoneNumber: params.phoneNumber,
            preference: params.selectedPreference,
            interest: params.selectedInterest,
            coords: UserCoordinates(
                latitude: params.userCoordinates.latitude,
                longitude: params.userCoordinates.longitude
            ),
            city: params.userCity,
            country: params.userCountry,
            profileImages: params.profileImages
        ))
    }
}
