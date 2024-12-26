//
//  UserProfileHeaderView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import SwiftUI

struct UserProfileHeaderView: View {
    let user: User
    let dismiss: DismissAction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(user.username)
                    .customFont(.semiBold, 20)
                
                if let birthdate = user.birthdate.toDate() {
                    Text("\(birthdate.age) years old")
                        .customFont(.regular, 18)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.down.circle.fill")
                    .imageScale(.large)
                    .fontWeight(.bold)
                    .foregroundStyle(.pink)
            }
        }
    }
}
