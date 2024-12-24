//
//  VerifySessionUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

/// An entity responsible for verifying the current user session.
struct VerifySessionUseCase {
    let authRepository: AuthenticationRepository
    let userProfileRepository: UserRepository
    
    /// Executes the session verification asynchronously.
        /// - Returns: A boolean indicating whether the session is valid.
    func execute() async throws -> Bool {
        guard let userId = try await authRepository.getCurrentUserId() else {
            return false
        }
        var userData: User? = nil
        do {
            userData = try await userProfileRepository.getUser(userId: userId)
        } catch {
            try await authRepository.signOut()
            return false
        }
        return userData != nil
    }
}
