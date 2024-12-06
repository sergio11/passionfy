//
//  PassionfyApp.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import SwiftUI

@main
struct PassionfyApp: App {
    
    @StateObject var matchManager = MatchManager()
    
    var body: some Scene {
        WindowGroup {
            MainTabBar()
                .environmentObject(matchManager)
        }
    }
}
