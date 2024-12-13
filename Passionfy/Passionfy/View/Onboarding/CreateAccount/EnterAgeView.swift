//
//  EnterAgeView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI
import Combine

struct EnterAgeView: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        OnboardingStepView(
            message: "We just need to verify your age to ensure you're ready for Passionfy.",
            isContinueButtonDisabled: !viewModel.birthdate.hasDataValid()
        ) {
            DateInputView()
        }
    }
}

private struct DateInputView: View {
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 8) {
                Text("Hey \(viewModel.username), when were you born?")
                    .customFont(.semiBold, 16)
                    .foregroundColor(Color.pink.opacity(0.8))
                HStack(spacing: 0) {
                    InputField(title: "MM", value: $viewModel.birthdate.month)
                    Separator()
                    InputField(title: "DD", value: $viewModel.birthdate.day)
                    Separator()
                    InputField(title: "YYYY", value: $viewModel.birthdate.year)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.top, 5)
            
            Spacer()
        }
        .padding(.top)
    }
}

private struct Separator: View {
    var body: some View {
        Text("/")
            .font(.system(size: 30))
            .foregroundColor(Color.pink.opacity(0.8))
            .padding(.horizontal, 4)
    }
}

private struct InputField: View {
    
    var title: String
    @Binding var value: String
    
    var body: some View {
        Text(title)
            .customFont(.bold, 30)
            .foregroundColor(Color.pink.opacity(0.6))
            .opacity(value.isEmpty ? 1.0: 0)
            .frame(width: title == "YYYY" ? 120 : 72)
            .overlay(
                TextField("", text: $value)
                    .customFont(.bold, 45)
                    .foregroundColor(Color.pink)
                    .multilineTextAlignment(.center)
                    .tint(Color.pink)
                    .keyboardType(.numberPad)
                    .numericInput(value: $value, title: title)
                )
        }
}


struct EnterAgeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterAgeView()
    }
}
