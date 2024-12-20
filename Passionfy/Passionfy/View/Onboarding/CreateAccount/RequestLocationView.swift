//
//  RequestLocationView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 20/12/24.
//

import SwiftUI

struct RequestLocationView: View {
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        OnboardingStepView(
            isLoading: $viewModel.isLoading,
            errorMessage: $viewModel.errorMessage,
            message: "We need your location to help you find nearby matches. Please enable location services.",
            onContinue: {
                viewModel.nextFlowStep()
            },
            onBack: {
                viewModel.previousFlowStep()
            },
            isContinueButtonDisabled: viewModel.userCoordinates == nil
        ) {
            VStack {
                if viewModel.userCoordinates != nil {
                    Text("Location access enabled!")
                        .customFont(.semiBold, 16)
                        .foregroundColor(.green)
                } else {
                    Button(action: {
                        viewModel.requestLocationPermission()
                    }) {
                        Text("Enable Location")
                            .customFont(.bold, 16)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
}

