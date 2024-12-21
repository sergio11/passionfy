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
    
    /// Binding to track the loading state, allowing the parent view to observe and update this value.
    @Binding private var isLoading: Bool
    /// Binding to hold and display error messages, allowing two-way communication with the parent view.
    @Binding private var errorMessage: String?
    /// A message displayed below the content, providing context to the user.
    private let message: String
    /// The action to execute when the user taps the continue button.
    private let onContinue: (() -> Void)?
    /// The action to execute when the user taps the back button.
    private let onBack: (() -> Void)?
    /// A flag indicating whether the continue button should be disabled.
    private let isContinueButtonDisabled: Bool
    /// The customizable content for each specific onboarding step.
    @ViewBuilder private var content: () -> Content
    
    /// Initializes the reusable onboarding step view.
        ///
        /// - Parameters:
        ///   - isLoading: A binding to a boolean that tracks the loading state.
        ///   - errorMessage: A binding to an optional string for error messages.
        ///   - message: A string providing context or instructions for the current onboarding step.
        ///   - onContinue: A closure to execute when the continue button is tapped. Defaults to `nil`.
        ///   - onBack: A closure to execute when the back button is tapped. Defaults to `nil`.
        ///   - isContinueButtonDisabled: A boolean indicating whether the continue button is disabled. Defaults to `false`.
        ///   - content: A `ViewBuilder` closure providing the content for the step.
    init(
        isLoading: Binding<Bool>,
        errorMessage: Binding<String?>,
        message: String,
        onContinue: (() -> Void)? = nil,
        onBack: (() -> Void)? = nil,
        isContinueButtonDisabled: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isLoading = isLoading
        self._errorMessage = errorMessage
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
                    onBack?()
                }
                
                // App logo displayed at the top
                OnboardingAccountLogoView()
                
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
                    onContinue?()
                }
            }
            .padding()
        }
        .background(AnimatedRadialGradientView())
        .modifier(LoadingAndMessageOverlayModifier(
            isLoading: $isLoading,
            message: $errorMessage
        ))
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
