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
        OnboardingStepView(
            message: "We’ll send a verification code to your phone to complete the registration.",
            onContinue: {
                viewModel.sendOtp()
            },
            isContinueButtonDisabled: viewModel.phoneNumber.isEmpty
        ) {
            PhoneNumberInputView(showCountryList: $viewModel.showCountryList, phoneNumber: $viewModel.phoneNumber, country: $viewModel.country, title: "Ready to Join? Sign Up with Your Phone Number!", label: "Your Phone")
        }.sheet(isPresented: $viewModel.showCountryList) {
            SelectCountryView(countryChosen: $viewModel.country)
        }
    }
}

struct EnterPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPhoneNumberView()
    }
}
