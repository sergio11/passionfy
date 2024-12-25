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
