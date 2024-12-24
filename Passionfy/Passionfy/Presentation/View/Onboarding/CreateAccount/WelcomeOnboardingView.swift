//
//  WelcomeOnboardingView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 14/12/24.
//

import SwiftUI

struct WelcomeOnboardingView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        OnboardingStepView(
            isLoading: $viewModel.isLoading,
            errorMessage: $viewModel.errorMessage,
            message: "Welcome to Passionfy! Get ready to connect with like-minded individuals and create meaningful relationships.",
            onContinue: {
                viewModel.nextFlowStep()
            }, onBack: {
                dismiss()
            }
        ) {
            VStack(alignment: .leading) {
                Text("Welcome to Passionfy! 🌟")
                    .customFont(.bold, 24)
                    .foregroundColor(Color.pink.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    RuleView(
                        emoji: "🌟",
                        title: "Be Yourself",
                        description: "Make sure your pictures, age, and name are accurate and reflect who you truly are."
                    )
                    RuleView(
                        emoji: "🔒",
                        title: "Stay Safe",
                        description: "Avoid sharing personal information too quickly when chatting."
                    )
                    RuleView(
                        emoji: "😌",
                        title: "Play it Cool",
                        description: "Respect others, and treat everyone with kindness and empathy."
                    )
                    RuleView(
                        emoji: "🛡️",
                        title: "Be Proactive",
                        description: "Report any inappropriate or bad behavior to help keep Passionfy safe."
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

// Reusable component for displaying rules
private struct RuleView: View {
    let emoji: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(emoji)
                .font(.largeTitle)
                .padding(.trailing, 8)
            VStack(alignment: .leading) {
                Text(title)
                    .customFont(.semiBold, 16)
                    .foregroundColor(Color.pink.opacity(0.9))
                Text(description)
                    .customFont(.regular, 14)
                    .foregroundColor(Color.pink)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

// Preview
struct WelcomeOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeOnboardingView()
            .environmentObject(CreateAccountViewModel())
    }
}
