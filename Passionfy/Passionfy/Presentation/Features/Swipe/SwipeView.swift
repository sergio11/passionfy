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
                    NoNewMatchesView {
                        viewModel.fetchSuggestions()
                    }
                } else {
                    VStack(spacing: 16) {
                        ZStack {
                            ForEach(viewModel.suggestions) { card in
                                CardView(viewModel: viewModel, model: card)
                            }
                        }
                        if !viewModel.suggestions.isEmpty {
                            SwipeActionButtonsView { action in
                                viewModel.onSwipeAction(action)
                            }
                        }
                    }
                }
            }
            .addPassionfyToolbar()
            .onAppear {
                viewModel.loadCurrentUser()
                viewModel.fetchSuggestions()
            }
        }
    }
}


struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}
