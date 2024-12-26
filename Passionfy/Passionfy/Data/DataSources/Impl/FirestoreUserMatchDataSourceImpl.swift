//
//  FirestoreUserMatchDataSourceImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 23/12/24.
//

import Foundation
import Firebase
import FirebaseFirestore

/// Data source implementation for managing user match interactions with Firestore.
internal class FirestoreUserMatchDataSourceImpl: UserMatchDataSource {
    
    private let matchesCollection = "passionfy_user_matches"
    
    /// Adds a like for a user and checks if both users have made a match.
    func likeUser(userId: String, targetUserId: String) async throws -> Bool {
        let userMatchRef = Firestore.firestore().collection(matchesCollection).document(userId)
        
        // Remove from dislikedUsers if the user had previously disliked the target
        do {
            try await userMatchRef.setData([
                "dislikedUsers": FieldValue.arrayRemove([targetUserId])
            ], merge: true)
        } catch {
            throw UserMatchDataSourceException.dislikeUserFailed(message: "Failed to remove user from disliked list.", cause: error)
        }
        
        // Add a like to the user (userId) for targetUserId
        do {
            try await userMatchRef.setData([
                "likedUsers": FieldValue.arrayUnion([targetUserId])
            ], merge: true)
            
            // Check if both users have liked each other (mutual like)
            return try await hasMatchBetween(userId: userId, targetUserId: targetUserId)
        } catch {
            throw UserMatchDataSourceException.likeUserFailed(message: "Failed to add like for user \(targetUserId).", cause: error)
        }
    }
    
    /// Removes a like (dislike) for a user.
    func dislikeUser(userId: String, targetUserId: String) async throws {
        let userMatchRef = Firestore.firestore().collection(matchesCollection).document(userId)
        
        // Remove from likedUsers if the user had previously liked the target
        do {
            try await userMatchRef.setData([
                "likedUsers": FieldValue.arrayRemove([targetUserId])
            ], merge: true)
        } catch {
            throw UserMatchDataSourceException.likeUserFailed(message: "Failed to remove like for user \(targetUserId).", cause: error)
        }
        
        // Add a dislike to the user (userId) for targetUserId
        do {
            try await userMatchRef.setData([
                "dislikedUsers": FieldValue.arrayUnion([targetUserId])
            ], merge: true)
        } catch {
            throw UserMatchDataSourceException.dislikeUserFailed(message: "Failed to add dislike for user \(targetUserId).", cause: error)
        }
    }
    
    /// Checks if two users have made a match by checking if both have liked each other.
    func hasMatchBetween(userId: String, targetUserId: String) async throws -> Bool {
        let collection = Firestore.firestore().collection(matchesCollection)
        let userMatchRef = collection.document(userId)
        
        let documentSnapshot = try await userMatchRef.getDocument()
        guard let userMatchData = documentSnapshot.data() else {
            return false
        }
        
        // Check if the targetUserId exists in the likedUsers field
        if let likedUsers = userMatchData["likedUsers"] as? [String], likedUsers.contains(targetUserId) {
            let targetUserMatchRef = collection.document(targetUserId)
            let targetDocumentSnapshot = try await targetUserMatchRef.getDocument()
            guard let targetUserMatchData = targetDocumentSnapshot.data() else {
                return false
            }
            
            // Check if userId exists in the target's likedUsers field
            if let targetLikedUsers = targetUserMatchData["likedUsers"] as? [String], targetLikedUsers.contains(userId) {
                // Both users have liked each other, hence a match
                return true
            }
        }
        
        return false
    }
    
    /// Retrieves the list of user IDs that the specified user has liked.
    func getUserLikes(userId: String) async throws -> [String] {
        let userMatchRef = Firestore.firestore().collection(matchesCollection).document(userId)
        
        let documentSnapshot = try await userMatchRef.getDocument()
        guard let userMatchData = documentSnapshot.data() else {
            return []
        }
        
        // Return the likedUsers array from the document
        if let likedUsers = userMatchData["likedUsers"] as? [String] {
            return likedUsers
        } else {
            return []
        }
    }
    
    /// Retrieves the list of user IDs that the specified user has disliked.
    func getUserDislikes(userId: String) async throws -> [String] {
        let userMatchRef = Firestore.firestore().collection(matchesCollection).document(userId)
        
        let documentSnapshot = try await userMatchRef.getDocument()
        guard let userMatchData = documentSnapshot.data() else {
            return []
        }
        
        // Return the dislikedUsers array from the document
        if let dislikedUsers = userMatchData["dislikedUsers"] as? [String] {
            return dislikedUsers
        } else {
            return []
        }
    }
    
    /// Retrieves the list of user IDs who have matched with the specified user.
    func getUserMatches(userId: String) async throws -> [String] {
        let collection = Firestore.firestore().collection(matchesCollection)
        let userMatchRef = collection.document(userId)
        
        let documentSnapshot = try await userMatchRef.getDocument()
        guard let userMatchData = documentSnapshot.data() else {
            return []
        }
        
        // Check for mutual likes (matches) in the likedUsers field
        if let likedUsers = userMatchData["likedUsers"] as? [String] {
            var matchedUsers: [String] = []
            for likedUser in likedUsers {
                // For each liked user, check if they also liked the current user
                let targetUserMatchRef = collection.document(likedUser)
                let targetDocumentSnapshot = try await targetUserMatchRef.getDocument()
                guard let targetUserMatchData = targetDocumentSnapshot.data() else {
                    continue
                }
                
                if let targetLikedUsers = targetUserMatchData["likedUsers"] as? [String], targetLikedUsers.contains(userId) {
                    matchedUsers.append(likedUser)
                }
            }
            return matchedUsers
        }
        
        return []
    }
    
    /// Cancels a match between two users by removing both users from each other's liked list.
    /// - Parameters:
    ///   - userId: The ID of the user who wants to cancel the match.
    ///   - targetUserId: The ID of the user whose match is being canceled.
    /// - Throws: An error if the operation fails.
    func cancelMatch(userId: String, targetUserId: String) async throws {
        let db = Firestore.firestore()
        let batch = db.batch()
            
        let userMatchRef = db.collection(matchesCollection).document(userId)
        let targetUserMatchRef = db.collection(matchesCollection).document(targetUserId)
            
        // Prepare the operations for both users:
        batch.updateData([
            "likedUsers": FieldValue.arrayRemove([targetUserId]),
            "dislikedUsers": FieldValue.arrayRemove([targetUserId])
        ], forDocument: userMatchRef)
            
        batch.updateData([
            "likedUsers": FieldValue.arrayRemove([userId]),
            "dislikedUsers": FieldValue.arrayRemove([userId])
        ], forDocument: targetUserMatchRef)
            
        do {
            try await batch.commit()
        } catch {
            throw UserMatchDataSourceException.cancelMatchFailed(message: "Failed to cancel match between \(userId) and \(targetUserId).", cause: error)
        }
    }
}
