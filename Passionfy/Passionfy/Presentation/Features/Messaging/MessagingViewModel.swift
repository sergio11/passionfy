//
//  MessagingViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import SwiftUI
import Factory
import Combine

class MessagingViewModel: BaseViewModel {
    
    @Injected(\.deleteChatUseCase) private var deleteChatUseCase: DeleteChatUseCase
    @Injected(\.getUserMatchesUseCase) private var getUserMatchesUseCase: GetUserMatchesUseCase
    @Injected(\.getUserChatsUseCase) private var getUserChatsUseCase: GetUserChatsUseCase
    @Injected(\.createChatUseCase) private var createChatUseCase: CreateChatUseCase
    
    @Published var chatOpened: Chat? = nil
    @Published var userChats: [Chat] = []
    @Published var userMatches: [User] = []
    
    func loadData() {
        loadUserMatches()
        loadUserChats()
    }
    
    func onUserChatSelected(chat: Chat) {
        self.chatOpened =  chat
    }
    
    func onUserMatchSelected(user: User) {
        if let userChat = userChats.first(where: { $0.currentUser.id == user.id || $0.otherUser.id == user.id }) {
            self.chatOpened =  userChat
        } else {
            executeAsyncTask {
                return try await self.createChatUseCase.execute(params: CreateChatParams(targetUserId: user.id))
            } completion: { [weak self] result in
                guard let self = self else { return }
                if case .success(let chatCreated) = result {
                    self.chatOpened =  chatCreated
                }
            }
        }
    }
    
    private func loadUserMatches() {
        executeAsyncTask {
            return try await self.getUserMatchesUseCase.execute()
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case .success(let userMatches) = result {
                self.onGetUserMatchesCompleted(userMatches: userMatches)
            }
        }
    }
    
    private func loadUserChats() {
        executeAsyncTask {
            return try await self.getUserChatsUseCase.execute()
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case .success(let userChats) = result {
                self.onGetUserChatsCompleted(userChats: userChats)
            }
        }
    }
    
    private func onGetUserMatchesCompleted(userMatches: [User]) {
        self.userMatches = userMatches
    }
    
    private func onGetUserChatsCompleted(userChats: [Chat]) {
        self.userChats = userChats
    }
}
