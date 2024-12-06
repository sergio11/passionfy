//
//  ValidateOTPView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct ValidateOTPView: View {
 
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        EnterCodeView(phoneCode: $viewModel.country.phoneCode, phoneNumber: $viewModel.phoneNumber, otpText: $viewModel.otpText, isLoading: $viewModel.isLoading, onBack: {
            viewModel.previousFlowStep()
        }, onVerifyOTP: {
            viewModel.signUp()
        })
    }
}
