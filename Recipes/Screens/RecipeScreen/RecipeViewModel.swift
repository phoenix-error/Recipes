//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Luca Becker on 18.09.22.
//

import Foundation

class RecipeViewModel: ObservableObject {
    
    @Published var recipe: Recipe
    
    let firebaseManager = FirebaseManager.shared
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func deleteRecipe() {
        // Delete image from Storage
        if let image = recipe.image {
            firebaseManager.deleteImage(url: image)
        }

        // Delete Recipe from Firestore
        firebaseManager.deleteRecipe(recipe)
    }
}
