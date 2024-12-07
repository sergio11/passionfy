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
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView(backButtonAction: {
                    viewModel.previousFlowStep()
                })
                VStack {
                    PhoneNumberInputView(showCountryList: $viewModel.showCountryList, phoneNumber: $viewModel.phoneNumber, country: $viewModel.country, title: "Create you account using your phone number", label: "Your Phone")
                    Spacer()
                    AgreementTextView()
                    ContinueButton()
                }.padding(.bottom, 40)
            }
        }
        .sheet(isPresented: $viewModel.showCountryList) {
            SelectCountryView(countryChosen: $viewModel.country)
        }
        .overlay {
            LoadingView()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
        .modifier(LoadingAndErrorOverlayModifier(isLoading: $viewModel.isLoading, errorMessage: $viewModel.errorMessage))
    }
}

private struct ContinueButton: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        ActionButtonView(
            title: "Continue",
            mode: .filled
        ) {
            viewModel.sendOtp()
        }.disabled(viewModel.phoneNumber.isEmpty)
    }
}


struct EnterPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPhoneNumberView()
    }
}
