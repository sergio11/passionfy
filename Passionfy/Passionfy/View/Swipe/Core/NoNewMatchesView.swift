//
//  NoNewMatchesView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI

struct NoNewMatchesView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "heart.slash.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(.pink)
                .padding(.top, 40)
            
            Text("No new matches nearby.")
                .customFont(.bold, 24)
                .foregroundColor(.pink)
                .padding(.horizontal, 40)
                .multilineTextAlignment(.center)
            
            Text("You have swiped through all available profiles. Please wait a moment for new matches!")
                .customFont(.regular, 16)
                .foregroundColor(.pink.opacity(0.7))
                .padding(.horizontal, 40)
                .multilineTextAlignment(.center)
            
            ActionButtonView(
                title: "Wait for new matches",
                mode: .filled
            ) {
        
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
}

struct NoNewMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        NoNewMatchesView()
    }
}
