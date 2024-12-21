//
//  AddRecentPicturesView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 14/12/24.
//

import SwiftUI

struct AddRecentPicturesView: View {
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        OnboardingStepView(
            isLoading: $viewModel.isLoading,
            errorMessage: $viewModel.errorMessage,
            message: "Add your recent pics to complete your profile. The first one will be your main profile picture. Hey! We recommend a face pic for better connections.",
            onContinue: {
                viewModel.nextFlowStep()
            },
            onBack: {
                viewModel.previousFlowStep()
            },
            isContinueButtonDisabled: viewModel.profileImages.isEmpty
        ) {
            PictureSelectionGridView(images: $viewModel.profileImages)
        }
    }
}

struct AddRecentPicturesView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecentPicturesView()
    }
}
