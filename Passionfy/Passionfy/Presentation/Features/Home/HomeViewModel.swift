//
//  HomeViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 19/12/24.
//

import SwiftUI
import Factory
import Combine

class HomeViewModel: BaseUserViewModel {
    
    @Injected(\.eventBus) internal var appEventBus: EventBus<AppEvent>
    
    @Published var matchedUser: User?
    @Published var showMatchView = false
    @Published var selectedTab: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        setupSubscriptions()
    }
    
    func onKeepExploring() {
        self.showMatchView = false
    }
    
    func onSendMessage() {
        self.showMatchView = false
        self.selectedTab = 2
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
