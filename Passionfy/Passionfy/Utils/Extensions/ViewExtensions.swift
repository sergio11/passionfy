//
//  ViewExtensions.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI
import Combine

extension View {
    func limitText(_ upper: Int, binding: Binding<String>) -> some View {
        self.onReceive(Just(binding.wrappedValue)) { newValue in
            if newValue.count > upper {
                binding.wrappedValue = String(newValue.prefix(upper))
            }
        }
    }
    
    func filterNumericCharacters(binding: Binding<String>) -> some View {
        self.onReceive(Just(binding.wrappedValue)) { newValue in
            let filtered = newValue.filter { "0123456789".contains($0) }
            if filtered != newValue {
                binding.wrappedValue = filtered
            }
        }
    }
    
    func addPassionfyToolbar() -> some View {
            self.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 8) {
                        Image("logo_toolbar")
                            .resizable()
                            .frame(width: 42, height: 30)
                            .scaledToFit()
                            .padding(.leading)
                        Text("Passionfy")
                            .customFont(.semiBold, 20)
                            .foregroundColor(.pink.opacity(0.8))
                    }
                }
            }
        }
}
