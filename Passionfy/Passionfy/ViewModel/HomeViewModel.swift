//
//  HomeViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 19/12/24.
//

import SwiftUI
import Factory
import Combine

class HomeViewModel: BaseViewModel {
    
    @Injected(\.eventBus) internal var appEventBus: EventBus<AppEvent>
    
    @Published var matchedUser: User?
    @Published var showMatchView = false
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        appEventBus.subscribe()
            .sink { [weak self] event in
                if case .matchOccurred(let user) = event {
                    self?.matchedUser = user
                    self?.showMatchView = true
                    print("Matched with user: \(user.username)")
                }
            }
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.removeAll()
    }
}
