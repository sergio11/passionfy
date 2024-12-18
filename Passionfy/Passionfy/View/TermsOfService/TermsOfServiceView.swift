//
//  TermsOfServiceView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI

struct TermsOfServiceView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Passionfy Terms of Service")
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
                        title: "Introduction",
                        content: """
                        Welcome to Passionfy! By using our app, you agree to abide by these terms. Please read them carefully. If you do not agree, do not use our services.
                        """
                    )
                    
                    SectionView(
                        title: "User Responsibilities",
                        content: """
                        1. You must be at least 18 years old to use Passionfy.
                        2. You agree not to share offensive or inappropriate content.
                        3. You are responsible for the accuracy of the information you provide.
                        """
                    )
                    
                    SectionView(
                        title: "Privacy Policy",
                        content: """
                        Your privacy is important to us. We collect and use your data in accordance with our Privacy Policy, which is incorporated by reference.
                        """
                    )
                    
                    SectionView(
                        title: "Limitation of Liability",
                        content: """
                        Passionfy is not responsible for any damages resulting from your use of the app, including, but not limited to, emotional distress or relationship outcomes.
                        """
                    )
                    
                    SectionView(
                        title: "Changes to the Terms",
                        content: """
                        We reserve the right to update these terms at any time. Continued use of Passionfy after changes are made constitutes acceptance of the new terms.
                        """
                    )
                }
                .padding()
            }
            .navigationTitle("Terms of Service")
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
}

private struct SectionView: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.pink)
            
            Text(content)
                .font(.body)
                .foregroundColor(.black)
                .lineSpacing(4)
        }
        .padding(.vertical, 8)
    }
}

struct TermsOfServiceView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceView()
    }
}
