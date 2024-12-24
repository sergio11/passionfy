//
//  AnimatedGradientView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct AnimatedGradientView: View {
    @State private var gradientStart = UnitPoint.topLeading
    @State private var gradientEnd = UnitPoint.bottomTrailing
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.pink.opacity(0.6),
                Color.red.opacity(0.4),
                Color.purple.opacity(0.6)
            ]),
            startPoint: gradientStart,
            endPoint: gradientEnd
        )
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .blendMode(.overlay)
        .onAppear {
            animateGradient()
        }
    }
    
    private func animateGradient() {
        withAnimation(
            Animation.linear(duration: 5.0)
                .repeatForever(autoreverses: true)
        ) {
            gradientStart = UnitPoint.bottomTrailing
            gradientEnd = UnitPoint.topLeading
        }
    }
}
