//
//  TransitioningView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 14/12/24.
//

import SwiftUI

struct TransitioningView<Content: View>: View {
    let content: Content
    let transition: AnyTransition
    
    init(transition: AnyTransition = .opacity, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.transition = transition
    }
    
    var body: some View {
        content
            .transition(transition)
    }
}
