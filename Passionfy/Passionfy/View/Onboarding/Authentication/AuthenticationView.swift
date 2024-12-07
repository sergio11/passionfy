//
//  AuthenticationView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var isAuthenticated: Bool
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            VStack {
                TopBarView(backButtonAction: {
                    dismiss()
                })
                OnboardingAccountLogoView()
                Spacer()
                PhoneNumberInputView(showCountryList: $viewModel.showCountryList, phoneNumber: $viewModel.phoneNumber, country: $viewModel.country, title: "Sign in securely by providing your phone number", label: "Your Phone")
                Spacer()
                AgreementTextView()
                ContinueButton(
                    isPhoneNumberEmpty: viewModel.phoneNumber.isEmpty
                ) {
                    viewModel.sendOtp()
                }
            }.padding()
        }
        .background(AnimatedRadialGradientView())
        .sheet(isPresented: $viewModel.showCountryList) {
            SelectCountryView(countryChosen: $viewModel.country)
        }
        .sheet(isPresented: $viewModel.showEnterCodeView) {
            EnterCodeView(phoneCode: $viewModel.country.phoneCode, phoneNumber: $viewModel.phoneNumber, otpText: $viewModel.otpText, isLoading: $viewModel.isLoading, onBack: {
                viewModel.showEnterCodeView = false
            }, onVerifyOTP: {
                viewModel.signIn()
            })
        }
        .onReceive(viewModel.$signInSuccess) { success in
            if success {
                isAuthenticated = true
            }
        }
        .modifier(LoadingAndErrorOverlayModifier(isLoading: $viewModel.isLoading, errorMessage: $viewModel.errorMessage))
    }
}

private struct ContinueButton: View {

    var isPhoneNumberEmpty: Bool
    var onClicked: (() -> Void)? = nil
    
    var body: some View {
        ActionButtonView(
            title: "Continue",
            mode: .filled
        ) {
            onClicked?()
        }.disabled(isPhoneNumberEmpty)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(isAuthenticated: .constant(false))
    }
}
