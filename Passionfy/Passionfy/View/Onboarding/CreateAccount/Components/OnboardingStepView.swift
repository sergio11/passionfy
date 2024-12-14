//
//  OnboardingStepView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 13/12/24.
//

import SwiftUI

/// A reusable view for onboarding steps, providing a consistent layout and functionality.
/// This view includes a top bar, logo, customizable content, a message, and a continue button.
struct OnboardingStepView<Content: View>: View {
    
    @EnvironmentObject var viewModel: CreateAccountViewModel

    /// A message displayed below the content, providing context to the user.
    let message: String
    /// The action to execute when the user taps the continue button.
    let onContinue: (() -> Void)?
    /// The action to execute when the user taps the back button.
    let onBack: (() -> Void)?
    /// A flag indicating whether the continue button should be disabled.
    let isContinueButtonDisabled: Bool
    /// The customizable content for each specific onboarding step.
    @ViewBuilder var content: () -> Content
    
    /// Initializes the reusable onboarding step view.
    init(
        message: String,
        onContinue: (() -> Void)? = nil,
        onBack: (() -> Void)? = nil,
        isContinueButtonDisabled: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.onContinue = onContinue
        self.onBack = onBack
        self.message = message
        self.isContinueButtonDisabled = isContinueButtonDisabled
        self.content = content
    }
    
    var body: some View {
        VStack {
            VStack {
                // Top bar with back button
                TopBarView {
                    onBack?() ?? viewModel.previousFlowStep()
                }
                
                // App logo displayed at the top
                OnboardingAccountLogoView()
                
                Spacer()
                
                // Customizable content specific to the onboarding step
                content()
                    .frame(alignment: .top)
                
                Spacer()
                
                // Contextual message for the onboarding step
                Text(message)
                    .customFont(.semiBold, 14)
                    .foregroundColor(Color.pink.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Continue button to proceed to the next step
                ContinueButton(isDisabled: isContinueButtonDisabled) {
                    onContinue?() ?? viewModel.nextFlowStep()
                }
            }
            .padding()
        }
        .background(AnimatedRadialGradientView())
        .modifier(LoadingAndErrorOverlayModifier(isLoading: $viewModel.isLoading, errorMessage: $viewModel.errorMessage))
    }
}

/// A reusable continue button for onboarding steps.
private struct ContinueButton: View {
    /// Flag to determine if the button is disabled.
    var isDisabled: Bool
    /// Action to perform when the button is tapped.
    var action: () -> Void
    
    var body: some View {
        ActionButtonView(
            title: "Continue",
            mode: .filled,
            isDisabled: isDisabled,
            action: action
        )
    }
}
