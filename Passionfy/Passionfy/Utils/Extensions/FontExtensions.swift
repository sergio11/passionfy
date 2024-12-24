//
//  FontExtensions.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import SwiftUI

enum FontWeight {
    case light
    case regular
    case medium
    case semiBold
    case bold
    case black
}

extension Font {
    static let customFont: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .light:
            return Font.custom("Outfit-Light", size: size)
        case .regular:
            return Font.custom("Outfit-Regular", size: size)
        case .medium:
            return Font.custom("Outfit-Medium", size: size)
        case .semiBold:
            return Font.custom("Outfit-SemiBold", size: size)
        case .bold:
            return Font.custom("Outfit-Bold", size: size)
        case .black:
            return Font.custom("Outfit-Black", size: size)
        }
    }
}

extension Text {
    func customFont(_ fontWeight: FontWeight = .regular, _ size: CGFloat = 16) -> Text {
        return self.font(.customFont(fontWeight, size))
    }
}

extension TextField {
    func customFont(_ fontWeight: FontWeight = .regular, _ size: CGFloat = 16) -> some View {
        return self.font(.customFont(fontWeight, size))
    }
}

extension TextEditor {
    func customFont(_ fontWeight: FontWeight = .regular, _ size: CGFloat = 16) -> some View {
        return self.font(.customFont(fontWeight, size))
    }
}

