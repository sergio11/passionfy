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
    @Injected(\.likeUserUseCase) private var likeUserUseCase: LikeUserUseCase
    @Injected(\.dislikeUserUseCase) private var dislikeUserUseCase: DislikeUserUseCase
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
    
    func onLiked(withCard card: CardModel) {
        executeAsyncTask {
            return try await self.likeUserUseCase.execute(params: LikeUserParams(targetUserId: card.user.id))
        } completion: { [weak self] result in
            guard let self = self else { return }
            if case .success(let matchOccurred) = result {
                if matchOccurred {
                    appEventBus.publish(event: .matchOccurred(card.user))
                }
            }
        }
        removeCard(card)
    }
    
    func onDisliked(withCard card: CardModel) {
        executeAsyncTask {
            return try await self.dislikeUserUseCase.execute(params: DislikeUserParams(targetUserId: card.user.id))
        }
        removeCard(card)
    }

    private func removeCard(_ card: CardModel) {
        guard let index = suggestions.firstIndex(where: { $0.id == card.id }) else { return }
        suggestions.remove(at: index)
    }
    
    private func onGetSuggestionsCompleted(suggestions: [User]) {
        self.suggestions = suggestions.map { CardModel(user: $0) }
    }
}
