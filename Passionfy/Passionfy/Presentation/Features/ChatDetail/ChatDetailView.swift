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
                user: chat.otherUser,
                onBack: {
                    dismiss()
                },
                onOpenUserProfile: {
                    viewModel.onOpenUserProfile(for: chat.otherUser)
                },
                onDeleteAllMessages: {
                    viewModel.onDeleteAllMessages(for: chat.id)
                },
                onDeleteChat: {
                    viewModel.onDeleteChat(for: chat.id)
                }
            )
            
            // Messages
            ChatMessagesView(messages: viewModel.messages) { messageId in
                viewModel.onDeleteMessage(chatId: chat.id, messageId: messageId)
            }
            
            // Input Field
            ChatInputFieldView(
                messageText: $viewModel.messageText,
                onClearTextField: {
                    viewModel.clearTextField()
                },
                onSendMessage: {
                    viewModel.sendMessage(for: chat.id)
                }
            )
        }
        .navigationBarHidden(true)
        .onReceive(viewModel.$chatDeleted) { chatDeleted in
            if chatDeleted {
                dismiss()
            }
        }
        .fullScreenCover(item: $viewModel.selectedUser) { user in
            UserProfileView(user: user)
        }
        .modifier(LoadingAndMessageOverlayModifier(
            isLoading: $viewModel.isLoading,
            message: viewModel.message,
            messageType: viewModel.messageType
        ))
        .onAppear {
            viewModel.loadMessages(for: chat.id)
        }
    }
}

private struct ChatHeader: View {
    
    let user: User
    var onBack: (() -> Void)? = nil
    var onOpenUserProfile: (() -> Void)? = nil
    var onDeleteAllMessages: (() -> Void)? = nil
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
                Button("Delete All Messages", role: .destructive) {
                    onDeleteAllMessages?()
                }
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
    var onDeleteMessage: ((String) -> Void)? = nil
    
    var body: some View {
        ScrollView {
            if !messages.isEmpty {
                LazyVStack(spacing: 10) {
                    ForEach(messages) { message in
                        MessageBubble(message: message) {
                            onDeleteMessage?(message.id)
                        }
                        .padding(.horizontal)
                    }
                }
            } else {
                VStack(spacing: 20) {
                    Image("onboarding_account_logo")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.pink.opacity(0.8))
                        .frame(width: 250, height: 150)
                        .scaledToFit()
                    
                    Text("Break the ice!")
                        .customFont(.bold, 22)
                        .foregroundColor(.pink)
                    
                    Text("Say hello and start a conversation. Remember to be kind and make a great first impression!")
                        .customFont(.regular, 16)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
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

private struct MessageBubble: View {
    var message: ChatMessage
    var onDelete: (() -> Void)?
    
    var body: some View {
        HStack(alignment: .bottom) {
            if message.createByAuthUser {
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    // Message Text
                    Text(message.text)
                        .customFont(.regular, 16)
                        .padding(12)
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .frame(maxWidth: 300, alignment: .trailing)
                    
                    // Time Ago and Read Status
                    HStack(spacing: 5) {
                        Text(message.createdAt.timeAgo())
                            .customFont(.regular, 12)
                            .foregroundColor(.pink.opacity(0.8))
                        
                        if message.isRead {
                            Image(systemName: "checkmark.double")
                                .font(.caption)
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "checkmark")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .contextMenu {
                    Button(action: {
                        onDelete?()
                    }) {
                        Label("Delete", systemImage: "trash.fill")
                    }
                }
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    // Message Text
                    Text(message.text)
                        .customFont(.regular, 16)
                        .padding(12)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                        .frame(maxWidth: 300, alignment: .leading)
                    
                    // Time Ago
                    Text(message.createdAt.timeAgo())
                        .customFont(.regular, 12)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .contextMenu {
                    Button(action: {
                        onDelete?()
                    }) {
                        Label("Delete", systemImage: "trash.fill")
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

