//
//  ChatDetailViewModel.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 24/12/24.
//

import SwiftUI
import Factory
import Combine

class ChatDetailViewModel: BaseViewModel {
    
    @Published var messageText: String = ""
    @Published var messages: [ChatMessage] = []
    
}
