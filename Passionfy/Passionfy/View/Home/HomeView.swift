//
//  HomeView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        TabView {
            SwipeView()
                .tabItem { Image(systemName: "flame") }
                .tag(0)
            
            SearchView()
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(1)
            
            MessagingView()
                .tabItem {
                    Image(systemName: "message") }
                .tag(2)
            
            CurrentUserProfile()
                .tabItem { Image(systemName: "person") }
                .tag(3)
        }
        .tint(.primary)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
