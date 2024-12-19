//
//  SwipeView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI

struct SwipeView: View {
    @StateObject var viewModel = SwipeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isSwipeLoading {
                    LoadingMatchesView(userPhoto: viewModel.user?.profileImageUrls[0])
                } else if viewModel.suggestions.isEmpty {
                    NoNewMatchesView()
                } else {
                    VStack(spacing: 16) {
                        ZStack {
                            ForEach(viewModel.suggestions) { card in
                                CardView(viewModel: viewModel, model: card)
                            }
                        }
                        if !viewModel.suggestions.isEmpty {
                            SwipeActionButtonsView(viewModel: viewModel)
                        }
                    }
                    .blur(radius: viewModel.showMatchView ? 20 : 0)

                    if viewModel.showMatchView, let matchedUser = viewModel.matchedUser {
                        UserMatchView(
                            show: $viewModel.showMatchView,
                            matchedUser: matchedUser
                        )
                    }
                }
            }
            .animation(.easeInOut, value: viewModel.showMatchView)
            .onReceive(viewModel.$matchedUser) { user in
                viewModel.showMatchView = user != nil
            }
            .addPassionfyToolbar()
            .onAppear {
                viewModel.loadCurrentUser()
                viewModel.fetchSuggestions()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    viewModel.isSwipeLoading = false
                }
            }
        }
    }
}


struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}
