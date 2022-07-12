//
//  RecipeInstructionView.swift
//  Recipes
//
//  Created by Luca Becker on 05.07.22.
//

import SwiftUI

struct RecipeInstructionView: View {
    let recipe: Recipe
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions").font(.title2).bold()
            
            VStack(alignment: .leading, spacing: 20) {
                ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, instructionStep in
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
        }.padding()
    }
}

struct RecipeInstructionView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInstructionView(recipe: defaultRecipe)
    }
}
