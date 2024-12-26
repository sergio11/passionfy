//
//  ReportedUsersRepositoryImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import Foundation

/// Implementation of the repository for managing reported users.
///
/// This class handles operations related to reporting users, using the `ReportedUsersDataSource` to access the database and the `ReportUserMapper` to transform the data.
internal class ReportedUsersRepositoryImpl: ReportedUsersRepository {
    
    /// Data source for managing reported users.
    private let reportedUsersDataSource: ReportedUsersDataSource
    
    /// Mapper for transforming the report data before sending it to the data source.
    private let reportUserMapper: ReportUserMapper
    
    /// Initializes the implementation of the reported users repository.
    /// - Parameters:
    ///   - reportedUsersDataSource: The data source used to handle reports in the database.
    ///   - reportUserMapper: The mapper that transforms the report data.
    init(reportedUsersDataSource: ReportedUsersDataSource, reportUserMapper: ReportUserMapper) {
        self.reportedUsersDataSource = reportedUsersDataSource
        self.reportUserMapper = reportUserMapper
    }
    
    /// Reports a user.
    ///
    /// This method takes the report data, transforms it using the mapper, and then sends it to the `ReportedUsersDataSource` for storage.
    /// If an error occurs during the process, a specific report user exception is thrown.
    /// - Parameter data: The report data of the user to be reported.
    /// - Throws: Throws a `ReportedUsersException.reportUserFailed` exception if an error occurs when reporting the user.
    func reportUser(data: ReportUser) async throws {
        do {
            try await reportedUsersDataSource.reportUser(data: reportUserMapper.map(data))
        } catch {
            throw ReportedUsersException.reportUserFailed(message: "An error occurred when trying to report user", cause: error)
        }
    }
}
