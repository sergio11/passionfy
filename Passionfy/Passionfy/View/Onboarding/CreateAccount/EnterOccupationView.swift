//
//  EnterOccupationView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 14/12/24.
//

import SwiftUI

struct EnterOccupationView: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        OnboardingStepView(
            message: "This is how your occupation will appear on your profile. Don't worry, you can always update it later.",
            isContinueButtonDisabled: viewModel.occupation.isEmpty
        ) {
            OccupationInputView()
        }
    }
}

private struct OccupationInputView: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                // Title for the input field
                Text("What’s your occupation?")
                    .customFont(.semiBold, 16)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.pink.opacity(0.8))
                
                // Subtitle/Placeholder
                Text("Your role in the world")
                    .customFont(.bold, 30)
                    .foregroundColor(Color.pink.opacity(0.6))
                    .opacity(viewModel.occupation.isEmpty ? 1.0 : 0)
                    .frame(width: 300)
                    .overlay(
                        TextField("", text: $viewModel.occupation)
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
            Spacer()
        }
        .padding(.top)
    }
}

struct EnterOccupationView_Previews: PreviewProvider {
    static var previews: some View {
        EnterOccupationView()
            .environmentObject(CreateAccountViewModel())
    }
}
