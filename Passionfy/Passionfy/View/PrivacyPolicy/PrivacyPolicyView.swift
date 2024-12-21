//
//  PrivacyPolicyView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Passionfy Privacy Policy")
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
                        Welcome to Passionfy! This Privacy Policy explains how we collect, use, and protect your personal data. By using our services, you agree to the collection and use of information as outlined in this policy.
                        """
                    )
                    
                    SectionView(
                        title: "Data Collection",
                        content: """
                        We collect personal information that you provide when you register, use our services, or interact with us. This may include your name, email address, birthdate, and other information that helps us offer personalized services.
                        """
                    )
                    
                    SectionView(
                        title: "How We Use Your Data",
                        content: """
                        We use your data to improve our services, personalize your experience, send you updates, and offer support. We may also use your information to comply with legal requirements.
                        """
                    )
                    
                    SectionView(
                        title: "Data Sharing",
                        content: """
                        We do not sell your personal information. However, we may share your data with third-party service providers to help us provide our services. These third parties are obligated to protect your information in accordance with our privacy practices.
                        """
                    )
                    
                    SectionView(
                        title: "Data Security",
                        content: """
                        We take appropriate security measures to protect your data from unauthorized access, alteration, and destruction. This includes using encryption and secure storage.
                        """
                    )
                    
                    SectionView(
                        title: "Your Rights",
                        content: """
                        You have the right to access, update, or delete your personal information. You can also opt-out of receiving marketing communications. To exercise these rights, contact us via the app or at privacy@passionfy.com.
                        """
                    )
                    
                    SectionView(
                        title: "Changes to This Policy",
                        content: """
                        We may update this Privacy Policy from time to time. Any changes will be posted on this page, and the updated policy will be effective immediately upon posting.
                        """
                    )
                }
                .padding()
            }
            .navigationTitle("Privacy Policy")
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

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
