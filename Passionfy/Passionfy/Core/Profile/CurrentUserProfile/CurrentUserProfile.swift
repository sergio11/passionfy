//
//  CurrentUserProfile.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct CurrentUserProfile: View {
    
    let user: User
    
    var body: some View {
        NavigationStack {
            List {
                // header view
                CurrentUserProfileHeaderView(user: user)
                
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
    }
}

struct CurrentUserProfile_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfile(user: MockData.users[0])
    }
}
