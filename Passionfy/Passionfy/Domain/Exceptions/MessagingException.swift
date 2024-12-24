//
//  MessagingRepositoryError.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// Enum representing errors that may occur in the `MessagingRepository`.
enum MessagingException: Error {
    
    /// An error that occurs when creating a chat fails.
    case createChatFailed(message: String, cause: Error?)
    
    /// An error that occurs when retrieving chats fails.
    case getChatsFailed(message: String, cause: Error?)
    
    /// An error that occurs when deleting a chat fails.
    case deleteChatFailed(message: String, cause: Error?)
    
    /// An error that occurs when sending a message fails.
    case sendMessageFailed(message: String, cause: Error?)
    
    /// An error that occurs when retrieving messages fails.
    case getMessagesFailed(message: String, cause: Error?)
    
    /// An error that occurs when deleting a specific message fails.
    case deleteMessageFailed(message: String, cause: Error?)
    
    /// An error that occurs when deleting all messages in a chat fails.
    case deleteAllMessagesFailed(message: String, cause: Error?)
}
