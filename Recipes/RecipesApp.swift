//
//  RecipesApp.swift
//  Recipes
//
//  Created by Luca Becker on 08.05.22.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct RecipesApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var firebaseManager = FirebaseManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RootView()
                    .navigationViewStyle(.stack)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .environmentObject(firebaseManager)
            .onChange(of: scenePhase) { phase in
                if phase == .background {
                    // Save here
                }
            }
        }
    }
}
