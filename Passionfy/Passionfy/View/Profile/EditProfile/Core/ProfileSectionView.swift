//
//  ProfileSectionView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI

struct ProfileSectionView<Content: View>: View {
    var title: String
    var content: Content
    
    init(title: String, content: Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        Section {
            VStack(alignment: .leading) {
                Text(title)
                    .customFont(.bold, 16)
                    .padding(.leading)
                
                content
                    .padding()
                    .background(Color(.secondarySystemBackground))
            }.padding(.horizontal)
        }
    }
}
