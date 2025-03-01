//
//  SelectGenderView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 13/12/24.
//

import SwiftUI

struct SelectGenderView: View {
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        OnboardingStepView(
            isLoading: $viewModel.isLoading,
            errorMessage: $viewModel.errorMessage,
            message: "Choose the gender that best represents you. Passionfy is a safe space for everyone. 🌈",
            onContinue: {
                viewModel.nextFlowStep()
            },
            onBack: {
                viewModel.previousFlowStep()
            },
            isContinueButtonDisabled: viewModel.gender == nil
        ) {
            // Gender selection content
            GenderSelectionView(selectedGender: $viewModel.gender)
        }
    }
}

/// Displays a list of gender options for the user to select from.
private struct GenderSelectionView: View {
    @Binding var selectedGender: Gender?
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("What’s Your Gender? 💫")
                .customFont(.semiBold, 16)
                .foregroundColor(Color.pink.opacity(0.8))
            ScrollView { // Make the list scrollable
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        HStack {
                            Text(gender.rawValue)
                                .customFont(.regular, 14)
                                .foregroundColor(.pink.opacity(0.8))
                            Spacer()
                            if selectedGender == gender {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.pink)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(selectedGender == gender ? Color.pink : Color.clear, lineWidth: 2)
                        )
                        .onTapGesture {
                            selectedGender = gender
                        }
                    }
                }
            }
        }.padding(.horizontal)
    }
}

struct SelectGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SelectGenderView()
            .environmentObject(CreateAccountViewModel())
    }
}
