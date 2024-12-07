//
//  EnterPhoneNumberView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI
import Combine

struct EnterPhoneNumberView: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        VStack {
            VStack {
                TopBarView(backButtonAction: {
                    viewModel.previousFlowStep()
                })
                OnboardingAccountLogoView()
                Spacer()
                PhoneNumberInputView(showCountryList: $viewModel.showCountryList, phoneNumber: $viewModel.phoneNumber, country: $viewModel.country, title: "Create you account using your phone number", label: "Your Phone")
                Spacer()
                AgreementTextView()
                ContinueButton()
            }.padding()
        }
        .sheet(isPresented: $viewModel.showCountryList) {
            SelectCountryView(countryChosen: $viewModel.country)
        }
        .background(AnimatedRadialGradientView())
        .modifier(LoadingAndErrorOverlayModifier(isLoading: $viewModel.isLoading, errorMessage: $viewModel.errorMessage))
    }
}

private struct ContinueButton: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        ActionButtonView(
            title: "Continue",
            mode: .filled,
            isDisabled: viewModel.phoneNumber.isEmpty
        ) {
            viewModel.sendOtp()
        }
    }
}


struct EnterPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPhoneNumberView()
    }
}
