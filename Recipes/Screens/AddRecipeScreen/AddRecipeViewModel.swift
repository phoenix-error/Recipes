//
//  AddRecipeViewModel.swift
//  Recipes
//
//  Created by Luca Becker on 17.09.22.
//

import Foundation

class AddRecipeViewModel: ObservableObject {
    @Published var title = ""
    @Published var type: RecipeType = .unknown
    @Published var difficulty: RecipeDifficulty = .unknown
    @Published var image = ""
    @Published var prepTime = 0
    @Published var cookTime = 0
    @Published var ingredients = [RecipeIngredient]()
    @Published var steps = [String]()
    @Published var author = ""
    
    @Published var newIngredient = ""
    @Published var newStep = ""
    
    let firebaseManager = FirebaseManager.shared
    
    // Can add recipe to database
    var actionButtonEnabled: Bool {
        !title.isEmpty && !author.isEmpty &&
        !ingredients.isEmpty && !steps.isEmpty &&
        type != .unknown && difficulty != .unknown
    }
    
    var navTitle: String {
        return "Add Recipe"
    }
    
    var pickerDifficulty: String {
        get {
            difficulty.string
        }
        set {
            difficulty = RecipeDifficulty(rawValue: newValue.lowercased())!
        }
    }
    
    var pickerType: String {
        get {
            type.string
        }
        
        set {
            type = RecipeType(rawValue: newValue.lowercased())!
        }
    }
    
    func addIngredient() {
        // TODO: Need way to implement amount and unit
        let ingredient = RecipeIngredient(name: newIngredient, amount: Float.random(in: 1...10), unit: ["kg", "ml", "mg", "g", "l"].randomElement()!)
        self.ingredients.append(ingredient)
        newIngredient = ""
    }
    
    func addStep() {
        self.steps.append(newStep)
        newStep = ""
    }
    
    func addRecipe() {
        let recipe = Recipe(title: title,
                            type: type,
                            difficulty: difficulty,
                            image: "",
                            prepTime: prepTime,
                            cookTime: cookTime,
                            ingredients: ingredients,
                            steps: steps,
                            author: author)
        
        firebaseManager.createRecipe(recipe)
    }
}
