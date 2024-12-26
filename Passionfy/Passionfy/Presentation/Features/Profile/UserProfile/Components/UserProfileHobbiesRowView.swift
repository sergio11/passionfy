//
//  UserProfileHobbiesRow.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import SwiftUI

struct UserProfileHobbiesRowView: View {
    let hobbies: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                if hobbies.isEmpty {
                    Text("Prefers to keep their hobbies a secret.")
                        .customFont(.medium, 14)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                } else {
                    ForEach(hobbies, id: \.self) { hobby in
                        Text(hobby)
                            .customFont(.medium, 14)
                            .padding(10)
                            .background(Color.pink.opacity(0.2))
                            .foregroundColor(.pink)
                            .cornerRadius(20)
                    }
                }
            }
        }
        .frame(height: 40)
    }
}

