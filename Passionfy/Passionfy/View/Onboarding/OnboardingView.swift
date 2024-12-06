//
//  OnboardingView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var isAccountAuthenticated: Bool
    
    var body: some View {
        ZStack {
            BackgroundImage(imageName: "onboarding_background")
            AnimatedGradientView()
            VStack {
                MainContent()
                Actions(isAccountAuthenticated: $isAccountAuthenticated)
            }
            .padding()
        }
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
}

private struct MainContent: View {
    var body: some View {
        VStack {
            Image("onboarding_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 50)
            Text("Find Your Perfect Match!")
                .customFont(.bold, 28)
                .foregroundColor(.white)
                .padding()
            Text("Welcome to Passionfy: where love begins. Discover your perfect partner, share your vibe, and let passion lead the way to lasting connections.")
                .customFont(.regular, 20)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
    }
}

private struct Actions: View {
    
    @Binding var isAccountAuthenticated: Bool
    
    var body: some View {
        VStack {
            Text("Ready to meet your ideal match? Join Passionfy today!")
                .customFont(.medium, 18)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            VStack(alignment: .center) {
                NavigationLink(destination: AuthenticationView(isAuthenticated: $isAccountAuthenticated)
                    .navigationBarBackButtonHidden()) {
                        ActionButtonView(title: "Get Started!", mode: .filled)
                            .allowsHitTesting(false)
                }
                NavigationLink(destination: CreateAccountView(isAccountCreated: $isAccountAuthenticated)
                    .navigationBarBackButtonHidden()) {
                        ActionButtonView(title: "Create Account", mode: .outlined)
                            .allowsHitTesting(false)
                }
            }
            .padding(.bottom, 30)
            .padding(.top, 20)
            Text("Built with passion by DreamSoftware. Sergio Sánchez Sánchez © 2024")
                .customFont(.medium, 16)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isAccountAuthenticated: .constant(false))
    }
}

