//
//  ReportUserUseCase.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import Foundation

/// Struct representing the parameters required to report a user.
struct ReportUserParams {
    let reportedId: String
    let reason: String
}

/// Use case for reporting a user.
///
/// This struct encapsulates the logic for reporting a user by interacting with the `ReportedUsersDataSource` to perform the report operation and the `AuthenticationRepository` to retrieve the current user's ID.
struct ReportUserUseCase {
    
    let reportedUsersDataSource: ReportedUsersDataSource
    let authRepository: AuthenticationRepository
    
    /// Executes the use case for reporting a user.
    ///
    /// This method retrieves the current user's ID from the `authRepository`, and then it calls the `reportedUsersDataSource` to report the user by passing the required data.
    /// - Parameter params: The parameters required to report the user, including the reported user's ID and the reason.
    /// - Throws: Throws an error if the operation fails, including any issues with fetching the current user ID or reporting the user.
    func execute(params: ReportUserParams) async throws {
        let userId = try await authRepository.getCurrentUserId()
        return try await reportedUsersDataSource.reportUser(
            data: ReportUserDTO(
                reporterId: userId,
                reportedId: params.reportedId,
                reason: params.reason
            )
        )
    }
}
