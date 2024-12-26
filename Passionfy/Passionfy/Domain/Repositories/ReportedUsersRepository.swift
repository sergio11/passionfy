//
//  ReportedUsersRepository.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import Foundation

/// A repository for managing reported users and blocking their interactions.
protocol ReportedUsersRepository {
    
    /// Reports a user for inappropriate behavior or other reasons.
    /// - Parameter data: A `ReportUser` object containing the details of the report,
    ///   such as the reporter's ID, the reported user's ID, and the reason for reporting.
    /// - Throws: An error if the reporting operation fails.
    func reportUser(data: ReportUser) async throws
}
