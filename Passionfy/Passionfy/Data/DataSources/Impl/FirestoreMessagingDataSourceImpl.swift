//
//  FirestoreMessagingDataSourceImpl.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import Foundation
import Firebase

/// A data source for managing chat and message data in Firestore.
internal class FirestoreMessagingDataSourceImpl: MessagingDataSource {

    private let chatsCollection = "passionfy_chats"
    private let messagesCollection = "passionfy_messages"
    private let messagesCollectionSub = "messages"

    /// Creates a new chat with the given data.
    /// - Parameter data: The data required to create a new chat, encapsulated in a `CreateChatDTO`.
    /// - Returns: The created `ChatDTO` object.
    /// - Throws: An error if the operation fails.
    func createChat(data: CreateChatDTO) async throws -> ChatDTO {
        do {
            let collection = Firestore.firestore()
                .collection(chatsCollection)
            try await collection
                .document(data.chatId)
                .setData(data.asDictionary())
            
            let chatDocumentSnapshot = try await collection
                .document(data.chatId)
                .getDocument()
            
            if let chatDTO = try? chatDocumentSnapshot.data(as: ChatDTO.self) {
                return chatDTO
            } else {
                throw MessagingDataSourceException.chatNotFound(message: "Chat creation failed, no data found for chatId: \(data.chatId)", cause: nil)
            }
        } catch {
            throw MessagingDataSourceException.chatCreationFailed(message: "Error creating chat: \(error.localizedDescription)", cause: error)
        }
    }

    /// Retrieves the list of chats associated with a specific user.
        /// - Parameter userId: The unique identifier of the user.
        /// - Returns: An array of `ChatDTO` objects representing the user's chats.
        /// - Throws: An error if the operation fails.
    func getChats(forUserId userId: String) async throws -> [ChatDTO] {
        do {
            let querySnapshot = try await Firestore.firestore()
                .collection(chatsCollection)
                .whereField("participantIds", arrayContains: userId)
                .getDocuments()
            return querySnapshot.documents.compactMap { try? $0.data(as: ChatDTO.self) }
        } catch {
            print("Error getting chat: \(error.localizedDescription)")
            throw MessagingDataSourceException.chatNotFound(message: "Error getting chat: \(error.localizedDescription)", cause: error)
        }
    }

    /// Updates the last message in a chat.
        /// - Parameter data: The data required to update the last message, encapsulated in an `UpdateChatLastMessageDTO`.
        /// - Throws: An error if the operation fails.
    func updateChatLastMessage(data: UpdateChatLastMessageDTO) async throws {
        do {
            try await Firestore.firestore()
                .collection(chatsCollection)
                .document(data.chatId)
                .updateData(data.asDictionary())
        } catch {
            print("Error updating chat last message: \(error.localizedDescription)")
            throw MessagingDataSourceException.chatNotFound(message: "Error updating chat last message: \(error.localizedDescription)", cause: error)
        }
    }

    /// Deletes a specific chat.
        /// - Parameter chatId: The unique identifier of the chat to delete.
        /// - Throws: An error if the operation fails.
    func deleteChat(chatId: String) async throws {
        do {
            try await Firestore.firestore()
                .collection(chatsCollection)
                .document(chatId)
                .delete()
            
            try await deleteAllMessages(forChatId: chatId)
        } catch {
            print("Error deleting chat: \(error.localizedDescription)")
            throw MessagingDataSourceException.chatNotFound(message: "Error deleting chat: \(error.localizedDescription)", cause: error)
        }
    }

