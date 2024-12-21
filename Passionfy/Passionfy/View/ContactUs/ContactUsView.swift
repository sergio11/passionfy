//
//  ContactUsView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import SwiftUI

struct ContactUsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var email = ""
    @State private var message = ""
    @State private var isSending = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Contact Us")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.pink)
                        .padding(.bottom, 8)
                    
                    Text("We're here to help! Let us know how we can assist you.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    Divider()
                        .padding(.vertical, 8)

                    SectionView(
                        title: "Your Name",
                        content: "Please provide your name so we can address you personally."
                    )
                    
                    TextField("Your Name", text: $name)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .padding(.bottom, 16)
                    
                    SectionView(
                        title: "Your Email",
                        content: "We need your email address to respond to your message."
                    )
                    
                    TextField("Your Email", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .padding(.bottom, 16)
                        .keyboardType(.emailAddress)
                    
                    SectionView(
                        title: "Your Message",
                        content: "Tell us how we can help you or what your concerns are."
                    )
                    
                    TextEditor(text: $message)
                        .customFont(.regular, 16)
                        .frame(height: 150)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .padding(.bottom, 16)
                        .foregroundColor(.gray)
                    
                    ActionButtonView(
                        title: "Contact Us",
                        mode: .filled,
                        isDisabled: isSending
                    ) {
                        sendMessage()
                    }
                }
                .padding()
            }
            .navigationTitle("Contact Us")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(.pink)
                }
            }
        }
    }
    
    private func sendMessage() {
        guard !name.isEmpty && !email.isEmpty && !message.isEmpty else {
            return
        }
        isSending = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isSending = false
            name = ""
            email = ""
            message = ""
            dismiss()
        }
    }
}
struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
