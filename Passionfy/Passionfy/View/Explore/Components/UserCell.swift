//
//  UserCell.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import SwiftUI

struct UserCell: View {
    
    let user: User
    var onOpenProfileTapped: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                ProfileImageView(profileImageUrl: user.profileImageUrls[0])
                UserInfoDetailsView(user: user)
                Spacer()
                Button {
                    onOpenProfileTapped?()
                } label: {
                    Image(systemName: "arrow.up.circle")
                        .fontWeight(.bold)
                        .imageScale(.large)
                }
            }
            Text(user.bio.isEmpty ? "They preferred to keep it a secret for now..." : user.bio)
                    .customFont(.regular, 12)
                    .lineLimit(2)
        }
        .padding(.horizontal, 4)
        .background(Color.white)
    }
}

private struct UserInfoDetailsView: View {
    
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(user.username)
                .customFont(.semiBold, 16)
                .foregroundColor(.black)
                .lineLimit(1)
            
            if let birthdate = user.birthdate.toDate() {
                Text("\(birthdate.age) years old")
                    .customFont(.regular, 14)
                    .foregroundColor(.gray)
            }
        }
    }
}

private struct ProfileImageView: View {
    
    var profileImageUrl: String?
    
    var body: some View {
        CircularProfileImageView(
            profileImageUrl: profileImageUrl,
            size: .medium,
            allowShadow: false
        )
            .frame(width: 50, height: 50)
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: MockData.users[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
