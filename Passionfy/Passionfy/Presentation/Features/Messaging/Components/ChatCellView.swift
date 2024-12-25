//
//  ChatCellView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 25/12/24.
//

import SwiftUI

struct ChatCellView: View {
    
    var chat: Chat
    var onChatClicked: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            CircularProfileImageView(
                profileImageUrl: chat.otherUser.profileImageUrls[0],
                size: .medium,
                allowShadow: true
            )
            
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
        .padding(.horizontal, 4)
        .background(Color.white)
        .onTapGesture {
            onChatClicked?()
        }
    }
}
