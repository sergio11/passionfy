//
//  ChatDetailViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import SwiftUI
import Factory
import Combine

class ChatDetailViewModel: BaseViewModel {
    
    
    @Injected(\.deleteChatUseCase) private var deleteChatUseCase: DeleteChatUseCase
    @Injected(\.deleteAllMessageUseCase) private var deleteAllMessageUseCase: DeleteAllMessageUseCase
    @Injected(\.deleteMessageUseCase) private var deleteMessageUseCase: DeleteMessageUseCase
    @Injected(\.getChatMessagesUseCase) private var getChatMessagesUseCase: GetChatMessagesUseCase
    @Injected(\.createChatMessageUseCase) private var createChatMessageUseCase: CreateChatMessageUseCase
    @Injected(\.cancelMatchUseCase) private var cancelMatchUseCase: CancelMatchUseCase
    
    @Published var messageText: String = ""
    @Published var messages: [ChatMessage] = []
    @Published var selectedUser: User? = nil
    @Published var chatDeleted: Bool = false
    
    func loadMessages(for chatId: String) {
        executeAsyncTask {
            return try await self.getChatMessagesUseCase.execute(params: GetChatMessagesParams(chatId: chatId))
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case .success(let chatMessages) = result {
                self.onGetChatMessagesCompleted(chatMessages: chatMessages)
            }
        }
    }
       
    func sendMessage(for chatId: String) {
        executeAsyncTask {
            return try await self.createChatMessageUseCase.execute(params: CreateChatMessageParams(chatId: chatId, text: self.messageText))
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case .success(let chatMessage) = result {
                self.onChatMessagesCreated(chatMessage: chatMessage)
            }
        }
    }
       
    func clearTextField() {
        self.messageText = ""
    }
       
    func onOpenUserProfile(for user: User) {
        self.selectedUser = user
    }
    
    func onDeleteAllMessages(for chatId: String) {
        executeAsyncTask {
            return try await self.deleteAllMessageUseCase.execute(params: DeleteAllMessageParams(chatId: chatId))
        }
    }
    
    func onCancelMatch(for userId: String) {
        executeAsyncTask {
            return try await self.cancelMatchUseCase.execute(params: CancelMatchParams(targetUserId: userId))
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case .success = result {
                self.onMatchCancelled()
            }
        }
    }
    
    func onDeleteMessage(chatId: String, messageId: String) {
        executeAsyncTask {
            return try await self.deleteMessageUseCase.execute(params: DeleteMessageParams(chatId: chatId, messageId: messageId))
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case .success = result {
                self.onChatMessageDeleted(messageId: messageId)
            }
        }
    }
       
    func onDeleteChat(for chatId: String) {
        executeAsyncTask {
            return try await self.deleteChatUseCase.execute(params: DeleteChatParams(chatId: chatId))
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case .success = result {
                self.onChatDeleted()
            }
        }
    }
    
    private func onGetChatMessagesCompleted(chatMessages: [ChatMessage]) {
        self.messages = chatMessages
    }
    
    private func onChatMessagesCreated(chatMessage: ChatMessage) {
        self.messages.append(chatMessage)
        self.messageText = ""
    }
    
    private func onChatDeleted() {
        self.chatDeleted = true
    }
    
    private func onChatMessageDeleted(messageId: String) {
        self.messages = messages.filter({ $0.id != messageId })
    }
    
    private func onMatchCancelled() {
        self.chatDeleted = true
    }
}
