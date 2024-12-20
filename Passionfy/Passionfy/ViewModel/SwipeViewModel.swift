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
    @Injected(\.eventBus) private var appEventBus: EventBus<AppEvent>
    
    @Published var suggestions = [CardModel]()
    @Published var swipeAction: SwipeAction?
    @Published var isSwipeLoading: Bool = true
    @Published var matchedUser: User?
    @Published var showMatchView = false

    func fetchSuggestions() {
        self.isSwipeLoading = true
        executeAsyncTask {
            return try await self.getSuggestionsUseCase.execute()
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case .success(let users) = result {
                self.onGetSuggestionsCompleted(suggestions: users)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.isSwipeLoading = false
            }
        }
    }
    
    func onSwipeAction(_ action: SwipeAction) {
        self.swipeAction = action
    }
    
    func onClearSwipeAction() {
        self.swipeAction = nil
    }

    func removeCard(_ card: CardModel) {
        guard let index = suggestions.firstIndex(where: { $0.id == card.id }) else { return }
        suggestions.remove(at: index)
    }
    
    func checkForMatch(withUser user: User) {
        let didMatch = Bool.random()
        if didMatch {
            appEventBus.publish(event: .matchOccurred(user))
        }
    }
    
    private func onGetSuggestionsCompleted(suggestions: [User]) {
        self.suggestions = suggestions.map { CardModel(user: $0) }
    }
}
