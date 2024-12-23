//
//  CurrentUserProfileHeaderView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct CurrentUserProfileHeaderView: View {
    
    let user: User
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                
                CircularProfileImageView(
                    profileImageUrl: user.profileImageUrls[0],
                    size: .xxLarge
                )
        
                Image(systemName: "pencil")
                    .imageScale(.small)
                    .foregroundStyle(.gray)
                    .background {
                        Circle()
                            .fill(.white)
                            .frame(width: 32, height: 32)
                    }
                    .offset(x: -8, y: 10)
            }
            
            if let birthdate = user.birthdate.toDate() {
                Text("\(user.username), \(birthdate.age)")
                    .customFont(.semiBold, 20)
            } else {
                Text("\(user.username) - \(user.birthdate)")
                    .customFont(.semiBold, 20)
            }
     
            Text(
                (user.city.isEmpty ? "" : user.city) +
                (user.city.isEmpty || user.country.isEmpty ? "" : ", ") +
                user.country
            )
            .customFont(.regular, 16)
            .foregroundColor(.gray)
            .padding(.top, 4)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 240)
    }
}

struct CurrentUserProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileHeaderView(user: MockData.users[0])
    }
}
