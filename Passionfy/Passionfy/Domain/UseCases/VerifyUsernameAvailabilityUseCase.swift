//
//  VerifyUsernameAvailabilityUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

struct VerifyUsernameParams {
    let username: String
}

/// An entity responsible for verifying the availability of a username.
struct VerifyUsernameAvailabilityUseCase {
    let userProfileRepository: UserRepository
    
    /// Executes the process of verifying the availability of a username asynchronously.
        /// - Parameters:
        ///   - params: Parameters containing the username to verify.
        /// - Returns: A Boolean value indicating whether the username is available or not.
        /// - Throws: An error if the username availability verification operation fails.
    func execute(params: VerifyUsernameParams) async throws -> Bool {
        return try await userProfileRepository.checkUsernameAvailability(username: params.username)
    }
}
