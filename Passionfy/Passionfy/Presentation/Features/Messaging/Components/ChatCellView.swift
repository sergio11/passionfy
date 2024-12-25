//
//  ChatCellView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 25/12/24.
//

import SwiftUI
import SwipeActions

struct ChatCellView: View {
    
    var chat: Chat
    var onOpenUserProfile: (() -> Void)? = nil
    var onOpenChatDetail: (() -> Void)? = nil
    var onDeleteChat: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack(alignment: .topTrailing) {
                CircularProfileImageView(
                    profileImageUrl: chat.otherUser.profileImageUrls[0],
                    size: .medium,
                    allowShadow: true
                )
                .onTapGesture {
                    onOpenUserProfile?()
                }
                
                if chat.unreadMessagesCount > 0 {
                    Text("\(chat.unreadMessagesCount)")
                        .customFont(.bold, 12)
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Circle().fill(Color.pink))
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .offset(x: 8, y: -8)
                }
            }
            
            VStack(alignment: .leading) {
                Text(chat.otherUser.username)
                    .customFont(.bold, 16)
                    .foregroundColor(.black)
                
                Text(chat.lastMessage.isEmpty ? "No messages yet. Say hi and break the ice!" : chat.lastMessage)
                    .customFont(.regular, 14)
                    .foregroundColor(chat.unreadMessagesCount > 0 ? .pink : .gray)
                    .fontWeight(chat.unreadMessagesCount > 0 ? .bold : .regular)
                    .lineLimit(2)
                    .truncationMode(.tail)
            }
            Spacer()
            
            Text(chat.updatedAt.timeAgo())
                .customFont(.regular, 12)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(chat.unreadMessagesCount > 0 ? Color(white: 0.95) : Color.white)
        .addSwipeAction(edge: .trailing) {
            Button {
                onDeleteChat?()
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.white)
                    .imageScale(.large)
            }
            .frame(width: 120, height: 100, alignment: .center)
            .contentShape(Rectangle())
            .background(Color.red)
        }
        .onTapGesture {
            onOpenChatDetail?()
        }
    }
}
