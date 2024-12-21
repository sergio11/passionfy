//
//  DataSecurityView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import SwiftUI

struct DataSecurityView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Passionfy Data Security")
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
                        title: "Our Commitment to Data Security",
                        content: """
                        At Passionfy, the security of your personal data is our top priority. We have implemented industry-leading security practices to protect your information and ensure your privacy.
                        """
                    )
                    
                    SectionView(
                        title: "Encryption",
                        content: """
                        All sensitive data, including personal and payment information, is encrypted using advanced encryption standards (AES) both in transit and at rest.
                        """
                    )
                    
                    SectionView(
                        title: "Access Control",
                        content: """
                        We restrict access to your data to authorized personnel only. Our team undergoes regular security training to ensure they understand how to safeguard your information.
                        """
                    )
                    
                    SectionView(
                        title: "Two-Factor Authentication",
                        content: """
                        We recommend using two-factor authentication (2FA) to further protect your account. 2FA provides an additional layer of security by requiring a second form of verification, such as a code sent to your phone.
                        """
                    )
                    
                    SectionView(
                        title: "Third-Party Services",
                        content: """
                        We use trusted third-party services for some functions, such as payment processing and cloud storage. These services comply with industry standards for data security.
                        """
                    )
                    
                    SectionView(
                        title: "Reporting Security Concerns",
                        content: """
                        If you suspect a security issue or unauthorized access to your account, please contact our support team immediately at support@passionfy.com.
                        """
                    )
                }
                .padding()
            }
            .navigationTitle("Data Security")
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

struct DataSecurityView_Previews: PreviewProvider {
    static var previews: some View {
        DataSecurityView()
    }
}
