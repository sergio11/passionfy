//
//  ExploreView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import SwiftUI

struct ExploreView: View {
    @StateObject var viewModel = ExploreViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Explore Passionfy Users")
                            .customFont(.bold, 22)
                            .foregroundColor(.pink)
                    }
                }
                .searchable(text: $viewModel.searchText, prompt: "Search for passionate profiles...")
                .onAppear {
                    viewModel.fetchData()
                }
        }
        .modifier(LoadingAndMessageOverlayModifier(
            isLoading: $viewModel.isLoading,
            message: viewModel.message,
            messageType: viewModel.messageType
        ))
        // Usamos fullScreenCover para presentar la vista de perfil en pantalla completa
        .fullScreenCover(item: $viewModel.selectedUser) { user in
            UserProfileView(user: user)
        }
    }
    
    private var content: some View {
        VStack {
            if viewModel.users.isEmpty {
                emptyStateView
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.users) { user in
                            userNavigationLink(for: user)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.top, 20)
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: viewModel.searchText.isEmpty ? "magnifyingglass" : "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.pink)
            
            Text(viewModel.searchText.isEmpty ?
                 "Ready to meet someone new? Start searching for passionate profiles here!" :
                 "Oops! No results found. Try adjusting your search and see what you find!")
                .customFont(.regular, 18)
                .foregroundColor(.pink)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }

    @ViewBuilder
    private func userNavigationLink(for user: User) -> some View {
        UserCell(
            user: user,
            onOpenProfileTapped: {
                viewModel.selectedUser = user
            }
        )
        .padding(.vertical, 4)
        .background(Divider(), alignment: .bottom)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
