//
//  UnifiedImage.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 21/12/24.
//

import UIKit
import SwiftUI

enum UnifiedImage: Identifiable {
    case local(UIImage)
    case remote(URL)

    var id: String {
        switch self {
        case .local(let image):
            return "\(image.hashValue)"
        case .remote(let url):
            return url.absoluteString
        }
    }
}
