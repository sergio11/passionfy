//
//  UserProfileInfoSection.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//
import SwiftUI

struct UserProfileInfoSectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .customFont(.semiBold, 16)
            
            content
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
