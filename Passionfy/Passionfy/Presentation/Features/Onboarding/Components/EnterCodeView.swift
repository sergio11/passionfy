//
//  EnterCodeView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI
import Combine

struct EnterCodeView: View {
    
    @Environment(\.dismiss) var dismiss

    @Binding var phoneCode: String
    @Binding var phoneNumber: String
    @Binding var otpText: String
    @Binding var isLoading: Bool
    @Binding var errorMessage: String?
    
    @State var timeRemaining = 60
    
    var onBack: () -> Void
    var onVerifyOTP: () -> Void
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            VStack {
                TopBarView {
                    dismiss()
                }
                OnboardingAccountLogoView()
                EnterCodeSection(phoneCode: $phoneCode, phoneNumber: $phoneNumber, otpText: $otpText)
                Spacer()
                
                // Contextual message for the onboarding step
                Text("Enter the 6-digit code we sent to your phone number to verify your identity. If you didn’t receive it, you can request another code after the timer expires.")
                    .customFont(.semiBold, 14)
                    .foregroundColor(Color.pink.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                ActionButtonView(
                    title: "Change the phone number",
                    mode: .outlined
                ) {
                    dismiss()
                }
                
                ActionButtonView(
                    title: otpText.count == 6 ? "Continue" : "Resend in \(timeRemaining)",
                    mode: .filled
                ) {
                    onVerifyOTP()
                }
                .disabled(otpText.isEmpty)
                
            }
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                onBack()
            }
        }
        .background(AnimatedRadialGradientView())
        .modifier(LoadingAndMessageOverlayModifier(
            isLoading: $isLoading,
            message: $errorMessage
        ))
    }
}

private struct EnterCodeSection: View {
    
    @Binding var phoneCode: String
    @Binding var phoneNumber: String
    @Binding var otpText: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            EnterCodeTextView(phoneCode: $phoneCode, phoneNumber: $phoneNumber)
            EnterCodeTextField(otpText: $otpText)
        }
        .padding(.top, 50)
    }
}

private struct EnterCodeTextView: View {
    
    @Binding var phoneCode: String
    @Binding var phoneNumber: String
    
    var body: some View {
        Text("Enter the code we sent to +\(phoneCode) \(phoneNumber)")
            .customFont(.medium, 16)
            .foregroundColor(Color.pink)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
}

private struct EnterCodeTextField: View {
    
    @Binding var otpText: String
    
    var body: some View {
        ZStack {
            // Placeholder dots for the OTP input
            Text(otpText.isEmpty ? "......" : "")
                .customFont(.bold, 34)
                .foregroundColor(Color.pink.opacity(0.5))
                .padding(.top, -5)
            
            // Actual OTP text field
            TextField("", text: $otpText)
                .foregroundColor(Color.pink)
                .multilineTextAlignment(.center)
                .font(.system(size: 34, weight: .heavy, design: .rounded))
                .keyboardType(.numberPad)
                .frame(width: 200, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.pink.opacity(0.5), lineWidth: 2)
                )
        }
        .limitText(6, binding: $otpText)
        .filterNumericCharacters(binding: $otpText)
    }
}

struct EnterCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeView(phoneCode: .constant("+1"), phoneNumber: .constant("6505551234"), otpText: .constant(""), isLoading: .constant(false), errorMessage: .constant(nil), onBack: {}, onVerifyOTP: {})
    }
}
