//
//  ReportedUsersDataSourceException.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

/// Enum representing errors that can occur in the `ReportedUsersDataSource`.
enum ReportedUsersDataSourceException: Error {
    /// Error indicating that reporting a user failed.
    case reportUserFailed(message: String, cause: Error?)
    /// Error indicating that retrieving the reported users failed.
    case reportedUsersRetrievalFailed(message: String, cause: Error?)
    /// Error indicating that retrieving the users who reported a specific user failed.
    case reportersRetrievalFailed(message: String, cause: Error?)
    /// Error indicating that blocking interaction between users failed.
    case userBlockingFailed(message: String, cause: Error?)
}
