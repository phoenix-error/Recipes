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
    
    @StateObject var firebaseManager = FirebaseManager()
    @StateObject var router = ViewRouter()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .onAppear(perform: {
                        firebaseManager.setRouter(router)
                        firebaseManager.setView()
                    })
                    .navigationViewStyle(.stack)
                    .navigationBarTitleDisplayMode(.inline)
                
            }
            .environmentObject(router)
            .environmentObject(firebaseManager)
        }
    }
}
