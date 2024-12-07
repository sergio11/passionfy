//
//  NumericInputModifier.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 7/12/24.
//

import SwiftUI
import Combine

struct NumericInputModifier: ViewModifier {
    @Binding var value: String
    var title: String
    
    func body(content: Content) -> some View {
        content
            .onReceive(Just(value)) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue {
                    self.value = filtered
                }
                if title != "YYYY" && value.count > 2 {
                    self.value = String(value.prefix(2))
                } else if title == "YYYY" && value.count > 4 {
                    self.value = String(value.prefix(4))
                }
            }
    }
}

extension View {
    func numericInput(value: Binding<String>, title: String) -> some View {
        self.modifier(NumericInputModifier(value: value, title: title))
    }
}
