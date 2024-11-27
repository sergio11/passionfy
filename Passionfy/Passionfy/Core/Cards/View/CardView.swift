//
//  CardView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import SwiftUI

struct CardView: View {
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("example")
                .resizable()
                .scaledToFit()
            
            UserInfoView()
        }
        .frame(width: cardWidth, height: cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


private extension CardView {
    var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
    var cardHeight: CGFloat {
        UIScreen.main.bounds.height / 1.45
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
