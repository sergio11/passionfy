//
//  MessagingDataSourceError.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// Enum representing errors that can occur in the `MessagingDataSource`.
enum MessagingDataSourceException: Error {
    /// Error indicating that creating a chat failed.
    case chatCreationFailed(message: String, cause: Error?)
    /// Error indicating that the chat was not found.
    case chatNotFound(message: String, cause: Error?)
    /// Error indicating that the provided chat ID is invalid.
    case invalidChatId(message: String, cause: Error?)
    /// Error indicating that sending the message failed.
    case messageSendFailed(message: String, cause: Error?)
    /// Error indicating that the message was not found.
    case messageNotFound(message: String, cause: Error?)
    /// Error indicating that marking a message as read failed.
    case markMessageAsReadFailed(message: String, cause: Error?)
    /// Error indicating that deleting the message failed.
    case messageDeleteFailed(message: String, cause: Error?)
    /// Error indicating that the operation to retrieve messages failed.
    case messagesRetrievalFailed(message: String, cause: Error?)
    /// Error indicating that the deletion of all messages failed.
    case deleteAllMessagesFailed(message: String, cause: Error?)
}
