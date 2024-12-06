//
//  CurrentUserProfile.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct CurrentUserProfile: View {
    
    @State private var showEditProfile: Bool = false
    let user: User
    
    var body: some View {
        NavigationStack {
            List {
                // header view
                CurrentUserProfileHeaderView(user: user)
                    .onTapGesture {
                        showEditProfile.toggle()
                    }
                
                // account info
                Section("Account Information") {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(user.fullname)
                    }
                    HStack {
                        Text("Email")
                        Spacer()
                        Text("test@gmail.com")
                    }
                }
                
                // legal
                Section("Legal") {
                    Text("Terms of Service")
                }
                
                // logout / delete
                Section {
                    Button("Logout") {
                        print("DEBUG: Logout")
                    }
                }.foregroundStyle(.red)
                
                Section {
                    Button("Delete Account") {
                        print("DEBUG: Delete account")
                    }
                }.foregroundStyle(.red)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
}

struct CurrentUserProfile_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfile(user: MockData.users[0])
    }
}
