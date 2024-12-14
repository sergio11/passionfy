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
                
                Image(user.profileImageUrls[0])
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .background {
                        Circle()
                            .fill(Color(.systemGray6))
                            .frame(width: 128, height: 128)
                            .shadow(radius: 10)
                    }
                
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
            
            Text("\(user.username), \(user.birthdate)")
                .font(.title2)
                .fontWeight(.light)
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
