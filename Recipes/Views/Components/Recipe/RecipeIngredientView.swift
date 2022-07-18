//
//  RecipeIngredientView.swift
//  Recipes
//
//  Created by Luca Becker on 05.07.22.
//

import SwiftUI

struct RecipeIngredientView: View {
    @EnvironmentObject var recipeManager: RecipeManager
    var recipe: Recipe?
    
    var ingredients: [RecipeIngredient] {
        
        guard let recipe = recipe else {
            return recipeManager.ingredients
            }
        return recipe.ingredients
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(ingredients, id: \.self) { ingredient in
                    HStack {
                        Text(ingredient.name)
                        Spacer()
                        Text("\(ingredient.amount, specifier: "%.0f")\(ingredient.unit ?? "")")
                    }
                }
            }
        }
    }
}

struct RecipeIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeIngredientView(recipe: defaultRecipe)
    }
}
