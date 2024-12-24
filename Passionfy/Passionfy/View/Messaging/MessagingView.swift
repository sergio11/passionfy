//
//  MessagingView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI

struct MessagingView: View {

    @StateObject var viewModel = MessagingViewModel()
    
    var body: some View {
        VStack {
            // New Matches Section
            NewMatchesView(newMatches: viewModel.newMatches)
            
            Divider()
        
        }
        .navigationTitle("Messages")
    }
}


private struct NewMatchesView: View {
    
    var newMatches: [User]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(newMatches) { match in
                    VStack {
                        CircularProfileImageView(
                            profileImageUrl: match.profileImageUrls[0],
                            size: .large
                        )
                        Text(match.username)
                            .customFont(.medium, 16)
                            .lineLimit(1)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, match.id == newMatches.first?.id ? 16 : 0)
                }
            }
        }
        .frame(height: 100)
        .padding(.vertical)
    }
}

// Previews
struct MessagingView_Previews: PreviewProvider {
    static var previews: some View {
        MessagingView()
    }
}
