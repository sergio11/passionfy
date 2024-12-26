//
//  ReportedUsersRepositoryImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import Foundation

/// Implementation of the repository for managing reported users.
///
/// This class is responsible for handling operations related to reporting users, such as submitting a report and taking actions like canceling matches and deleting chats/messages.
/// It interacts with the data sources (`ReportedUsersDataSource`, `MessagingDataSource`, `UserMatchDataSource`) and uses a mapper (`ReportUserMapper`) to transform the report data.
internal class ReportedUsersRepositoryImpl: ReportedUsersRepository {
    
    // MARK: - Properties

    /// The data source used to store reported user information.
    private let reportedUsersDataSource: ReportedUsersDataSource
    
    /// The data source used to interact with the messaging system (for deleting chats and messages).
    private let messagingDataSource: MessagingDataSource
    
    /// The data source used for handling user matches (to cancel the match between the reporter and the reported user).
    private let userMatchDataSource: UserMatchDataSource
    
    /// The mapper used to transform `ReportUser` data into the format expected by the `reportedUsersDataSource`.
    private let reportUserMapper: ReportUserMapper
    
    // MARK: - Initializer

    /// Initializes a new `ReportedUsersRepositoryImpl` with the required data sources and mapper.
    ///
    /// - Parameters:
    ///   - reportedUsersDataSource: The data source for handling reported users.
    ///   - messagingDataSource: The data source for handling messaging-related actions.
    ///   - userMatchDataSource: The data source for handling user match actions.
    ///   - reportUserMapper: The mapper for transforming `ReportUser` data.
    init(reportedUsersDataSource: ReportedUsersDataSource, messagingDataSource: MessagingDataSource, userMatchDataSource: UserMatchDataSource, reportUserMapper: ReportUserMapper) {
        self.reportedUsersDataSource = reportedUsersDataSource
        self.messagingDataSource = messagingDataSource
        self.userMatchDataSource = userMatchDataSource
        self.reportUserMapper = reportUserMapper
    }
    
    // MARK: - Methods
    
    /// Reports a user for inappropriate behavior.
    ///
    /// This method processes the report by first transforming the data with the `reportUserMapper`
    /// and then sending it to the `ReportedUsersDataSource` to store the report. Additionally,
    /// it cancels any existing match between the reporter and the reported user and deletes
    /// the chat and messages between them using the respective data sources.
    /// If any error occurs during this process, a `ReportedUsersException.reportUserFailed` exception is thrown.
    ///
    /// - Parameter data: A `ReportUser` object containing the details of the report, including the reporter's and reported user's IDs.
    /// - Throws: A `ReportedUsersException.reportUserFailed` exception if an error occurs during any of the steps in the reporting process.
    func reportUser(data: ReportUser) async throws {
        do {
            try await reportedUsersDataSource.reportUser(data: reportUserMapper.map(data))
            try await userMatchDataSource.cancelMatch(userId: data.reporterId, targetUserId: data.reportedId)
            try await messagingDataSource.deleteChatAndMessages(forUserId: data.reporterId, targetUserId: data.reportedId)
        } catch {
            throw ReportedUsersException.reportUserFailed(message: "An error occurred when trying to report user", cause: error)
        }
    }
}
