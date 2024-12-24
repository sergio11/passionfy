//
//  MessagingView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI

struct MessagingView: View {
    
    @StateObject var viewModel = MessagingViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                NewMatchesView(newMatches: viewModel.userMatches)
                    .padding(.top, 16)

                Divider().padding(.vertical, 8)
                
                UserChatsView(userChats: viewModel.userChats)
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Messaging")
                        .customFont(.bold, 22)
                        .foregroundColor(.pink)
                }
            }
            .onAppear {
                viewModel.loadData()
            }
        }
        .modifier(LoadingAndMessageOverlayModifier(
            isLoading: $viewModel.isLoading,
            message: viewModel.message,
            messageType: viewModel.messageType
        ))
        .fullScreenCover(item: $viewModel.selectedUser) { user in
            UserProfileView(user: user)
        }
    }
}

private struct NewMatchesView: View {
    
    var newMatches: [User]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("New Matches")
                .customFont(.bold, 18)
                .foregroundColor(.black)
                .padding(.bottom, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(newMatches) { match in
                        VStack {
                            Spacer()
                            
                            CircularProfileImageView(
                                profileImageUrl: match.profileImageUrls[0],
                                size: .xLarge,
                                allowShadow: false
                            )
                            .padding(4)
                            .background(
                                Circle()
                                    .fill(Color.white)
                            )
                            .overlay(Circle().stroke(Color.pink, lineWidth: 2))

                            Text(match.username)
                                .customFont(.medium, 16)
                                .lineLimit(1)
                                .foregroundColor(.gray)
                            
                            Spacer()
                        }
                        .padding(.leading, match.id == newMatches.first?.id ? 16 : 0)
                        .padding(.bottom, 4)
                    }
                }
            }
            .frame(height: 140)

        }
    }
}

private struct UserChatsView: View {
    
    var userChats: [Chat]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Chats")
                .customFont(.bold, 18)
                .foregroundColor(.black)
                .padding(.bottom, 8)
            
            ForEach(userChats) { chat in
                NavigationLink(destination: ChatDetailView(chat: chat)) {
                    ChatRowView(chat: chat)
                }
                .padding(.bottom, 8)
            }
        }
    }
}

private struct ChatRowView: View {
    
    var chat: Chat
    
    var body: some View {
        HStack {
            CircularProfileImageView(
                profileImageUrl: chat.firstUser.profileImageUrls[0],
                size: .medium,
                allowShadow: true
            )
            
            VStack(alignment: .leading) {
                Text(chat.firstUser.username)
                    .customFont(.bold, 16)
                    .foregroundColor(.black)
                Text(chat.lastMessage ?? "No messages yet")
                    .customFont(.regular, 14)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            Spacer()
            
            if let timeAgo = chat.updatedAt.toDate()?.timeAgo() {
                Text(chat.updatedAt)
                    .customFont(.regular, 12)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(
            Color.white
                .cornerRadius(12)
                .shadow(radius: 4)
        )
        .padding(.horizontal)
    }
}


// Previews
struct MessagingView_Previews: PreviewProvider {
    static var previews: some View {
        MessagingView()
    }
}
