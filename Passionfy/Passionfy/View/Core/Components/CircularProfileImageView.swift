//
//  CircularProfileImageView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    case xxLarge
    
    var dimension: CGFloat {
        switch self {
            case .xxSmall: return 28
            case .xSmall: return 32
            case .small: return 40
            case .medium: return 48
            case .large: return 64
            case .xLarge: return 80
            case .xxLarge: return 128
        }
    }
}


struct CircularProfileImageView: View {
    var profileImageUrl: String?
    let size: ProfileImageSize
    var allowShadow: Bool = true

    var body: some View {
        if let imageUrl = profileImageUrl, !imageUrl.isEmpty {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .background {
                    Circle()
                        .fill(Color(.systemGray6))
                        .frame(width: size.dimension, height: size.dimension)
                        .shadow(radius: allowShadow ? 10: 0)
                }
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(profileImageUrl: MockData.users[0].profileImageUrls[0], size: .medium)
    }
}
