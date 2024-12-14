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
            PictureSelectionGridView(profileImages: $viewModel.profileImages)
        }
    }
}

struct PictureSelectionGridView: View {
    @EnvironmentObject var viewModel: CreateAccountViewModel
    @Binding var profileImages: [UIImage]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(0..<viewModel.maxImages, id: \.self) { index in
                if index < profileImages.count {
                    profileImageCell(image: profileImages[index], index: index)
                } else {
                    emptyCell(index: index)
                }
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker { image in
                viewModel.onNewProfileImageSelected(image: image)
            }
        }
    }
    
    private func profileImageCell(image: UIImage, index: Int) -> some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: imageWidth, height: imageHeight)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .onTapGesture {
                viewModel.selectedIndex = index
                viewModel.showImagePicker = true
            }
    }
    
    private func emptyCell(index: Int) -> some View {
        ZStack(alignment: .bottomTrailing) {
            Image("onboarding_account_logo")
                .resizable()
                .scaledToFit()
                .frame(width: imageWidth, height: imageHeight)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                .onTapGesture {
                    viewModel.selectedIndex = index
                    viewModel.showImagePicker = true
                }
            
            Image(systemName: "plus.circle.fill")
                .imageScale(.large)
                .foregroundStyle(Color.pink)
                .offset(x: 4, y: 4)
                .onTapGesture {
                    viewModel.selectedIndex = index
                    viewModel.showImagePicker = true
                }
        }
    }
}

private extension PictureSelectionGridView {
    var columns: [GridItem] {
        [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    }
    
    var cornerRadius: CGFloat {
        return 10
    }
    
    var imageWidth: CGFloat {
        return 110
    }
    
    var imageHeight: CGFloat {
        return 160
    }
}

struct AddRecentPicturesView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecentPicturesView()
    }
}
