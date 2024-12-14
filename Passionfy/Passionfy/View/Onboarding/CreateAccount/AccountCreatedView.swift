//
//  AccountCreatedView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct AccountCreatedView: View {
    
    @Binding var isAccountCreated: Bool
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        ZStack {
            BackgroundImage(imageName: "account_created_background")
            AnimatedGradientView()
            VStack {
                MainContent(username: $viewModel.username)
                Actions(isAccountCreated: $isAccountCreated)
            }
            .padding()
        }
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
}

private struct MainContent: View {
    
    @Binding var username: String
    
    var body: some View {
        VStack {
            Image("onboarding_logo")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .padding(.top, 50)
            Text("Congratulations, \(username)!")
                .customFont(.bold, 28)
                .foregroundColor(.white)
                .padding(.top)
            Text("Your account is ready to go! You're now part of the Passionfy family—where amazing connections await.")
                .customFont(.regular, 20)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 10)
            Spacer()
        }
    }
}


private struct Actions: View {
    
    @Binding var isAccountCreated: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Ready to discover your perfect match?")
                .customFont(.medium, 18)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            ActionButtonView(title: "Start Your Journey", mode: .filled) {
                isAccountCreated = true
            }
            .padding(.horizontal, 20)
            
            Text("Made with love and dedication by DreamSoftware.\nSergio Sánchez Sánchez © 2024")
                .customFont(.medium, 14)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.top, 30)
        }
    }
}

struct AccountCreatedView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreatedView(isAccountCreated: .constant(false))
    }
}
