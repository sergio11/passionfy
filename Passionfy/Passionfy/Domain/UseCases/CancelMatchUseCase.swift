//
//  CancelMatchUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import Foundation

/// A struct representing the parameters required to cancel a user match.
///
/// This struct contains the information needed to cancel a match between two users. Specifically, it holds the ID of the
/// target user whose match needs to be canceled.
struct CancelMatchParams {
    let targetUserId: String
}

/// A use case responsible for canceling a match between the authenticated user and the target user.
///
/// This use case interacts with the `UserRepository` and `AuthenticationRepository` to perform the cancellation of the match
/// by using the current authenticated user's ID and the target user's ID. It encapsulates the logic for canceling the match
/// between two users and provides a simple interface for executing the operation.
///
/// The `execute` method takes `CancelMatchParams` as input, which includes the target user's ID, and then cancels the match
/// between the authenticated user and the target user.
///
/// - Dependencies:
///   - `userRepository`: The repository used for user-related operations, including canceling matches.
///   - `authenticationRepository`: The repository used for authentication-related operations, including fetching the current authenticated user ID.
struct CancelMatchUseCase {
    
    // MARK: - Dependencies
    
    /// The repository responsible for user-related operations, including canceling user matches.
    let userRepository: UserRepository
    
    /// The repository responsible for authentication-related tasks, such as fetching the current user ID.
    let authenticationRepository: AuthenticationRepository

    // MARK: - Methods
    
    /// Executes the use case for canceling the match between the authenticated user and the target user.
    ///
    /// This method retrieves the current authenticated user's ID using the `authenticationRepository`, and then
    /// calls the `userRepository` to cancel the match with the target user whose ID is provided in the `params`.
    ///
    /// - Parameter params: The parameters required for canceling the match, including the `targetUserId` (the user whose match
    ///   with the authenticated user should be canceled).
    /// - Throws: Throws an error if the current user ID cannot be retrieved from the `authenticationRepository`, or if an error
    ///   occurs during the match cancellation process with the `userRepository`.
    func execute(params: CancelMatchParams) async throws {
        let authUserId = try await authenticationRepository.getCurrentUserId()
        try await userRepository.cancelMatch(userId: authUserId, targetUserId: params.targetUserId)
    }
}
