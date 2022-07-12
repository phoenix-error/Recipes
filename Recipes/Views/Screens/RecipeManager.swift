//
//  RecipeManager.swift
//  Recipes
//
//  Created by Luca Becker on 08.06.22.
//

import SwiftUI

final class RecipeManager: ObservableObject {
    @Published var name = ""
    @Published var type: RecipeType = .unknown
    @Published var difficulty: RecipeDifficulty = .unknown
    @Published var image = ""
    @Published var prepTime = Int()
    @Published var cookTime = Int()
    @Published var ingredients = [RecipeIngredient]()
    @Published var steps = [String]()
    @Published var author = ""
    
    func formRecipe() -> Recipe {
        return Recipe(name: self.name,
                      type: self.type,
                      difficulty: self.difficulty,
                      image: self.image,
                      prepTime: self.prepTime,
                      cookTime: self.cookTime,
                      ingredients: self.ingredients,
                      steps: self.steps,
                      author: self.author
        )
    }
}
