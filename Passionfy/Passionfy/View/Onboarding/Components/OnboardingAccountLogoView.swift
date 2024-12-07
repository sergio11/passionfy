//
//  OnboardingAccountLogoView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 7/12/24.
//

import SwiftUI

struct OnboardingAccountLogoView: View {
    var body: some View {
        Image("onboarding_account_logo")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(Color.pink.opacity(0.8))
            .scaledToFit()
            .frame(width: 300)
            .padding(.top)
    }
}

struct OnboardingAccountLogoView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingAccountLogoView()
    }
}
