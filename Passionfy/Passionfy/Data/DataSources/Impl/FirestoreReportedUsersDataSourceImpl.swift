//
//  FirestoreReportedUsersDataSourceImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import Foundation
import Firebase

/// A data source for managing reported users and blocking their interaction.
internal class FirestoreReportedUsersDataSourceImpl: ReportedUsersDataSource {

    private let reportsCollection = "passionfy_reported_users"
    private let reportedUsersCollection = "reportedUsers"
    private let blockedByCollection = "blockedBy"

    /// Reports a user for a specific reason and blocks interaction between the users.
    /// - Parameters:
    ///   - reporterId: The ID of the user reporting.
    ///   - reportedId: The ID of the user being reported.
    ///   - reason: The reason for reporting.
    /// - Throws: An error if the operation fails.
    func reportUser(data: ReportUserDTO) async throws {
        do {
            let collection = Firestore
                .firestore()
                .collection(reportsCollection)

            let reporterDoc = collection
                .document(data.reporterId)
            
            try await reporterDoc.setData([
                reportedUsersCollection: FieldValue.arrayUnion([data.asDictionary()])
            ], merge: true)

            let reportedDoc = collection.document(data.reportedId)
            try await reportedDoc.setData([
                blockedByCollection: FieldValue.arrayUnion([data.reporterId])
            ], merge: true)
        } catch {
            throw ReportedUsersDataSourceException.reportUserFailed(
                message: "Failed to report user \(data.reportedId) by \(data.reporterId).",
                cause: error
            )
        }
    }

    /// Retrieves the IDs of users reported by the current user.
    /// - Parameter userId: The ID of the user whose reports to retrieve.
    /// - Returns: An array of reported user IDs.
    /// - Throws: An error if the operation fails.
    func getUsersReportedBy(userId: String) async throws -> [String] {
        do {
            let snapshot = try await Firestore.firestore()
                .collection(reportsCollection)
                .document(userId)
                .getDocument()

            if let data = snapshot.data(),
               let reportedUsers = data[reportedUsersCollection] as? [[String: Any]] {
                let reportedIds = reportedUsers.compactMap { $0["reportedId"] as? String }
                return reportedIds
            } else {
                return []
            }
        } catch {
            throw ReportedUsersDataSourceException.reportedUsersRetrievalFailed(
                message: "Failed to retrieve reported users for user \(userId).",
                cause: error
            )
        }
    }

    /// Retrieves the IDs of users who have reported the current user.
    /// - Parameter userId: The ID of the user whose reporters to retrieve.
    /// - Returns: An array of user IDs who have reported the user.
    /// - Throws: An error if the operation fails.
    func getUsersWhoReported(userId: String) async throws -> [String] {
        do {
            let snapshot = try await Firestore.firestore()
                .collection(reportsCollection)
                .document(userId)
                .getDocument()

            if let data = snapshot.data(),
               let blockedBy = data[blockedByCollection] as? [String] {
                return blockedBy
            } else {
                return []
            }
        } catch {
            throw ReportedUsersDataSourceException.reportersRetrievalFailed(
                message: "Failed to retrieve users who reported user \(userId).",
                cause: error
            )
        }
    }
}

