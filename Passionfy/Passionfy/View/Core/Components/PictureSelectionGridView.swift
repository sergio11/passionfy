//
//  PictureSelectionGridView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import SwiftUI
import Kingfisher

struct PictureSelectionGridView: View {
    let maxImages = 6
    @Binding var images: [UnifiedImage]
    @State private var showImagePicker = false
    @State private var selectedIndex: Int?
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(0..<maxImages, id: \.self) { index in
                if index < images.count {
                    unifiedImageCell(image: images[index], index: index)
                } else {
                    emptyCell(index: index)
                }
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker { image in
                onNewProfileImageSelected(image: image)
            }
        }
    }
    
    private func onNewProfileImageSelected(image: UIImage) {
        if let index = selectedIndex {
            if index < images.count {
                images[index] = .local(image)
            } else if images.count < maxImages {
                images.append(.local(image))
            }
        }
    }
    
    private func unifiedImageCell(image: UnifiedImage, index: Int) -> some View {
        switch image {
        case .local(let uiImage):
            return AnyView(localImageCell(image: uiImage, index: index))
        case .remote(let url):
            return AnyView(remoteImageCell(url: url, index: index))
        }
    }
    
    private func localImageCell(image: UIImage, index: Int) -> some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: imageWidth, height: imageHeight)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .onTapGesture {
                selectedIndex = index
                showImagePicker = true
            }
    }
    
    private func remoteImageCell(url: URL, index: Int) -> some View {
        KFImage(url)
            .placeholder {
                ProgressView()
                    .frame(width: imageWidth, height: imageHeight)
            }
            .resizable()
            .scaledToFill()
            .frame(width: imageWidth, height: imageHeight)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .onTapGesture {
                selectedIndex = index
                showImagePicker = true
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
                    selectedIndex = index
                    showImagePicker = true
                }
            
            Image(systemName: "plus.circle.fill")
                .imageScale(.large)
                .foregroundStyle(Color.pink)
                .offset(x: 4, y: 4)
                .onTapGesture {
                    selectedIndex = index
                    showImagePicker = true
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

