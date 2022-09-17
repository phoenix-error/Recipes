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
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var firebaseManager = FirebaseManager()
    
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

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
