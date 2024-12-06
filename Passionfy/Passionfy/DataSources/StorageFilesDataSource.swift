//
//  StorageFilesDataSource.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

/// An enumeration representing possible errors that may occur during storage file operations.
enum StorageFilesError: Error {
    /// Error indicating that the upload operation failed.
    case uploadFailed(message: String)
}


/// A protocol defining storage file operations.
protocol StorageFilesDataSource {
    /// Uploads the provided image data asynchronously.
    /// - Parameters:
    ///   - imageData: The data of the image to upload.
    /// - Returns: A string representing the URL of the uploaded image.
    /// - Throws: An error in case of failure.
    func uploadImage(imageData: Data) async throws -> String
}
