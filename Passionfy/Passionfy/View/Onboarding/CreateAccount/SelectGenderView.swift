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
        VStack {
            VStack {
                TopBarView(backButtonAction: {
                    viewModel.previousFlowStep()
                })
                OnboardingAccountLogoView()
                Spacer()
                GenderSelectionView(selectedGender: $viewModel.gender)
                Spacer()
                Text("Choose the gender that best represents you. Passionfy is a safe space for everyone. 🌈")
                    .customFont(.semiBold, 14)
                    .foregroundColor(Color.pink.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                ContinueButton(
                    isDisabled: viewModel.gender == nil
                ) {
                    viewModel.nextFlowStep()
                }
            }
            .padding()
        }
        .background(AnimatedRadialGradientView())
        .modifier(LoadingAndErrorOverlayModifier(isLoading: $viewModel.isLoading, errorMessage: $viewModel.errorMessage))
    }
}

private struct GenderSelectionView: View {
    @Binding var selectedGender: Gender?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What is your gender?")
                .customFont(.semiBold, 16)
                .foregroundColor(Color.pink.opacity(0.8))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(Gender.allCases.filter { $0 != .custom }, id: \.self) { gender in
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
        }
        .padding(.horizontal)
    }
}

private struct ContinueButton: View {
    
    var isDisabled: Bool
    var onContinueClicked: () -> Void
    
    var body: some View {
        ActionButtonView(
            title: "Continue",
            mode: .filled,
            isDisabled: isDisabled
        ) {
            onContinueClicked()
        }
    }
}

struct SelectGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SelectGenderView()
            .environmentObject(CreateAccountViewModel())
    }
}
