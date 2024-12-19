//
//  UserMatchView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct UserMatchView: View {
    
    @Binding var show: Bool
    let matchedUser: User
    
    var body: some View {
        ZStack {
            AnimatedGradientView()
            VStack {
                MainContent(matchedUser: matchedUser)
                Actions(show: $show)
            }
            .padding()
        }
    }
}

private struct MainContent: View {
    
    let matchedUser: User
    
    var body: some View {
        VStack(spacing: 120) {
            VStack {
                Image("onboarding_logo")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 50)
                
                Text("You and \(matchedUser.username) liked each other.")
                    .customFont(.medium, 18)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            
            HStack(spacing: 16) {
                
                CircularProfileImageView(
                    profileImageUrl: matchedUser.profileImageUrls[0],
                    size: .large
                )
                
                CircularProfileImageView(
                    profileImageUrl: matchedUser.profileImageUrls[0],
                    size: .large
                )
            }
        }
    }
}


private struct Actions: View {
    
    @Binding var show: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            ActionButtonView(title: "Send Message", mode: .filled) {
               
            }
            
            ActionButtonView(title: "Keep Swiping", mode: .outlined) {
                show.toggle()
            }
        }
    }
}

struct UserMatchView_Previews: PreviewProvider {
    static var previews: some View {
        UserMatchView(show: .constant(true), matchedUser: MockData.users[0])
    }
}
