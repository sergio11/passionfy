//
//  LoadingMatchesView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI

struct LoadingMatchesView: View {
    var userPhoto: String? = nil

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 16) {
                ZStack {
                    WaveAnimationView()
                        .frame(width: 250, height: 250)

            
                    if let userPhoto = userPhoto {
                        CircularProfileImageView(
                            profileImageUrl: userPhoto,
                            size: .xxLarge
                        )
                        .zIndex(1)
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 120, height: 120)
                            .overlay(
                                Circle()
                                    .stroke(Color.pink, lineWidth: 4)
                            )
                            .shadow(radius: 10)
                            .zIndex(1) 
                    }
                }
                
                Text("Searching for your best matches...")
                    .customFont(.bold, 20)
                    .foregroundColor(.pink)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
}


struct LoadingMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingMatchesView()
    }
}
