//
//  ExploreViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import Foundation
import Factory
import Combine

class ExploreViewModel: BaseViewModel {
    
    @Injected(\.searchUsersUseCase) private var searchUsersUseCase: SearchUsersUseCase
    @Injected(\.getSuggestionsUseCase) private var getSuggestionsUseCase: GetSuggestionsUseCase
    
    @Published var selectedUser: User? = nil
    
    @Published var searchText = "" {
        didSet {
            fetchData()
        }
    }
    @Published var users = [User]()
        
    func fetchData() {
        if(!searchText.isEmpty) {
            searchUsers()
        } else {
            fetchSuggestions()
        }
    }
        
    private func fetchSuggestions() {
        fetchUsers(using: self.getSuggestionsUseCase.execute)
    }

    private func searchUsers() {
        fetchUsers(using: { try await self.searchUsersUseCase.execute(params: SearchUsersParams(term: self.searchText)) })
    }
        
    private func fetchUsers(using fetchTask: @escaping () async throws -> [User]) {
        executeAsyncTask({
            return try await fetchTask()
        }) { [weak self] (result: Result<[User], Error>) in
            guard let self = self else { return }
            if case .success(let users) = result {
                self.onFetchDataCompleted(users: users)
            }
        }
    }
        
    private func onFetchDataCompleted(users: [User]) {
        self.users = users
    }
}
