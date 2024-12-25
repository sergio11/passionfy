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
                UserMatchesView(matches: viewModel.userMatches) { userMatch in
                    viewModel.onUserMatchSelected(user: userMatch)
                }
                .padding(.top, 8)

                Divider().padding(.vertical, 8)
                
                UserChatsView(userChats: viewModel.userChats) { chat in
                    viewModel.onUserChatSelected(chat: chat)
                }
                
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
        }
        .modifier(LoadingAndMessageOverlayModifier(
            isLoading: $viewModel.isLoading,
            message: viewModel.message,
            messageType: viewModel.messageType
        ))
        .fullScreenCover(item: $viewModel.chatOpened) { chat in
            ChatDetailView(chat: chat)
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}

private struct UserMatchesView: View {
    
    var matches: [User]
    var onMatchClicked: ((User) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Matches")
                .customFont(.bold, 18)
                .foregroundColor(.black)
                .padding(.bottom, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(matches) { match in
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
                        .padding(.leading, match.id == matches.first?.id ? 16 : 0)
                        .padding(.bottom, 4)
                        .onTapGesture {
                            onMatchClicked?(match)
                        }
                    }
                }
            }
            .frame(height: 140)
        }
    }
}

private struct UserChatsView: View {
    
    var userChats: [Chat]
    var onChatClicked: ((Chat) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Chats")
                .customFont(.bold, 18)
                .foregroundColor(.black)
                .padding(.bottom, 8)
            
            if userChats.isEmpty {
                EmptyStateView()
            } else {
                ForEach(userChats) { chat in
                    ChatCellView(chat: chat) {
                        onChatClicked?(chat)
                    }
                    .padding(.vertical, 4)
                    .background(Divider(), alignment: .bottom)
                }
            }
        }
    }
}


private struct EmptyStateView: View {
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "bubble.left.and.bubble.right.fill")
                .font(.system(size: 40))
                .foregroundColor(.pink)
            
            Text("Your inbox is feeling a little lonely. 💌")
                .customFont(.bold, 20)
                .foregroundColor(.pink)
                .multilineTextAlignment(.center)
            
            Text("Start a conversation or keep exploring to find someone worth chatting with!")
                .customFont(.regular, 16)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

// Previews
struct MessagingView_Previews: PreviewProvider {
    static var previews: some View {
        MessagingView()
    }
}
