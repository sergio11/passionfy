//
//  EnterCodeView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI
import Combine

struct EnterCodeView: View {

    @Binding var phoneCode: String
    @Binding var phoneNumber: String
    @Binding var otpText: String
    @Binding var isLoading: Bool
    
    @State var timeRemaining = 60
    
    var onBack: () -> Void
    var onVerifyOTP: () -> Void
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TopBarView(backButtonAction: {
                    onBack()
                })
                VStack {
                    EnterCodeSection(phoneCode: $phoneCode, phoneNumber: $phoneNumber, otpText: $otpText)
                    BottomSection(timeReamining: $timeRemaining, otpText: $otpText, onVerifyOTP: onVerifyOTP)
                }
                .padding(.bottom, 40)
            }.onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    onBack()
                }
            }
        }.overlay {
            LoadingView()
                .opacity(isLoading ? 1 : 0)
        }
    }
}

private struct EnterCodeSection: View {
    
    @Binding var phoneCode: String
    @Binding var phoneNumber: String
    @Binding var otpText: String
    
    var body: some View {
        return VStack {
            VStack(alignment: .center, spacing: 8) {
                EnterCodeTextView(phoneCode: $phoneCode, phoneNumber: $phoneNumber)
                EnterCodeTextField(otpText: $otpText)
            }
            .padding(.top, 50)
            Spacer()
        }
    }
}

private struct EnterCodeTextView: View {
    
    @Binding var phoneCode: String
    @Binding var phoneNumber: String
    
    var body: some View {
        Text("Enter the code we sent to + \(phoneCode) \(phoneNumber)")
            .foregroundColor(.white)
            .fontWeight(.medium)
            .font(.system(size: 16))
    }
}

private struct EnterCodeTextField: View {
    
    @Binding var otpText: String
    
    var body: some View {
        Text(".......")
            .foregroundColor(otpText.isEmpty ? .gray: .white)
            .opacity(otpText.isEmpty ? 0.8 : 0)
            .font(.system(size: 70))
            .frame(width: 210)
            .padding(.top, -40)
            .overlay(
                TextField("", text: $otpText)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24, weight: .heavy))
                    .keyboardType(.numberPad)
                    .limitText(6, binding: $otpText)
                    .filterNumericCharacters(binding: $otpText)
            )
    }
}

private struct BottomSection: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var timeReamining: Int
    @Binding var otpText: String
    var onVerifyOTP: () -> Void
    

    var body: some View {
        VStack {
            
            ActionButtonView(
                title: "Change the phone number",
                mode: .outlined
            ) {
                dismiss()
            }
            
            ActionButtonView(
                title: otpText.count == 6 ? "Continue": "Resend in \(timeReamining) ",
                mode: .filled
            ) {
                onVerifyOTP()
            }.disabled(otpText.isEmpty)
        }
    }
}

struct EnterCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeView(phoneCode: .constant("+1"), phoneNumber: .constant("6505551234"), otpText: .constant(""), isLoading: .constant(false), onBack: {}, onVerifyOTP: {})
    }
}
