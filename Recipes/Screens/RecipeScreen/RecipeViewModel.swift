//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Luca Becker on 18.09.22.
//

import Foundation

class RecipeViewModel: ObservableObject {
    
    @Published var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
