//
//  ReportUserSheetView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import SwiftUI

struct ReportUserSheet: View {
    
    @Binding var isPresented: Bool
    var onUserReported: ((String) -> Void)? = nil
    
    let reasons = [
        "Inappropriate behavior",
        "Offensive content",
        "Harassment or bullying",
        "Spam or scam",
        "Fake profile",
        "Hate speech",
        "Other"
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Report User")
                .customFont(.bold, 18)
                .foregroundColor(.primary)
            
            Text("If you report this user, you will no longer be able to interact with them. This action is irreversible.")
                .customFont(.regular, 14)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            ForEach(reasons, id: \.self) { reason in
                Button(action: {
                    onUserReported?(reason)
                    isPresented = false
                }) {
                    Text(reason)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Spacer()
            
            ActionButtonView(
                title: "Cancel",
                mode: .outlined
            ) {
                isPresented = false
            }.padding(.bottom)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }
}
