//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Luca Becker on 16.09.22.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    @Published var showingAddView = false
    
    let firebaseManager = FirebaseManager.shared
    
    init() {
        fetchRecipes()
    }
    
    func fetchRecipes() {
        firebaseManager.recipeReference.addSnapshotListener { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.recipes = documents.compactMap { queryDocumentSnapshot -> Recipe? in
                return try? queryDocumentSnapshot.data(as: Recipe.self)
            }
        }
    }
    
    func logout() {
        firebaseManager.logout()
        UserDefaults.standard.set(nil, forKey: Config.authTokenKey)
        AppManager.Authenticated.send(false)
    }
}
