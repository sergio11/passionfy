//
//  StorageFilesError.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// An enumeration representing possible errors that may occur during storage file operations.
enum StorageFilesException: Error {
    /// Error indicating that the upload operation failed.
    case uploadFailed(message: String, cause: Error?)
}
