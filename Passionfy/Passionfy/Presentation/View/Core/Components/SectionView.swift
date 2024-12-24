//
//  SectionView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import SwiftUI

struct SectionView: View {
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
