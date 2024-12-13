//
//  SelectInterestView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 13/12/24.
//

import SwiftUI

/// A view that allows users to indicate who they are interested in during onboarding.
struct SelectInterestView: View {
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        OnboardingStepView(
            message: "Tell us who you're interested in, and we'll personalize your matches. 💖",
            isContinueButtonDisabled: viewModel.selectedInterest == nil
        ) {
            InterestSelectionView(selectedInterest: $viewModel.selectedInterest)
        }
    }
}

/// Displays a list of interests for the user to select from.
private struct InterestSelectionView: View {
    /// The currently selected interest, bound to the view model.
    @Binding var selectedInterest: Interest?
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("What Sparks Your Interest? ✨")
                .customFont(.semiBold, 16)
                .foregroundColor(Color.pink.opacity(0.8))
            ScrollView { // Make the list scrollable
                VStack(alignment: .leading, spacing: 8) {
                    // Loop through all interest options
                    ForEach(Interest.allCases, id: \.self) { interest in
                        HStack {
                            Text(interest.rawValue) // Display interest name
                                .customFont(.regular, 14)
                                .foregroundColor(.pink.opacity(0.8))
                            Spacer()
                            // Show a checkmark if this interest is selected
                            if selectedInterest == interest {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.pink)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(selectedInterest == interest ? Color.pink : Color.clear, lineWidth: 2)
                        )
                        .onTapGesture {
                            // Update the selected interest
                            selectedInterest = interest
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct SelectInterestView_Previews: PreviewProvider {
    static var previews: some View {
        SelectInterestView()
            .environmentObject(CreateAccountViewModel())
    }
}
