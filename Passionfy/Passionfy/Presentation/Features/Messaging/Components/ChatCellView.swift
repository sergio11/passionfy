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
            CircularProfileImageView(
                profileImageUrl: chat.otherUser.profileImageUrls[0],
                size: .medium,
                allowShadow: true
            ).onTapGesture {
                onOpenUserProfile?()
            }
            
            VStack(alignment: .leading) {
                Text(chat.otherUser.username)
                    .customFont(.bold, 16)
                    .foregroundColor(.black)
                
                Text(chat.lastMessage.isEmpty ? "No messages yet. Say hi and break the ice!": chat.lastMessage)
                    .customFont(.regular, 14)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            Spacer()
            
            Text(chat.updatedAt.timeAgo())
                .customFont(.regular, 12)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.white)
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
        }.onTapGesture {
            onOpenChatDetail?()
        }
    }
}
