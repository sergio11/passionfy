//
//  ChatDetailView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import SwiftUI

struct ChatDetailView: View {
    
    @StateObject var viewModel = ChatDetailViewModel()
    
    let chat: Chat
    
    var body: some View {
        VStack {
            // Messages View
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.messages) { message in
                        MessageBubble(message: message)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.top)
            
            // Input Field
            HStack {
                TextField("Type a message...", text: $viewModel.messageText)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(25)
                    .padding(.leading)
                
                Button(action: {}) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding(.bottom)
            .background(Color.white)
            .shadow(radius: 5)
        }
        .navigationTitle("Chat with \(chat.secondUser.username)")
        .onAppear {
        }
    }
    
}

private struct MessageBubble: View {
    var message: ChatMessage
    
    var body: some View {
        HStack {
            if message.senderId == "currentUserId" {
                Spacer()
                Text(message.text)
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .frame(maxWidth: 300, alignment: .trailing)
            } else {
                Text(message.text)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .frame(maxWidth: 300, alignment: .leading)
                Spacer()
            }
        }
    }
}

