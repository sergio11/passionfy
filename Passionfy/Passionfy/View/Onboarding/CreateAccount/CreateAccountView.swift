//
//  CreateAccountView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct CreateAccountView: View {
    
    @Binding var isAccountCreated: Bool
    @StateObject var viewModel = CreateAccountViewModel()
    
    var body: some View {
        switch viewModel.accountFlowStep {
        case .username:
            EnterNameView()
                .environmentObject(viewModel)
        case .birthdate:
            EnterAgeView()
                .environmentObject(viewModel)
        case .gender:
            SelectGenderView()
                .environmentObject(viewModel)
        case .phoneNumber:
            EnterPhoneNumberView()
                .environmentObject(viewModel)
        case .otp:
            ValidateOTPView()
                .environmentObject(viewModel)
        case .completed:
            AccountCreatedView(isAccountCreated: $isAccountCreated)
                .environmentObject(viewModel)
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView(isAccountCreated: .constant(false))
    }
}
