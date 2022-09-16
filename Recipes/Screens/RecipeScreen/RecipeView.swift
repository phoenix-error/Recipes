//
//  RecipeView.swift
//  Recipes
//
//  Created by Luca Becker on 12.05.22.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack {
                // MARK: Image and Information
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image("prev_picture")
                        .resizable()
                        .scaledToFit()
                }
                .overlay {
                    RecipeInformationCardView(recipe: recipe)
                        .offset(y: 200)
                        .padding()
                }
                .padding(.bottom, 80)
                    
                // MARK: HOW-TO
                RecipeInstructionView(recipe: recipe)
                
                // MARK: Ingredients
                RecipeIngredientView(recipe: recipe)
        
            }
        }.edgesIgnoringSafeArea(.top)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: defaultRecipe)   
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
    
}
