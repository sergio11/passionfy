//
//  WaveAnimationView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI

struct WaveAnimationView: View {
    @State private var waveScale: CGFloat = 1

    var body: some View {
        ZStack {
            ForEach(0..<4) { index in
                Circle()
                    .stroke(Color.pink.opacity(0.5 - Double(index) * 0.1), lineWidth: 3)
                    .frame(width: CGFloat(100 + (index * 50)), height: CGFloat(100 + (index * 50)))
                    .scaleEffect(waveScale)
                    .opacity(Double(4 - index) / 4)
                    .animation(
                        Animation.easeOut(duration: 1.5)
                            .repeatForever(autoreverses: false)
                            .delay(Double(index) * 0.3),
                        value: waveScale
                    )
            }
        }
        .onAppear {
            waveScale = 1.5
        }
    }
}

struct WaveAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        WaveAnimationView()
            .frame(width: 300, height: 300)
    }
}
