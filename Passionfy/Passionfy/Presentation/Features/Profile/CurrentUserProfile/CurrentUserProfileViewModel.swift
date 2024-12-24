//
//  CurrentUserProfileViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import SwiftUI
import Factory

class CurrentUserProfileViewModel: BaseUserViewModel {
    
    @Injected(\.signOutUseCase) private var signOutUseCase: SignOutUseCase
    @Injected(\.eventBus) private var appEventBus: EventBus<AppEvent>
    
    @Published var showEditProfile: Bool = false
    @Published var showSignOutAlert = false


    func signOut() {
        executeAsyncTask({
                return try await self.signOutUseCase.execute()
        }) { [weak self] (result: Result<Void, Error>) in
            guard let self = self else { return }
            self.onSignOutCompleted()
        }
    }
    
    private func onSignOutCompleted() {
        self.appEventBus.publish(event: .loggedOut)
    }
}
