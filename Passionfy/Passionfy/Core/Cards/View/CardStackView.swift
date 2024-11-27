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
        ZStack {
            ForEach(viewModel.cardModels) { card in
                CardView(viewModel: viewModel, model: card)
            }
        }
    }
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
    }
}
