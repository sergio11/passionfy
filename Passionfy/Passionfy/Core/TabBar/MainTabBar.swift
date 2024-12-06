//
//  MainTabBar.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import SwiftUI

struct MainTabBar: View {
    
    var body: some View {
        TabView {
            CardStackView()
                .tabItem { Image(systemName: "flame") }
                .tag(0)
            
            Text("Search View")
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(1)
            
            Text("Inbox View")
                .tabItem {
                    Image(systemName: "message") }
                .tag(2)
            
            CurrentUserProfile(user: MockData.users[1])
                .tabItem { Image(systemName: "person") }
                .tag(3)
        }
        .tint(.primary)
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar()
    }
}
