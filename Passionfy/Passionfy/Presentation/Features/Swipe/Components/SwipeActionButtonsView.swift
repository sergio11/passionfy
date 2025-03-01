//
//  SwipeActionButtonsView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import SwiftUI

struct SwipeActionButtonsView: View {
    
    var onSwipeAction: ((SwipeAction) -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 32) {
            Button {
                onSwipeAction?(.reject)
            } label: {
                Image(systemName: "xmark")
                    .fontWeight(.heavy)
                    .foregroundStyle(.red)
                    .background {
                        Circle()
                            .fill(.white)
                            .frame(width: 48, height: 48)
                            .shadow(radius: 6)
                    }
            }
            .frame(width: 48, height: 48)
            
            Button {
                onSwipeAction?(.like)
            } label: {
                Image(systemName: "heart.fill")
                    .fontWeight(.heavy)
                    .foregroundStyle(.green)
                    .background {
                        Circle()
                            .fill(.white)
                            .frame(width: 48, height: 48)
                            .shadow(radius: 6)
                    }
            }
            .frame(width: 48, height: 48)
        }
    }
}

struct SwipeActionButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeActionButtonsView()
    }
}
