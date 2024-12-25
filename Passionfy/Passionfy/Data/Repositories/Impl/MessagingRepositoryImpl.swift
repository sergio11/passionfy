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
    
    /// The data source for performing users-related operations.
    private let userDataSource: UserDataSource
    
    /// The data source for performing auth-related operations.
    private let authDataSource: AuthenticationDataSource
    
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
    ///   - userDataSource: The data source that interacts with the users service.
    ///   - authDataSource: The data source that interacts with the authentication service.
    ///   - createChatMapper: The mapper that converts `CreateChat` domain models to data models.
    ///   - createChatMessageMapper: The mapper that converts `CreateChatMessage` domain models to data models.
    ///   - chatMapper: The mapper that converts `Chat` data models to domain models.
    ///   - chatMessageMapper: The mapper that converts `ChatMessage` data models to domain models.
    init(
        messagingDataSource: MessagingDataSource,
        userDataSource: UserDataSource,
        authDataSource: AuthenticationDataSource,
        createChatMapper: CreateChatMapper,
        createChatMessageMapper: CreateChatMessageMapper,
        chatMapper: ChatMapper,
        chatMessageMapper: ChatMessageMapper
    ) {
        self.messagingDataSource = messagingDataSource
        self.userDataSource = userDataSource
        self.authDataSource = authDataSource
        self.createChatMapper = createChatMapper
        self.createChatMessageMapper = createChatMessageMapper
        self.chatMapper = chatMapper
        self.chatMessageMapper = chatMessageMapper
    }
    
    /// Creates a new chat in the system and returns the chat's ID.
    ///
    /// - Parameters:
    ///   - data: The `CreateChat` domain model containing the chat data.
    /// - Returns: The created chat.
    /// - Throws: `MessagingRepositoryError.createChatFailed` if the operation fails.
    func createChat(data: CreateChat) async throws -> Chat {
        do {
            let chatDTO = try await messagingDataSource.createChat(data: createChatMapper.map(data))
            guard let chat = try await mapSingleChat(for: chatDTO) else {
                throw MessagingException.createChatFailed(message: "An error ocurred when creating the chat", cause: nil)
            }
            return chat
        } catch {
            throw MessagingException.createChatFailed(message: "An error ocurred when creating the chat", cause: error)
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
            return try await mapUserChats(for: chats)
        } catch {
            throw MessagingException.getChatsFailed(message: "An error ocurred when trying to get chats", cause: error)
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
            throw MessagingException.deleteChatFailed(message: "An error ocurred when trying to delete chat", cause: error)
        }
    }
    
    /// Sends a message to an existing chat and returns the message ID.
    ///
    /// - Parameters:
    ///   - data: The `CreateChatMessage` domain model containing the message data.
    /// - Returns: The sent message.
    /// - Throws: `MessagingRepositoryError.sendMessageFailed` if the operation fails.
    func sendMessage(data: CreateChatMessage) async throws -> ChatMessage {
        do {
            let authUserId = try await authDataSource.getCurrentUserId()
            let chatMessageDTO = try await messagingDataSource.sendMessage(data: createChatMessageMapper.map(data))
            return chatMessageMapper.map(ChatMessageDataMapper(messageDTO: chatMessageDTO, authUserId: authUserId))
        } catch {
            throw MessagingException.sendMessageFailed(message: "An error ocurred when trying to send a message", cause: error)
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
            let authUserId = try await authDataSource.getCurrentUserId()
            let messagesData = try await messagingDataSource.getMessages(forChatId: chatId)
            let unReadMessages = messagesData.filter({ !$0.isRead && $0.senderId != authUserId })
            for unReadMessage in unReadMessages {
                try await messagingDataSource.markMessageAsRead(data: MarkMessageAsReadDTO(chatId: chatId, messageId: unReadMessage.id))
            }
            return messagesData.map({ chatMessageMapper.map(ChatMessageDataMapper(messageDTO: $0, authUserId: authUserId)) })
        } catch {
            throw MessagingException.getMessagesFailed(message: "An error ocurred when trying to get messages", cause: error)
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
            throw MessagingException.deleteMessageFailed(message: "An error ocurred when trying to delete a message", cause: error)
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
            throw MessagingException.deleteAllMessagesFailed(message: "An error ocurred when trying to delete all messages", cause: error)
        }
    }
    
    private func mapSingleChat(for chatDTO: ChatDTO) async throws -> Chat? {
        // Cache to track user profiles during this operation
        var userCache: [String: UserDTO] = [:]

        // Helper function to fetch user profile by ID and cache it
        func getUserProfile(userId: String) async throws -> UserDTO? {
            if let cachedUser = userCache[userId] {
                return cachedUser
            }
            do {
                let userDTO = try await userDataSource.getUserById(userId: userId)
                userCache[userId] = userDTO
                return userDTO
            } catch {
                print("Failed to fetch user profile for userId: \(userId), error: \(error.localizedDescription)")
                return nil
            }
        }
        
        let authUserId = try await authDataSource.getCurrentUserId()

        guard let firstUserDTO = try await getUserProfile(userId: chatDTO.firstUserId),
              let secondUserDTO = try await getUserProfile(userId: chatDTO.secondUserId) else {
            return nil
        }
        
        let unreadMessageCount = try await messagingDataSource.countUnreadMessages(fromUser: chatDTO.firstUserId == authUserId ? chatDTO.secondUserId : chatDTO.firstUserId, forChatId: chatDTO.id)
        
        let chatDataMapper = ChatDataMapper(
            chatDTO: chatDTO,
            firstUserDTO: firstUserDTO,
            secondUserDTO: secondUserDTO,
            authUserId: authUserId,
            unreadMessageCount: unreadMessageCount
        )

        return chatMapper.map(chatDataMapper)
    }

    private func mapUserChats(for chats: [ChatDTO]) async throws -> [Chat] {
        var userChats = [Chat]()

        for chatDTO in chats {
            if let chat = try await mapSingleChat(for: chatDTO) {
                userChats.append(chat)
            }
        }

        return userChats
    }
}

