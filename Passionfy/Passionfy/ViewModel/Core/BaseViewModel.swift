//
//  BaseViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation
import SwiftUI

class BaseViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showAlert = false
    @Published var successMessage: String? = nil
    
    // Computed property to get the correct message Binding
    var message: Binding<String?> {
        Binding<String?>(
            get: { self.successMessage ?? self.errorMessage },
            set: { message in
                if self.messageType == .success {
                    self.successMessage = message
                } else {
                    self.errorMessage = message
                }
            }
        )
    }
        
    // Computed property for message type
    var messageType: SnackbarType {
        if successMessage != nil {
            return .success
        } else {
            return .error
        }
    }
    
    internal func onLoading() {
        updateUI { vm in
            vm.isLoading = true
        }
    }
    
    internal func onIddle() {
        updateUI { vm in
            vm.isLoading = false
        }
    }
    
    internal func handleError(error: Error) {
        print(error.localizedDescription)
        updateUI { vm in
            vm.isLoading = false
            vm.errorMessage = error.localizedDescription
            vm.showAlert.toggle()
        }
    }
    
    
    internal func updateUI<ViewModelType: BaseViewModel>(with updates: @escaping (ViewModelType) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let viewModel = self as? ViewModelType {
                updates(viewModel)
            }
        }
    }
    
    internal func executeAsyncTask<T>(_ task: @escaping () async throws -> T, completion: ((Result<T, Error>) -> Void)? = nil) {
        Task {
            onLoading()
            do {
                let result = try await task()
                DispatchQueue.main.async {
                    completion?(.success(result))
                }
            } catch {
                handleError(error: error)
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
            }
            onIddle()
        }
    }
}
