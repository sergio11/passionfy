//
//  ExplanationText.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct ExplanationText: View {
    
    var message: String
    
    var body: some View {
        Text(message)
            .foregroundColor(Color(red: 70/255, green: 70/255, blue: 73/255))
            .fontWeight(.semibold)
            .font(.system(size: 14))
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
}

struct ExplanationText_Previews: PreviewProvider {
    static var previews: some View {
        ExplanationText(message: "A message")
    }
}
