//
//  ReportedUsersDataSource.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import Foundation

/// A protocol defining the methods required for managing reported users.
protocol ReportedUsersDataSource {

    /// Reports a user for a specific reason and blocks interaction between the users.
    /// - Parameters:
    ///   - reporterId: The ID of the user reporting.
    ///   - reportedId: The ID of the user being reported.
    ///   - reason: The reason for reporting.
    /// - Throws: An error if the operation fails.
    func reportUser(data: ReportUserDTO) async throws

    /// Retrieves the IDs of users reported by the current user.
    /// - Parameter userId: The ID of the user whose reports to retrieve.
    /// - Returns: An array of reported user IDs.
    /// - Throws: An error if the operation fails.
    func getUsersReportedBy(userId: String) async throws -> [String]

    /// Retrieves the list of users who have reported the current user.
    /// - Parameter userId: The ID of the user whose reporters to retrieve.
    /// - Returns: An array of user IDs who have reported the user.
    /// - Throws: An error if the operation fails.
    func getUsersWhoReported(userId: String) async throws -> [String]
}
