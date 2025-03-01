//
//  MainViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI
import Factory
import Combine

class MainViewModel: BaseViewModel {
    
    @Published var hasSession = false
    
    @Injected(\.verifySessionUseCase) private var verifySessionUseCase: VerifySessionUseCase
    @Injected(\.eventBus) internal var appEventBus: EventBus<AppEvent>
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        setupSubscriptions()
    }
    
    func verifySession() {
        executeAsyncTask({
            return try await self.verifySessionUseCase.execute()
        }) { [weak self] (result: Result<Bool, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let hasSession):
                if hasSession {
                    self.onActiveSessionFound()
                } else {
                    self.onNotActiveSessionFound()
                }
            case .failure:
                self.onNotActiveSessionFound()
            }
        }
    }

    private func onNotActiveSessionFound() {
        self.hasSession = false
    }

    private func onActiveSessionFound() {
        self.hasSession = true
    }
    
    private func setupSubscriptions() {
        appEventBus.subscribe()
            .sink { [weak self] event in
                if case .loggedOut = event {
                    self?.verifySession()
                }
            }
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.removeAll()
    }
}
