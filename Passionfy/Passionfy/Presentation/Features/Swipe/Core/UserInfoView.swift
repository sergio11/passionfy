//
//  UserInfoView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import SwiftUI

struct UserInfoView: View {
    
    @Binding var showProfileModel: Bool
    
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(user.username)
                    .customFont(.medium, 18)
                
                if let birthdate = user.birthdate.toDate() {
                    Text("\(birthdate.age) years old")
                        .customFont(.regular, 16)
                }

                Spacer()
                
                Button {
                    showProfileModel.toggle()
                } label: {
                    Image(systemName: "arrow.up.circle")
                        .fontWeight(.bold)
                        .imageScale(.large)
                }
            }
            
            Text(user.bio.isEmpty ? "They preferred to keep it a secret for now..." : user.bio)
                    .customFont(.regular, 14)
                    .lineLimit(2)
        }
        .foregroundStyle(.white)
        .padding()
        .background(
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
        )
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(showProfileModel: .constant(false), user: MockData.users[1])
    }
}
