//
//  FeedbackView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import SwiftUI

struct FeedbackView: View {
    @Environment(\.dismiss) var dismiss
    @State private var feedbackText = ""
    @State private var isSending = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("We'd Love to Hear Your Feedback!")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.pink)
                        .padding(.bottom, 8)
                    
                    Text("Effective Date: December 18, 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    Divider()
                        .padding(.vertical, 8)

                    SectionView(
                        title: "Tell Us Your Thoughts",
                        content: """
                        We value your feedback to improve Passionfy! Please provide us with your thoughts, suggestions, or any issues you might have faced while using the app.
                        """
                    )
                    
                    VStack(alignment: .leading) {
                        Text("Your Feedback:")
                            .font(.headline)
                            .foregroundColor(.pink)
                        TextEditor(text: $feedbackText)
                            .customFont(.regular, 16)
                            .frame(height: 150)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)
                            .padding(.bottom, 16)
                    }
                    
                    ActionButtonView(
                        title: "Send Feedback",
                        mode: .filled,
                        isDisabled: isSending
                    ) {
                        sendFeedback()
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Feedback")
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
    
    private func sendFeedback() {
        guard !feedbackText.isEmpty else { return }
        isSending = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isSending = false
            feedbackText = ""
            dismiss()
        }
    }
}
struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
