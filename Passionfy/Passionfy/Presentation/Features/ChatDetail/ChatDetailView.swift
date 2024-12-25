//
//  ChatDetailView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import SwiftUI

struct ChatDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ChatDetailViewModel()
    let chat: Chat
    
    var body: some View {
        VStack {
            // Header
            ChatHeader(
                user: chat.secondUser,
                onBack: {
                    dismiss()
                },
                onOpenUserProfile: {
                    
                },
                onDeleteChat: {
                    
                }
            )
            
            // Messages
            ChatMessagesView(messages: viewModel.messages)
            
            // Input Field
            ChatInputFieldView(
                messageText: $viewModel.messageText,
                onClearTextField: {
                    
                },
                onSendMessage: {
                    
                }
            )
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.loadMessages(for: chat.id)
        }
    }
}

private struct ChatHeader: View {
    
    let user: User
    var onBack: (() -> Void)? = nil
    var onOpenUserProfile: (() -> Void)? = nil
    var onDeleteChat: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            // Back Button
            Button(action: {
                onBack?()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.pink)
            }
            .padding(.trailing, 8)
            
            // User Info
            CircularProfileImageView(profileImageUrl: user.profileImageUrls.first ?? "", size: .medium)
            Text(user.username)
                .customFont(.medium, 18)
                .foregroundColor(.primary)
            
            Spacer()
            
            // Options Menu
            Menu {
                Button("View Profile") {
                    onOpenUserProfile?()
                }
                Button("Mute Notifications", action: {})
                Button("Delete Chat", role: .destructive) {
                    onDeleteChat?()
                }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 18))
                    .foregroundColor(.pink)
            }
        }
        .padding()
        .background(Color.white)
        .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
    }
}

private struct ChatMessagesView: View {
    
    var messages: [ChatMessage] = []
    
    var body: some View {
        // Messages
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(messages) { message in
                    MessageBubble(message: message)
                        .padding(.horizontal)
                }
            }
        }
        .padding(.top)
    }
}

private struct ChatInputFieldView: View {
    
    @Binding var messageText: String
    var onClearTextField: (() -> Void)? = nil
    var onSendMessage: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            TextField("Type a message...", text: $messageText)
                .customFont(.regular, 16)
                .padding(12)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(25)
                .overlay(
                    HStack {
                        Spacer()
                        if !messageText.isEmpty {
                            Button {
                                onClearTextField?()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.pink)
                            }
                            .padding(.trailing, 8)
                        }
                    }
                )
                .padding(.leading)
            
            Button {
                onSendMessage?()
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding()
                    .background(messageText.isEmpty ? Color.pink.opacity(0.4) : Color.pink)
                    .cornerRadius(25)
            }
            .disabled(messageText.isEmpty)
        }
        .padding()
        .background(Color.white)
        .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: -2)
    }
}

// MessageBubble Component
private struct MessageBubble: View {
    var message: ChatMessage
    
    var body: some View {
        HStack {
            if message.senderId == "currentUserId" {
                Spacer()
                Text(message.text)
                    .padding(12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .frame(maxWidth: 300, alignment: .trailing)
            } else {
                Text(message.text)
                    .padding(12)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(20)
                    .frame(maxWidth: 300, alignment: .leading)
                Spacer()
            }
        }
    }
}

