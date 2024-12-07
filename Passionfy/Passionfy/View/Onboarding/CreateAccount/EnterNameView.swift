//
//  EnterNameView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct EnterNameView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        VStack {
            ZStack {
                AnimatedRadialGradientView()
                VStack {
                    TopBarView(backButtonAction: {
                        dismiss()
                    })
                    NameInputView()
                    Spacer()
                    Text("Choose a username that reflects you. It's how others will recognize and connect with you on Passionfy.")
                        .customFont(.semiBold, 14)
                        .foregroundColor(Color.pink.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    ContinueButton()
                }
                .animation(nil)
                .padding()
            }
        }
        .modifier(LoadingAndErrorOverlayModifier(isLoading: $viewModel.isLoading, errorMessage: $viewModel.errorMessage))
    }
}

private struct NameInputView: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        VStack {
            VStack {
                Text("What's the name that sparks connection?")
                    .customFont(.semiBold, 16)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.pink.opacity(0.8))
                
                Text("Your unique name")
                    .customFont(.bold, 30)
                    .foregroundColor(Color.pink.opacity(0.6))
                    .opacity(viewModel.username.isEmpty ? 1.0: 0)
                    .frame(width: 300)
                    .overlay(
                        TextField("", text: $viewModel.username)
                            .customFont(.bold, 40)
                            .foregroundColor(Color.pink)
                            .multilineTextAlignment(.center)
                            .tint(Color.pink)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(viewModel.showAlert ? Color.red : Color.clear, lineWidth: 2)
                            )
                    )
                    .padding(.top, 5)
            }
            .foregroundColor(.white)
            Spacer()
        }
        .padding(.top)
    }
}

private struct ContinueButton: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        ActionButtonView(
            title: "Continue to Passion",
            mode: .filled,
            isDisabled: viewModel.username.isEmpty
        ) {
            viewModel.verifyUsernameAvailability()
        }
    }
}


struct EnterNameView_Previews: PreviewProvider {
    static var previews: some View {
        EnterNameView()
    }
}
