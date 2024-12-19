//
//  SwipeViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import Foundation
import Factory

class SwipeViewModel: BaseUserViewModel {
    
    @Injected(\.getSuggestionsUseCase) private var getSuggestionsUseCase: GetSuggestionsUseCase
    
    @Published var suggestions = [CardModel]()
    @Published var buttonSwipeAction: SwipeAction?
    @Published var showMatchView = false
    @Published var matchedUser: User?
    @Published var isSwipeLoading: Bool = true

    
    func fetchSuggestions() {
        executeAsyncTask {
            return try await self.getSuggestionsUseCase.execute()
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case .success(let users) = result {
                self.onGetSuggestionsCompleted(suggestions: users)
            }
        }
    }
    
    
    private func onGetSuggestionsCompleted(suggestions: [User]) {
        self.suggestions = suggestions.map { CardModel(user: $0) }
    }
    
    func removeCard(_ card: CardModel) {
        //guard let index = cardModels.firstIndex(where: { $0.id == card.id }) else { return }
        //cardModels.remove(at: index)
    }
    
    func checkForMatch(withUser user: User) {
        let didMatch = Bool.random()
        if didMatch {
            matchedUser = user
        }
    }
}
