//
//  MessagingRepository.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// A protocol that defines the operations related to managing chats and messages.
protocol MessagingRepository {

    /// Creates a new chat.
    ///
    /// - Parameter data: The data used to create the chat (e.g., participants and chat details).
    /// - Returns: A `Chat` representing the chat model
    /// - Throws: A `MessagingRepositoryError` if the chat creation fails.
    func createChat(data: CreateChat) async throws -> Chat

    /// Retrieves all chats for a specific user.
    ///
    /// - Parameter userId: The ID of the user whose chats are to be retrieved.
    /// - Returns: An array of `Chat` objects containing the user's chat information.
    /// - Throws: A `MessagingRepositoryError` if retrieving the chats fails.
    func getChats(forUserId userId: String) async throws -> [Chat]

    /// Deletes a specific chat by its ID.
    ///
    /// - Parameter chatId: The ID of the chat to be deleted.
    /// - Throws: A `MessagingRepositoryError` if deleting the chat fails.
    func deleteChat(chatId: String) async throws

    /// Sends a message within a specific chat.
    ///
    /// - Parameter data: The data used to create the message (e.g., message content, sender).
    /// - Returns: A `ChatMessage` representing the  sent message.
    /// - Throws: A `MessagingRepositoryError` if sending the message fails.
    func sendMessage(data: CreateChatMessage) async throws -> ChatMessage

    /// Retrieves all messages within a specific chat.
    ///
    /// - Parameter chatId: The ID of the chat whose messages are to be retrieved.
    /// - Returns: An array of `ChatMessage` objects containing the chat's messages.
    /// - Throws: A `MessagingRepositoryError` if retrieving the messages fails.
    func getMessages(forChatId chatId: String) async throws -> [ChatMessage]

    /// Deletes a specific message by its ID within a chat.
    ///
    /// - Parameters:
    ///   - chatId: The ID of the chat where the message exists.
    ///   - messageId: The ID of the message to be deleted.
    /// - Throws: A `MessagingRepositoryError` if deleting the message fails.
    func deleteMessage(chatId: String, messageId: String) async throws

    /// Deletes all messages within a specific chat.
    ///
    /// - Parameter chatId: The ID of the chat whose messages are to be deleted.
    /// - Throws: A `MessagingRepositoryError` if deleting the messages fails.
    func deleteAllMessages(forChatId chatId: String) async throws
}
