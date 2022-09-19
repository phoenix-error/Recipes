//
//  AddRecipeViewModel.swift
//  Recipes
//
//  Created by Luca Becker on 17.09.22.
//

import Foundation
import SwiftUI

class AddRecipeViewModel: ObservableObject {
    @Published var title = ""
    @Published var type: RecipeType = .unknown
    @Published var difficulty: RecipeDifficulty = .unknown
    @Published var image = UIImage()
    @Published var ingredients = [RecipeIngredient]()
    @Published var steps = [String]()
    @Published var author = ""
    
    @Published var newIngredient = ""
    @Published var newStep = ""
    
    @Published var showingImagePicker = false
    
    @Published var prepTime = 0
    @Published var cookTime = 0
    var imageURL: String?
    
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
    
    var imagePickerTitle: String {
        if image == UIImage() {
            return "Select Image"
        } else {
            return "Change Image"
        }
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
        let recipeStuff = { [self] in
            let recipe = Recipe(title: title,
                                type: type,
                                difficulty: difficulty,
                                image: self.imageURL,
                                prepTime: prepTime,
                                cookTime: cookTime,
                                ingredients: ingredients,
                                steps: steps,
                                author: author)
            
            firebaseManager.createRecipe(recipe)
        }
        if self.image != UIImage() {
            self.firebaseManager.uploadImage(image: self.image) { url in
                self.imageURL = url
                recipeStuff()
            }
        } else {
            recipeStuff()
        }
    }
}
