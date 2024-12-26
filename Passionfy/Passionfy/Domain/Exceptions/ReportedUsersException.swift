//
//  ReportedUsersException.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import Foundation

/// Enum representing errors that can occur in the `ReportedUsersRepository` data source.
enum ReportedUsersException: Error {
    
    /// Error indicating that reporting a user failed.
    /// - Parameters:
    ///   - message: A detailed description of the error.
    ///   - cause: The underlying error that caused the failure, if available.
    case reportUserFailed(message: String, cause: Error?)
}
