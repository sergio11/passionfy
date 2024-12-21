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
                    Text("Yay! Location access enabled. You're ready to connect!")
                        .customFont(.semiBold, 16)
                        .foregroundColor(Color.pink)
                        .multilineTextAlignment(.center)
                        .padding(.top, 16)
                    
                    if !viewModel.userCity.isEmpty, !viewModel.userCountry.isEmpty {
                        Text("You're located in \(viewModel.userCity), \(viewModel.userCountry)!")
                            .customFont(.regular, 16)
                            .foregroundColor(.pink)
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)
                    } else {
                        Text("We couldn't determine your city or country.")
                            .customFont(.regular, 16)
                            .foregroundColor(.pink)
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)
                    }
                } else {
                    Text("Don't miss out on matches near you! Enable location services now.")
                        .customFont(.regular, 16)
                        .foregroundColor(.pink)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                    
                    VStack(spacing: 16) {
                        ZStack {
                            WaveAnimationView()
                                .frame(width: 250, height: 250)

                            Image(systemName: "location.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.pink)
                                .frame(width: 120, height: 120)
                                .background(Circle().fill(Color.gray.opacity(0.3)))
                                .overlay(
                                    Circle()
                                        .stroke(Color.pink, lineWidth: 4)
                                )
                                .shadow(radius: 10)
                                .zIndex(1)
                        }
                        
                        Text("We're working hard to locate you in the best possible way. Hang tight!")
                            .customFont(.bold, 20)
                            .foregroundColor(.pink)
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)
                    }
                    .padding()
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.requestLocationPermission()
        }
    }
}
