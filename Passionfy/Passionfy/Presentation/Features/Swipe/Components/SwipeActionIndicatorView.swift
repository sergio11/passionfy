//
//  SwipeActionIndicatorView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import SwiftUI

struct SwipeActionIndicatorView: View {
    
    @Binding var xOffset: CGFloat
    
    var body: some View {
        HStack {
            Text("LIKE")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(.green)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.green, lineWidth: 2)
                        .frame(width: 100, height: 48)
                )
                .rotationEffect(.degrees(-45))
                .opacity(Double(xOffset / SizeConstants.screenCutOff))
            
            Spacer()
            
            Text("NOPE")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.red, lineWidth: 2)
                        .frame(width: 100, height: 48)
                )
                .rotationEffect(.degrees(45))
                .opacity(Double(xOffset / SizeConstants.screenCutOff) * -1)
        }
        .padding(40)
    }
}

struct SwipeActionIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeActionIndicatorView(xOffset: .constant(20))
    }
}
