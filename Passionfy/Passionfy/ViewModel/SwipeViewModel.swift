//
//  SwipeViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 18/12/24.
//

import Foundation

class SwipeViewModel: BaseUserViewModel {
    
    @Published var cardModels = [CardModel]()
    @Published var buttonSwipeAction: SwipeAction?
    @Published var showMatchView = false
    @Published var matchedUser: User?
    @Published var isSwipeLoading: Bool = true
    
    func checkForMatch(withUser user: User) {
        let didMatch = Bool.random()
        if didMatch {
            matchedUser = user
        }
    }

    
    func fetchCardModels() async {
        /*do {
            self.cardModels = try await service.fetchCardModels()
        } catch {
            print("DEBUG: Failed to fetch cards with error: \(error)")
        }*/
    }
    
    func removeCard(_ card: CardModel) {
        //guard let index = cardModels.firstIndex(where: { $0.id == card.id }) else { return }
        //cardModels.remove(at: index)
    }
}
