//
//  UserProfileInfoRow.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import SwiftUI

struct UserProfileInfoRowView: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.pink)
            
            Text(title)
                .customFont(.medium, 14)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}
