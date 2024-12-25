//
//  MesssagingDataSource.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// A protocol for managing chat and message data in the messaging system.
protocol MessagingDataSource {

    /// Creates a new chat with the given data.
        /// - Parameter data: The data required to create a new chat, encapsulated in a `CreateChatDTO`.
        /// - Returns: The created chat.
        /// - Throws: An error if the operation fails.
    func createChat(data: CreateChatDTO) async throws -> ChatDTO

    /// Retrieves the list of chats associated with a specific user.
        /// - Parameter userId: The unique identifier of the user.
        /// - Returns: An array of `ChatDTO` objects representing the user's chats.
        /// - Throws: An error if the operation fails.
    func getChats(forUserId userId: String) async throws -> [ChatDTO]

    /// Updates the last message in a chat.
        /// - Parameter data: The data required to update the last message, encapsulated in an `UpdateChatLastMessageDTO`.
        /// - Throws: An error if the operation fails.
    func updateChatLastMessage(data: UpdateChatLastMessageDTO) async throws

    /// Deletes a specific chat.
        /// - Parameter chatId: The unique identifier of the chat to delete.
        /// - Throws: An error if the operation fails.
    func deleteChat(chatId: String) async throws

    /// Sends a message in a specific chat.
       /// - Parameter data: The data required to send a message, encapsulated in a `CreateChatMessageDTO`.
       /// - Returns: The  sent message as a `MessageDTO`.
       /// - Throws: An error if the operation fails.
    func sendMessage(data: CreateChatMessageDTO) async throws -> MessageDTO

    /// Retrieves all messages associated with a specific chat.
        /// - Parameter chatId: The unique identifier of the chat.
        /// - Returns: An array of `MessageDTO` objects representing the messages in the chat.
        /// - Throws: An error if the operation fails.
    func getMessages(forChatId chatId: String) async throws -> [MessageDTO]

    /// Marks a message as read.
        /// - Parameter data: The data required to mark a message as read, encapsulated in a `MarkMessageAsReadDTO`.
        /// - Throws: An error if the operation fails.
    func markMessageAsRead(data: MarkMessageAsReadDTO) async throws

    /// Deletes a specific message in a chat.
        /// - Parameters:
        ///   - chatId: The unique identifier of the chat containing the message.
        ///   - messageId: The unique identifier of the message to delete.
        /// - Throws: An error if the operation fails.
    func deleteMessage(chatId: String, messageId: String) async throws

    /// Deletes all messages in a specific chat.
        /// - Parameter chatId: The unique identifier of the chat.
        /// - Throws: An error if the operation fails.
    func deleteAllMessages(forChatId chatId: String) async throws
    
    /// Counts the number of unread messages from a specific user in a specific chat.
    /// - Parameters:
    ///   - chatId: The unique identifier of the chat.
    ///   - userId: The unique identifier of the user whose messages need to be counted.
    /// - Returns: The count of unread messages from the user.
    /// - Throws: An error if the operation fails.
    func countUnreadMessages(fromUser userId: String, forChatId chatId: String) async throws -> Int
    
    /// Retrieves the unread messages from a specific user in a specific chat.
    /// - Parameters:
    ///   - chatId: The unique identifier of the chat.
    ///   - userId: The unique identifier of the user whose messages need to be retrieved.
    /// - Returns: An array of `MessageDTO` objects representing the unread messages from the user.
    /// - Throws: An error if the operation fails.
    func getUnreadMessages(fromUser userId: String, forChatId chatId: String) async throws -> [MessageDTO]
}

