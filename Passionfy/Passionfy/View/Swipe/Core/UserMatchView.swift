//
//  UserMatchView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct UserMatchView: View {
    
    @Binding var show: Bool
    let matchedUser: User
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.opacity(0.7))
                .ignoresSafeArea()
            
            VStack(spacing: 120) {
                VStack {
                    Image(systemName: "circle")
                    
                    Text("You and \(matchedUser.username) liked each other.")
                        .foregroundColor(.white)
                }
                    
                HStack(spacing: 16) {
                    Image(matchedUser.profileImageUrls[0])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(.white, lineWidth: 2)
                                .shadow(radius: 4)
                        }
                    
                    Image(matchedUser.profileImageUrls[0])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(.white, lineWidth: 2)
                                .shadow(radius: 4)
                        }
                }
                
                VStack(spacing: 16) {
                    Button("Send Message") {
                        show.toggle()
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 350, height: 44)
                    .background(.pink)
                    .clipShape(Capsule())
                    
                    
                    Button("Keep Swiping") {
                        show.toggle()
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 350, height: 44)
                    .background(.clear)
                    .clipShape(Capsule())
                    .overlay {
                        Capsule()
                            .stroke(.white, lineWidth: 1)
                            .shadow(radius: 4)
                    }
                }
                
            }
        }
    }
}

struct UserMatchView_Previews: PreviewProvider {
    static var previews: some View {
        UserMatchView(show: .constant(true), matchedUser: MockData.users[0])
    }
}
