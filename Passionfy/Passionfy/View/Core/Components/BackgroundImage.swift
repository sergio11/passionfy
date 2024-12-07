//
//  BackgroundImage.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct BackgroundImage: View {
    
    let imageName: String
    let offsetXFactor: CGFloat = 0.3
    let offsetYFactor: CGFloat = 0.2
    
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                animatedImage(reader: reader)
                Color.black
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
            }
            .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
        }
    }
    
    @ViewBuilder
    private func animatedImage(reader: GeometryProxy) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .offset(x: offsetX, y: offsetY)
            .frame(width: reader.size.width * 2, height: reader.size.height * 2)
            .clipped()
            .onAppear {
                withAnimation(.linear(duration: 15).repeatForever(autoreverses: true)) {
                    offsetX = -reader.size.width * offsetXFactor
                    offsetY = -reader.size.height * offsetYFactor
                }
            }
    }
}
