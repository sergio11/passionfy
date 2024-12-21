//
//  SnackbarView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

enum SnackbarType {
    case success
    case error
    case info
}

struct SnackbarView: View {
    @Binding var message: String?
    var type: SnackbarType = .error
    var duration: Double = 5.0  // Duration before hiding the snackbar
    
    var body: some View {
        if let message = message, !message.isEmpty {
            VStack {
                Spacer()
                HStack {
                    icon
                    Text(message)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding()
                .background(backgroundColor)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 4)
                .transition(.move(edge: .bottom))
                .onAppear {
                    // Hide the snackbar after the given duration
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            self.message = nil
                        }
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
            .animation(.easeInOut, value: message)
        }
    }
    
    // Icon based on the type of the snackbar
    private var icon: some View {
        Group {
            switch type {
            case .success:
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.white)
            case .error:
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.white)
            case .info:
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.white)
            }
        }
        .imageScale(.large)
    }
    
    // Background color based on the type of the snackbar
    private var backgroundColor: Color {
        switch type {
        case .success:
            return Color.green
        case .error:
            return Color.red
        case .info:
            return Color.blue
        }
    }
}
