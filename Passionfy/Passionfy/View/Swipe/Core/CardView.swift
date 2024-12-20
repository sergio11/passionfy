//
//  CardView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import SwiftUI
import Kingfisher

struct CardView: View {
    
    @ObservedObject var viewModel: SwipeViewModel
    @State private var xOffset: CGFloat = 0
    @State private var degrees: Double = 0
    @State private var currentImageIndex = 0
    @State private var showProfileModal = false
    
    let model: CardModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                KFImage(URL(string:user.profileImageUrls[currentImageIndex]))
                    .resizable()
                    .scaledToFill()
                    .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
                    .overlay {
                        ImageScrollingOverlay(currentImageIndex: $currentImageIndex, imageCount: imageCount)
                    }
                
                CardImageIndicatorView(currentImageIndex: currentImageIndex, imageCount: imageCount)
                
                SwipeActionIndicatorView(xOffset: $xOffset)
            }
        
            UserInfoView(showProfileModel: $showProfileModal, user: user)
        }
        .onReceive(viewModel.$swipeAction, perform: { action in
            onReceiveSwipeAction(action)
        })
        .fullScreenCover(isPresented: $showProfileModal) {
            UserProfileView(user: user)
        }
        .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(x: xOffset)
        .rotationEffect(.degrees(degrees))
        .animation(.spring(), value: xOffset)
        .gesture(
            DragGesture()
                .onChanged(onDragChanged)
                .onEnded(onDragEnded)
        )
    }
}

private extension CardView {
    
    var user: User {
        return model.user
    }
    
    var imageCount: Int {
        return user.profileImageUrls.count
    }
}

private extension CardView {
    
    func returnToCenter() {
        withAnimation(.spring()) {
            xOffset = 0
            degrees = 0
        }
    }
    
    func swipeRight() {
        withAnimation(.spring()) {
            xOffset = 500
            degrees = 12
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            viewModel.removeCard(model)
            viewModel.checkForMatch(withUser: user)
        }
    }
    
    func swipeLeft() {
        withAnimation(.spring()) {
            xOffset = -500
            degrees = -12
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            viewModel.removeCard(model)
        }
    }
    
    func onReceiveSwipeAction(_ action: SwipeAction?) {
        guard let action else { return }
        viewModel.onClearSwipeAction()
        let topCard = viewModel.suggestions.last
        if topCard == model {
            switch action {
            case .reject:
                swipeLeft()
            case .like:
                swipeRight()
            }
        }
    }
}

private extension CardView {
    
    func onDragChanged(_ value: _ChangedGesture<DragGesture>.Value) {
        xOffset = value.translation.width
        degrees = Double(value.translation.width / 25)
    }
    
    func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        if abs(width) <= abs(SizeConstants.screenCutOff) {
            returnToCenter()
        } else {
            if width >= SizeConstants.screenCutOff {
                swipeRight()
            } else {
                swipeLeft()
            }
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(viewModel: SwipeViewModel(), model: CardModel(user: MockData.users[0]))
    }
}
