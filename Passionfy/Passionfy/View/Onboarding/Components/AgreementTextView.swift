//
//  AgreementTextView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 7/12/24.
//

import SwiftUI

struct AgreementTextView: View {
    var body: some View {
        Text("By tapping \"Continue\", you agree to our Privacy Policy and Terms of Service.")
            .foregroundColor(Color.pink.opacity(0.6))
            .customFont(.semiBold, 14)
            .multilineTextAlignment(.center)
    }
}

struct AgreementTextView_Previews: PreviewProvider {
    static var previews: some View {
        AgreementTextView()
    }
}
