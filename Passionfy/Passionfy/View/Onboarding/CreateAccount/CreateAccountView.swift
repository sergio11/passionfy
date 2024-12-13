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
        ZStack {
            switch viewModel.accountFlowStep {
            case .username:
                EnterNameView()
                    .transition(.slide)
            case .birthdate:
                EnterAgeView()
                    .transition(.slide)
            case .gender:
                SelectGenderView()
                    .transition(.slide)
            case .interest:
                SelectInterestView()
                    .transition(.slide)
            case .preference:
                SelectPreferencesView()
                    .transition(.slide)
            case .phoneNumber:
                EnterPhoneNumberView()
                    .transition(.slide)
            case .otp:
                ValidateOTPView()
                    .transition(.slide)
            case .completed:
                AccountCreatedView(isAccountCreated: $isAccountCreated)
                    .transition(.slide)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.accountFlowStep)
        .environmentObject(viewModel)
    }
}


struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView(isAccountCreated: .constant(false))
    }
}
