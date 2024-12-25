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
    
    func loadMessages(for chatId: String) {
        // Load messages logic here
    }
       
    func sendMessage() {
        // Send message logic here
    }
       
    func clearTextField() {
        messageText = ""
    }
       
    func viewUserProfile() {
        // View user profile logic here
    }
       
    func muteChat() {
        // Mute chat logic here
    }
       
    func deleteChat() {
        // Delete chat logic here
    }
}
