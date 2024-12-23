//
//  FirestoreUserMatchDataSourceImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 23/12/24.
//

import Foundation
import Firebase
import FirebaseFirestore

internal class FirestoreUserMatchDataSourceImpl: UserMatchDataSource {
    
    private let matchesCollection = "passionfy_user_matches"
    
    /// Adds a like for a user and checks if both users have made a match.
    /// - Parameters:
    ///   - userId: The ID of the user who is liking.
    ///   - targetUserId: The ID of the user being liked.
    /// - Returns: A Boolean indicating whether both users have made a match.
    /// - Throws: An error if the operation fails.
    func likeUser(userId: String, targetUserId: String) async throws -> Bool {
        let userMatchRef = Firestore.firestore().collection(matchesCollection).document(userId)
        
        // Remove from dislikedUsers if the user had previously disliked the target
        try await userMatchRef.setData([
            "dislikedUsers": FieldValue.arrayRemove([targetUserId])
        ], merge: true)
        
        // Add a like to the user (userId) for targetUserId
        do {
            try await userMatchRef.setData([
                "likedUsers": FieldValue.arrayUnion([targetUserId])
            ], merge: true)
            
            // Now check if both users have liked each other (mutual like)
            return try await hasMatchBetween(userId: userId, targetUserId: targetUserId)
        } catch {
            print("Error adding like: \(error.localizedDescription)")
            throw error
        }
    }
    
    /// Removes a like (dislike) for a user.
    /// - Parameters:
    ///   - userId: The ID of the user who is disliking.
    ///   - targetUserId: The ID of the user being disliked.
    /// - Throws: An error if the operation fails.
    func dislikeUser(userId: String, targetUserId: String) async throws {
        let userMatchRef = Firestore.firestore().collection(matchesCollection).document(userId)
        
        // Remove from likedUsers if the user had previously liked the target
        try await userMatchRef.setData([
            "likedUsers": FieldValue.arrayRemove([targetUserId])
        ], merge: true)
        
        // Add a dislike to the user (userId) for targetUserId
        do {
            try await userMatchRef.setData([
                "dislikedUsers": FieldValue.arrayUnion([targetUserId])
            ], merge: true)
        } catch {
            print("Error adding dislike: \(error.localizedDescription)")
            throw error
        }
    }
    
    /// Checks if two users have made a match by checking if both have liked each other.
    /// - Parameters:
    ///   - userId: The ID of the first user.
    ///   - targetUserId: The ID of the second user.
    /// - Returns: A Boolean indicating whether both users have liked each other (match).
    /// - Throws: An error if the operation fails.
    func hasMatchBetween(userId: String, targetUserId: String) async throws -> Bool {
        let userMatchRef = Firestore.firestore().collection(matchesCollection).document(userId)
        
        let documentSnapshot = try await userMatchRef.getDocument()
        guard let userMatchData = documentSnapshot.data() else {
            return false
        }
        
        // Check if the targetUserId exists in the likedUsers field
        if let likedUsers = userMatchData["likedUsers"] as? [String], likedUsers.contains(targetUserId) {
            let targetUserMatchRef = Firestore.firestore().collection(matchesCollection).document(targetUserId)
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
    /// - Parameter userId: The ID of the user whose likes are to be retrieved.
    /// - Returns: A list of user IDs that the user has liked.
    /// - Throws: An error if the operation fails.
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
    /// - Parameter userId: The ID of the user whose dislikes are to be retrieved.
    /// - Returns: A list of user IDs that the user has disliked.
    /// - Throws: An error if the operation fails.
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
    /// - Parameter userId: The ID of the user whose matches are to be retrieved.
    /// - Returns: A list of user IDs that the user has matched with.
    /// - Throws: An error if the operation fails.
    func getUserMatches(userId: String) async throws -> [String] {
        let userMatchRef = Firestore.firestore().collection(matchesCollection).document(userId)
        
        let documentSnapshot = try await userMatchRef.getDocument()
        guard let userMatchData = documentSnapshot.data() else {
            return []
        }
        
        // Check for mutual likes (matches) in the likedUsers field
        if let likedUsers = userMatchData["likedUsers"] as? [String] {
            var matchedUsers: [String] = []
            for likedUser in likedUsers {
                // For each liked user, check if they also liked the current user
                let targetUserMatchRef = Firestore.firestore().collection(matchesCollection).document(likedUser)
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
}
