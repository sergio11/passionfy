//
//  FirestoreStorageFilesDataSourceImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation
import FirebaseStorage

/// A data source responsible for managing file uploads to Firestore Storage.
internal class FirestoreStorageFilesDataSourceImpl: StorageFilesDataSource {
    
    /// The path for storing profile images in Firestore Storage.
    private let profileImagesPath = "passionfy_profile_images"

    /// Uploads an image to Firestore Storage asynchronously.
        ///
        /// - Parameters:
        ///   - imageData: The data of the image to be uploaded.
        /// - Returns: A string representing the URL of the uploaded image.
        /// - Throws: An error if the upload operation fails.
    func uploadImage(imageData: Data) async throws -> String {
        let filename = NSUUID().uuidString
        do {
            let ref = Storage.storage().reference(withPath: "/\(profileImagesPath)/\(filename)")
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL().absoluteString
            return url
        } catch {
            print(error)
            throw StorageFilesException.uploadFailed(message: "Failed to upload image: \(error.localizedDescription)", cause: error)
        }
    }
}
