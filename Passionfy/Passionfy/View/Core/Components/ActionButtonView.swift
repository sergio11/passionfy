//
//  ActionButtonView.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

struct ActionButtonView: View {
    enum ButtonStyleMode {
        case filled
        case outlined
    }

    var title: String
    var mode: ButtonStyleMode
    var isDisabled: Bool = false
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, minHeight: 44)
                .foregroundColor(isDisabled ? Color.gray : (mode == .filled ? .white : .pink))
                .background(backgroundView)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(mode == .outlined ? Color.pink : Color.clear, lineWidth: 2)
                )
                .opacity(isDisabled ? 0.5 : 1.0)
        }
        .disabled(isDisabled)
        .frame(width: 350)
    }

    @ViewBuilder
    private var backgroundView: some View {
        if isDisabled {
            Color.gray
        } else {
            if mode == .filled {
                Color.pink
            } else {
                Color.clear
            }
        }
    }
}

struct ActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ActionButtonView(title: "Enabled Button", mode: .filled, isDisabled: false)
            ActionButtonView(title: "Disabled Button", mode: .filled, isDisabled: true)
        }
    }
}
