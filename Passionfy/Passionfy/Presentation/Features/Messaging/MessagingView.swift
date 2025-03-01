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
                .padding(.top)

                Divider().padding(.vertical, 8)
                
                UserChatsView(
                    userChats: viewModel.userChats,
                    onOpenUserProfile: { user in
                        viewModel.onUserSelected(user: user)
                    },
                    onOpenChatDetail: { chat in
                        viewModel.onUserChatSelected(chat: chat)
                    },
                    onDeleteChat: { chat in
                        viewModel.onDeleteUserChat(for: chat.id)
                    }
                )
                
                Spacer()
            }
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
        .fullScreenCover(item: $viewModel.selectedUser) { user in
            UserProfileView(user: user)
        }
        .fullScreenCover(
            item: $viewModel.chatOpened,
            onDismiss: {
                viewModel.loadData()
            }
        ) { chat in
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
                .padding(.horizontal)
            
            if matches.isEmpty {
                EmptyStateViewForMatches()
            } else {
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
}

private struct EmptyStateViewForMatches: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.fill")
                .font(.system(size: 40))
                .foregroundColor(.pink)
            
            Text("It seems you haven't matched with anyone yet... 💖")
                .customFont(.bold, 20)
                .foregroundColor(.pink)
                .multilineTextAlignment(.center)
            
            Text("Swipe, explore, and start finding some amazing people to match with!")
                .customFont(.regular, 16)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

private struct UserChatsView: View {
    
    var userChats: [Chat]
    var onOpenUserProfile: ((User) -> Void)? = nil
    var onOpenChatDetail: ((Chat) -> Void)? = nil
    var onDeleteChat: ((Chat) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Chats")
                .customFont(.bold, 18)
                .foregroundColor(.black)
                .padding(.horizontal)
                .padding(.bottom, 8)
                
            if userChats.isEmpty {
                EmptyStateView()
            } else {
                ForEach(userChats) { chat in
                    ChatCellView(
                        chat: chat,
                        onOpenUserProfile: {
                            onOpenUserProfile?(chat.otherUser)
                        },
                        onOpenChatDetail: {
                            onOpenChatDetail?(chat)
                        },
                        onDeleteChat: {
                            onDeleteChat?(chat)
                        }
                    )
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
