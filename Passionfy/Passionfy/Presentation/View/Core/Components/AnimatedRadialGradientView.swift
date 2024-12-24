//
//  AnimatedRadialGradientView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 7/12/24.
//

import SwiftUI

struct AnimatedRadialGradientView: View {
    @State private var gradientCenter = UnitPoint.center
    @State private var gradientRadius: CGFloat = 500
    
    private let gradientAnimation = Animation.easeInOut(duration: 3)
            .repeatForever(autoreverses: true)

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            RadialGradient(
                gradient: Gradient(colors: [Color.pink.opacity(0.4), Color.clear]),
                center: gradientCenter,
                startRadius: 100,
                endRadius: gradientRadius
            )
            .ignoresSafeArea()
            .animation(gradientAnimation, value: gradientCenter)
            .animation(gradientAnimation, value: gradientRadius)
            .onAppear {
                gradientCenter = .init(x: 0.3, y: 0.7)
                gradientRadius = 950
            }
        }
    }
}

struct AnimatedRadialGradientView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedRadialGradientView()
    }
}
