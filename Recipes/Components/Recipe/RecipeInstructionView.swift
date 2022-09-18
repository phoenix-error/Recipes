//
//  RecipeInstructionView.swift
//  Recipes
//
//  Created by Luca Becker on 05.07.22.
//

import SwiftUI

struct RecipeInstructionView: View {
    //@EnvironmentObject var recipeManager: RecipeManager
    var recipe: Recipe?
    
    var instructions: [String] {
        guard let recipe = recipe else {
            return []
//            return recipeManager.steps
            }
        return recipe.steps
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions").font(.title2).bold()
            
            VStack(alignment: .leading, spacing: 20) {
                ForEach(Array(instructions.enumerated()), id: \.offset) { index, instructionStep in
                    HStack(alignment: .firstTextBaseline) {
                        Text("\(index)")
                            .font(.title3)
                            .bold()
                            .frame(width: 30)
                        Text(instructionStep)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
    }
}

struct RecipeInstructionView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInstructionView(recipe: defaultRecipe)
    }
}
