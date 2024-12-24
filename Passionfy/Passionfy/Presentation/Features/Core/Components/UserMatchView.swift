//
//  UserMatchView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI
import Kingfisher

struct UserMatchView: View {
    
    let currentUser: User
    let matchedUser: User
    var onKeepExploring: (() -> Void)? = nil
    var onSendMessage: (() -> Void)? = nil
    
    @State private var currentImageOffset: CGFloat = -UIScreen.main.bounds.width
    @State private var matchedImageOffset: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            BackgroundImage(imageName: "user_match_background")
            AnimatedGradientView()
            
            VStack(spacing: 24) {
                MainContent(
                    currentUser: currentUser,
                    matchedUser: matchedUser,
                    currentImageOffset: $currentImageOffset,
                    matchedImageOffset: $matchedImageOffset
                )
                
                Spacer(minLength: 20)
                
                Actions(
                    onKeepExploring: onKeepExploring,
                    onSendMessage: onSendMessage
                )
            }
            .padding()
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7, blendDuration: 1)) {
                currentImageOffset = 0
                matchedImageOffset = 0
            }
        }
    }
}

private struct MainContent: View {
    
    let currentUser: User
    let matchedUser: User
    @Binding var currentImageOffset: CGFloat
    @Binding var matchedImageOffset: CGFloat
    
    var body: some View {
        VStack(spacing: 40) {
            VStack {
                Image("onboarding_logo")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 50)
                
                Text("It's a Match! 🎉")
                    .customFont(.bold, 22)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 4)
                
                Text("You and \(matchedUser.username) have swiped right on each other. Let the magic begin!")
                    .customFont(.medium, 16)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
            }
            
            HStack(spacing: 16) {
                UserImageView(
                    imageUrl: currentUser.profileImageUrls[0],
                    offset: currentImageOffset,
                    rotationAngle: currentImageOffset == 0 ? 0 : -360
                )
                
                UserImageView(
                    imageUrl: matchedUser.profileImageUrls[0],
                    offset: matchedImageOffset,
                    rotationAngle: matchedImageOffset == 0 ? 0 : 360
                )
            }
        }
    }
}

private struct UserImageView: View {
    let imageUrl: String
    let offset: CGFloat
    let rotationAngle: Double
    
    var body: some View {
        KFImage(URL(string: imageUrl))
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 2)
                    .shadow(radius: 4)
            }
            .offset(x: offset)
            .rotationEffect(.degrees(rotationAngle))
    }
}

private struct Actions: View {
    
    var onKeepExploring: (() -> Void)? = nil
    var onSendMessage: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            ActionButtonView(title: "Send a Message", mode: .filled) {
                onSendMessage?()
            }
            
            ActionButtonView(title: "Keep Exploring", mode: .outlined) {
                onKeepExploring?()
            }
        }
        .padding(.top, 24)
    }
}

struct UserMatchView_Previews: PreviewProvider {
    static var previews: some View {
        UserMatchView(
            currentUser: MockData.users[0],
            matchedUser: MockData.users[0]
        )
    }
}
