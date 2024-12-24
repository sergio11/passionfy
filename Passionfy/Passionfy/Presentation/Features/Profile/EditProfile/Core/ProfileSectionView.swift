//
//  ProfileSectionView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI

struct ProfileSectionView<Content: View>: View {
    var title: String
    var icon: String
    var content: Content
    
    init(title: String, icon: String, content: Content) {
        self.title = title
        self.icon = icon
        self.content = content
    }

    var body: some View {
        Section {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(.pink)
                    Text(title)
                        .customFont(.bold, 16)
                        .foregroundColor(.pink)
                }
                .padding(.vertical, 6)
                
                content
                    .padding()
                    .background(Color(.secondarySystemBackground))
            }
            .padding(.horizontal)
        }
    }
}
