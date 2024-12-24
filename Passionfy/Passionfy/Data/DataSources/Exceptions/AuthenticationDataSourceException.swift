//
//  AuthenticationError.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// An enumeration representing possible authentication errors.
enum AuthenticationDataSourceException: Error {
    /// Error indicating failure in phone number verification.
    case phoneVerificationFailed(message: String, cause: Error?)
    /// Error indicating failure in signing in.
    case signInFailed(message: String, cause: Error?)
    /// Error indicating failure in signing out.
    case signOutFailed(message: String, cause: Error?)
}
