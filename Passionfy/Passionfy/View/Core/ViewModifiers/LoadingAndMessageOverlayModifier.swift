//
//  LoadingAndErrorOverlayModifier.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 7/12/24.
//

import SwiftUI

struct LoadingAndMessageOverlayModifier: ViewModifier {
    @Binding var isLoading: Bool
    @Binding var message: String?
    var messageType: SnackbarType = .error
    var duration: Double = 3.0 // Duration before hiding the snackbar
    
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack {
                    LoadingView()
                        .opacity(isLoading ? 1 : 0)
                    
                    SnackbarView(
                        message: $message,
                        type: messageType,
                        duration: duration
                    )
                }
            }
    }
}

