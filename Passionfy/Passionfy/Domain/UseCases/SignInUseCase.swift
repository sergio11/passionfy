//
//  SignInUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

struct SignInParams {
    let verificationCode: String
    let otpText: String
}

/// An entity responsible for handling user sign-in operations.
struct SignInUseCase {
    let authRepository: AuthenticationRepository
    let userProfileRepository: UserRepository
    
    /// Executes the sign-in operation asynchronously.
        /// - Parameter params: An instance of `SignInParams` containing verification and OTP code.
        /// - Returns: A `User` object representing the signed-in user.
        /// - Throws: An error if the sign-in operation fails.
    func execute(params: SignInParams) async throws -> User {
        let userId = try await authRepository.verifyOTP(verificationCode: params.verificationCode, otpCode: params.otpText)
        return try await userProfileRepository.getUser(userId: userId)
    }
}
