//
//  UserMatchDataSourceError.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// Enum representing errors that can occur in the `UserMatchDataSource`.
enum UserMatchDataSourceException: Error {
    
    /// Error indicating that the like operation failed.
    case likeUserFailed(message: String, cause: Error?)
    
    /// Error indicating that the dislike operation failed.
    case dislikeUserFailed(message: String, cause: Error?)
}
