//
//  HomeView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
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
            .blur(radius: viewModel.showMatchView ? 20 : 0)
            
            if viewModel.showMatchView, let matchedUser = viewModel.matchedUser{
                UserMatchView(
                    show: $viewModel.showMatchView,
                    matchedUser: matchedUser
                )
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
