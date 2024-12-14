//
//  SelectPreferencesView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 13/12/24.
//

import SwiftUI

struct SelectPreferencesView: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        OnboardingStepView(
            isLoading: $viewModel.isLoading,
            errorMessage: $viewModel.errorMessage,
            message: "Let us know what you're looking for, so we can find your perfect match. 💕",
            onContinue: {
                viewModel.nextFlowStep()
            },
            onBack: {
                viewModel.previousFlowStep()
            },
            isContinueButtonDisabled: viewModel.selectedPreference == nil
        ) {
            PreferencesSelectionView(selectedPreference: $viewModel.selectedPreference)
        }
    }
}

private struct PreferencesSelectionView: View {
    @Binding var selectedPreference: Preference?
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("What are you looking for?")
                .customFont(.semiBold, 16)
                .foregroundColor(Color.pink.opacity(0.8))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(Preference.allCases, id: \.self) { preference in
                        HStack {
                            Text(preference.rawValue)
                                .customFont(.regular, 14)
                                .foregroundColor(.pink.opacity(0.8))
                            Spacer()
                            if selectedPreference == preference {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.pink)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(selectedPreference == preference ? Color.pink : Color.clear, lineWidth: 2)
                        )
                        .onTapGesture {
                            if selectedPreference == preference {
                                selectedPreference = nil
                            } else {
                                selectedPreference = preference
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}


struct SelectPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPreferencesView()
            .environmentObject(CreateAccountViewModel())
    }
}