    /// Sends a message in a specific chat.
       /// - Parameter data: The data required to send a message, encapsulated in a `CreateChatMessageDTO`.
       /// - Returns: The sent message as a `MessageDTO`.
       /// - Throws: An error if the operation fails.
    func sendMessage(data: CreateChatMessageDTO) async throws -> MessageDTO {
        do {
            
            let collection = Firestore.firestore()
                .collection(messagesCollection)
            
            try await collection
                .document(data.chatId)
                .collection(messagesCollectionSub)
                .document(data.messageId)
                .setData(data.asDictionary())
            
            try await updateChatLastMessage(data: UpdateChatLastMessageDTO(
                chatId: data.chatId,
                lastMessage: data.text,
                userId: data.senderId
            ))
            
            let chatMessageDocumentSnapshot = try await collection
                .document(data.chatId)
                .collection(messagesCollectionSub)
                .document(data.messageId)
                .getDocument()
            
            if let messageDTO = try? chatMessageDocumentSnapshot.data(as: MessageDTO.self) {
                return messageDTO
            } else {
                throw MessagingDataSourceException.messageSendFailed(message: "Error sending message", cause: nil)
            }
        } catch {
            print("Error sending message: \(error.localizedDescription)")
            throw MessagingDataSourceException.messageSendFailed(message: "Error sending message: \(error.localizedDescription)", cause: error)
        }
    }

    /// Retrieves all messages associated with a specific chat.
        /// - Parameter chatId: The unique identifier of the chat.
        /// - Returns: An array of `MessageDTO` objects representing the messages in the chat.
        /// - Throws: An error if the operation fails.
    func getMessages(forChatId chatId: String) async throws -> [MessageDTO] {
        do {
            let querySnapshot = try await Firestore.firestore()
                .collection(messagesCollection)
                .document(chatId)
                .collection(messagesCollectionSub)
                .order(by: "createdAt", descending: false)
                .getDocuments()
  
            return querySnapshot.documents.compactMap { try? $0.data(as: MessageDTO.self) }
        } catch {
            print("Error getting message: \(error.localizedDescription)")
            throw MessagingDataSourceException.messagesRetrievalFailed(message: "Error getting message: \(error.localizedDescription)", cause: error)
        }
    }

    /// Marks a message as read.
        /// - Parameter data: The data required to mark a message as read, encapsulated in a `MarkMessageAsReadDTO`.
        /// - Throws: An error if the operation fails.
    func markMessageAsRead(data: MarkMessageAsReadDTO) async throws {
        do {
            try await Firestore.firestore()
                .collection(messagesCollection)
                .document(data.chatId)
                .collection(messagesCollectionSub)
                .document(data.messageId)
                .updateData(["isRead": true])
        } catch {
            print("Error marking message as read: \(error.localizedDescription)")
            throw MessagingDataSourceException.markMessageAsReadFailed(message: "Error marking message as read: \(error.localizedDescription)", cause: error)
        }
    }

    /// Deletes a specific message in a chat.
        /// - Parameters:
        ///   - chatId: The unique identifier of the chat containing the message.
        ///   - messageId: The unique identifier of the message to delete.
        /// - Throws: An error if the operation fails.
    func deleteMessage(chatId: String, messageId: String) async throws {
        do {
            try await Firestore.firestore()
                .collection(messagesCollection)
                .document(chatId)
                .collection(messagesCollectionSub)
                .document(messageId)
                .delete()
        } catch {
            print("Error deleting message: \(error.localizedDescription)")
            throw MessagingDataSourceException.messageDeleteFailed(message: "Error deleting message: \(error.localizedDescription)", cause: error)
        }
    }

    /// Deletes all messages in a specific chat.
        /// - Parameter chatId: The unique identifier of the chat.
        /// - Throws: An error if the operation fails.
    func deleteAllMessages(forChatId chatId: String) async throws {
        do {
            let messages = try await getMessages(forChatId: chatId)
            for message in messages {
                try await deleteMessage(chatId: chatId, messageId: message.id)
            }
        } catch {
            print("Error deleting all messages: \(error.localizedDescription)")
            throw MessagingDataSourceException.deleteAllMessagesFailed(message: "Error deleting all messages: \(error.localizedDescription)", cause: error)
        }
    }
}

