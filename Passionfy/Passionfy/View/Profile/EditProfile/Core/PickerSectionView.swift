//
//  PickerSectionView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI

struct PickerSectionView: View {
    var title: String
    var icon: String
    @Binding var selection: String
    var options: [String]

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
            
                HStack {
                    Picker("", selection: $selection) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .customFont(.bold, 16)
                                .tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                
            }
            .padding(.horizontal)
        }
    }
}
