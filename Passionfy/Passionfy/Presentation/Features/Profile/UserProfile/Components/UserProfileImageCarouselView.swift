//
//  UserProfileImageCarousel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import SwiftUI
import Kingfisher

struct UserProfileImageCarouselView: View {
    let user: User
    @Binding var currentImageIndex: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            KFImage(URL(string: user.profileImageUrls[currentImageIndex]))
                .resizable()
                .scaledToFill()
                .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
                .overlay {
                    ImageScrollingOverlay(currentImageIndex: $currentImageIndex, imageCount: user.profileImageUrls.count)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            CardImageIndicatorView(currentImageIndex: currentImageIndex, imageCount: user.profileImageUrls.count)
        }
    }
}
