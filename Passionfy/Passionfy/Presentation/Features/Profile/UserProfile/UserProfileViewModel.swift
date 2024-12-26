//
//  UserProfileViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import SwiftUI
import Factory

class UserProfileViewModel: BaseViewModel {
    
    @Injected(\.reportUserUseCase) private var reportUserUseCase: ReportUserUseCase
    
    @Published var currentImageIndex = 0
    @Published var showReportSheet = false
    @Published var userReported = false
    
    func onUserReported(userId: String, reason: String) {
        executeAsyncTask({
                return try await self.reportUserUseCase.execute(
                    params: ReportUserParams(reportedId: userId, reason: reason)
                )
        }) { [weak self] (result: Result<Void, Error>) in
            guard let self = self else { return }
            self.onUserReportedCompleted()
        }
    }
    
    private func onUserReportedCompleted() {
        self.userReported = true
        self.successMessage = "User reported, thanks for your time"
    }
}
