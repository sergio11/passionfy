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
            TransitioningView(transition: .opacity) {
                switch viewModel.accountFlowStep {
                case .username:
                    EnterNameView()
                case .birthdate:
                    EnterAgeView()
                case .gender:
                    SelectGenderView()
                case .interest:
                    SelectInterestView()
                case .preference:
                    SelectPreferencesView()
                case .occupation:
                    EnterOccupationView()
                case .phoneNumber:
                    EnterPhoneNumberView()
                case .otp:
                    ValidateOTPView()
                case .completed:
                    AccountCreatedView(isAccountCreated: $isAccountCreated)
                }
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
