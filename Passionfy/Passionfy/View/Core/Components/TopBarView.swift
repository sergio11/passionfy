//
//  TopBarView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct TopBarView: View {
    var backButtonAction: (() -> Void)? = nil
    var title: String = "Passionfy."
    var backButtomIcon: String = "arrow.backward"
    var trailingActionContent: AnyView? = nil

    
    var body: some View {
        HStack {
            if let action = backButtonAction {
                Button {
                    action()
                } label: {
                    Image(systemName: backButtomIcon)
                        .foregroundColor(Color.pink)
                        .font(.system(size: 20))
                }.padding(.leading)
            }
            Spacer()
            Text(title)
                .customFont(.bold, 22)
                .foregroundColor(Color.pink)
            Spacer()
            if let trailingActionContent = trailingActionContent {
                trailingActionContent
                    .padding(.trailing)
            }
        }
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
