//
//  MainView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        Group {
            NavigationView {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    if viewModel.hasSession {
                        HomeView()
                    } else {
                        OnboardingView(isAccountAuthenticated: $viewModel.hasSession)
                    }
                }
            }
        }
        .onAppear {
            viewModel.verifySession()
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
