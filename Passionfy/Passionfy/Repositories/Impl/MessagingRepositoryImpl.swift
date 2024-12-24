//
//  MessagingRepositoryImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation

/// An implementation of the `MessagingRepository` protocol that interacts with a messaging data source and handles data transformations via mappers.
/// This class provides methods to manage chat creation, fetching, and deletion, as well as sending and retrieving messages.
/// It maps domain models to data models and vice versa for persistence operations.
///
/// - Note: This implementation relies on various mappers to transform between domain models (e.g., `CreateChat`) and data models (e.g., Firestore models).
internal class MessagingRepositoryImpl: MessagingRepository {
    
    /// The data source for performing messaging-related operations.
    private let messagingDataSource: MessagingDataSource
    
    /// Mapper for transforming `CreateChat` domain models to the data model used by the data source.
    private let createChatMapper: CreateChatMapper
    
    /// Mapper for transforming `CreateChatMessage` domain models to the data model used by the data source.
    private let createChatMessageMapper: CreateChatMessageMapper
    
    /// Mapper for transforming `Chat` data models to the domain model used by the application.
    private let chatMapper: ChatMapper
    
    /// Mapper for transforming `ChatMessage` data models to the domain model used by the application.
    private let chatMessageMapper: ChatMessageMapper
    
    /// Initializes the repository with required dependencies.
    ///
    /// - Parameters:
    ///   - messagingDataSource: The data source that interacts with the messaging service.
    ///   - createChatMapper: The mapper that converts `CreateChat` domain models to data models.
    ///   - createChatMessageMapper: The mapper that converts `CreateChatMessage` domain models to data models.
    ///   - chatMapper: The mapper that converts `Chat` data models to domain models.
    ///   - chatMessageMapper: The mapper that converts `ChatMessage` data models to domain models.
    init(
        messagingDataSource: MessagingDataSource,
        createChatMapper: CreateChatMapper,
        createChatMessageMapper: CreateChatMessageMapper,
        chatMapper: ChatMapper,
        chatMessageMapper: ChatMessageMapper
    ) {
        self.messagingDataSource = messagingDataSource
        self.createChatMapper = createChatMapper
        self.createChatMessageMapper = createChatMessageMapper
        self.chatMapper = chatMapper
        self.chatMessageMapper = chatMessageMapper
    }
    
    /// Creates a new chat in the system and returns the chat's ID.
    ///
    /// - Parameters:
    ///   - data: The `CreateChat` domain model containing the chat data.
    /// - Returns: The ID of the created chat.
    /// - Throws: `MessagingRepositoryError.createChatFailed` if the operation fails.
    func createChat(data: CreateChat) async throws -> String {
        do {
            return try await messagingDataSource.createChat(data: createChatMapper.map(data))
        } catch {
            throw MessagingRepositoryError.createChatFailed(message: error.localizedDescription)
        }
    }
    
    /// Retrieves the list of chats for a given user by their user ID.
    ///
    /// - Parameters:
    ///   - userId: The ID of the user whose chats are being retrieved.
    /// - Returns: A list of `Chat` domain models associated with the user.
    /// - Throws: `MessagingRepositoryError.getChatsFailed` if the operation fails.
    func getChats(forUserId userId: String) async throws -> [Chat] {
        do {
            let chats = try await messagingDataSource.getChats(forUserId: userId)
            return chats.map({ chatMapper.map($0) })
        } catch {
            throw MessagingRepositoryError.getChatsFailed(message: error.localizedDescription)
        }
    }
    
    /// Deletes a chat by its ID.
    ///
    /// - Parameters:
    ///   - chatId: The ID of the chat to be deleted.
    /// - Throws: `MessagingRepositoryError.deleteChatFailed` if the operation fails.
    func deleteChat(chatId: String) async throws {
        do {
            try await messagingDataSource.deleteChat(chatId: chatId)
        } catch {
            throw MessagingRepositoryError.deleteChatFailed(message: error.localizedDescription)
        }
    }
    
    /// Sends a message to an existing chat and returns the message ID.
    ///
    /// - Parameters:
    ///   - data: The `CreateChatMessage` domain model containing the message data.
    /// - Returns: The ID of the sent message.
    /// - Throws: `MessagingRepositoryError.sendMessageFailed` if the operation fails.
    func sendMessage(data: CreateChatMessage) async throws -> String {
        do {
            return try await messagingDataSource.sendMessage(data: createChatMessageMapper.map(data))
        } catch {
            throw MessagingRepositoryError.sendMessageFailed(message: error.localizedDescription)
        }
    }
    
    /// Retrieves the list of messages for a given chat by its chat ID.
    ///
    /// - Parameters:
    ///   - chatId: The ID of the chat whose messages are being retrieved.
    /// - Returns: A list of `ChatMessage` domain models for the specified chat.
    /// - Throws: `MessagingRepositoryError.getMessagesFailed` if the operation fails.
    func getMessages(forChatId chatId: String) async throws -> [ChatMessage] {
        do {
            let messagesData = try await messagingDataSource.getMessages(forChatId: chatId)
            return messagesData.map({ chatMessageMapper.map($0) })
        } catch {
            throw MessagingRepositoryError.getMessagesFailed(message: error.localizedDescription)
        }
    }
    
    /// Deletes a specific message from a chat.
    ///
    /// - Parameters:
    ///   - chatId: The ID of the chat containing the message.
    ///   - messageId: The ID of the message to be deleted.
    /// - Throws: `MessagingRepositoryError.deleteMessageFailed` if the operation fails.
    func deleteMessage(chatId: String, messageId: String) async throws {
        do {
            try await messagingDataSource.deleteMessage(chatId: chatId, messageId: messageId)
        } catch {
            throw MessagingRepositoryError.deleteMessageFailed(message: error.localizedDescription)
        }
    }
    
    /// Deletes all messages from a specific chat.
    ///
    /// - Parameters:
    ///   - chatId: The ID of the chat from which all messages are to be deleted.
    /// - Throws: `MessagingRepositoryError.deleteAllMessagesFailed` if the operation fails.
    func deleteAllMessages(forChatId chatId: String) async throws {
        do {
            try await messagingDataSource.deleteAllMessages(forChatId: chatId)
        } catch {
            throw MessagingRepositoryError.deleteAllMessagesFailed(message: error.localizedDescription)
        }
    }
}

