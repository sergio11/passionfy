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
    
    @Published var messageText: String = ""
    @Published var messages: [ChatMessage] = []
    @Published var selectedUser: User? = nil
    
    func loadMessages(for chatId: String) {
        // Load messages logic here
    }
       
    func sendMessage() {
        // Send message logic here
    }
       
    func clearTextField() {
        messageText = ""
    }
       
    func onOpenUserProfile(for user: User) {
        self.selectedUser = user
    }
       
    func muteChat() {
        // Mute chat logic here
    }
       
    func deleteChat() {
        // Delete chat logic here
    }
}
