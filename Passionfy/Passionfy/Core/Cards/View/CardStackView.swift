//
//  CardStackView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import SwiftUI

struct CardStackView: View {
    
    @StateObject var viewModel = CardsViewModel(service: CardService())
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                ForEach(viewModel.cardModels) { card in
                    CardView(viewModel: viewModel, model: card)
                }
            }
            if !viewModel.cardModels.isEmpty {
                SwipeActionButtonsView(viewModel: viewModel)
            }
        }
        
    }
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
    }
}
