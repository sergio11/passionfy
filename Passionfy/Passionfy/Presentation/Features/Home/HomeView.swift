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
            TabView(selection: $viewModel.selectedTab) {
                SwipeView()
                    .tabItem { Image(systemName: "flame") }
                    .tag(0)
                
                ExploreView()
                    .tabItem { Image(systemName: "magnifyingglass") }
                    .tag(1)
                
                MessagingView()
                    .tabItem {
                        Image(systemName: "message")
                    }
                    .tag(2)
                
                CurrentUserProfile()
                    .tabItem { Image(systemName: "person") }
                    .tag(3)
            }
            .tint(.primary)
            .blur(radius: viewModel.showMatchView ? 20 : 0)
            
            if viewModel.showMatchView, let matchedUser = viewModel.matchedUser, let currentUser = viewModel.user {
                UserMatchView(
                    currentUser: currentUser,
                    matchedUser: matchedUser,
                    onKeepExploring: {
                        viewModel.onKeepExploring()
                    },
                    onSendMessage: {
                        viewModel.onSendMessage()
                    }
                )
            }
        }
        .onAppear {
            viewModel.loadCurrentUser()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
