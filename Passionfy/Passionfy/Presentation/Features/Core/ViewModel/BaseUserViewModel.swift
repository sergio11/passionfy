//
//  BaseUserViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation
import Factory

class BaseUserViewModel: BaseViewModel {
    
    @Injected(\.getCurrentUserUseCase) private var getCurrentUserUseCase: GetCurrentUserUseCase
    
    @Published var user: User? = nil
    
    func loadCurrentUser() {
        executeAsyncTask {
            return try await self.getCurrentUserUseCase.execute()
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case .success(let user) = result {
                self.onCurrentUserLoaded(user: user)
            }
        }
    }
    
    internal func onCurrentUserLoaded(user: User) {
        self.user = user
    }
}
