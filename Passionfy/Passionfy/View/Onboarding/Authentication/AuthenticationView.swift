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
        OnboardingStepView(
            isLoading: $viewModel.isLoading,
            errorMessage: $viewModel.errorMessage,
            message: "By Tapping \"Continue\" you agree to our Terms. Lear how we process your data in our rivacy and Cookies Policy",
            onContinue: {
                viewModel.sendOtp()
            },
            onBack: {
                dismiss()
            },
            isContinueButtonDisabled: viewModel.phoneNumber.isEmpty
        ) {
            PhoneNumberInputView(showCountryList: $viewModel.showCountryList, phoneNumber: $viewModel.phoneNumber, country: $viewModel.country, title: "Sign in securely by providing your phone number", label: "Your Phone")
        }
        .sheet(isPresented: $viewModel.showCountryList) {
            SelectCountryView(countryChosen: $viewModel.country)
        }
        .sheet(isPresented: $viewModel.showEnterCodeView) {
            EnterCodeView(
                phoneCode: $viewModel.country.phoneCode,
                phoneNumber: $viewModel.phoneNumber,
                otpText: $viewModel.otpText,
                isLoading: $viewModel.isLoading,
                errorMessage: $viewModel.errorMessage,
                onBack: {
                    viewModel.showEnterCodeView = false
                },
                onVerifyOTP: {
                    viewModel.signIn()
                }
            )
        }
        .onReceive(viewModel.$signInSuccess) { success in
            if success {
                isAuthenticated = true
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(isAuthenticated: .constant(false))
    }
}
