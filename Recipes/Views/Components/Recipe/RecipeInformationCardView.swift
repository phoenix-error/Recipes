//
//  RecipeInformationCardView.swift
//  Recipes
//
//  Created by Luca Becker on 05.07.22.
//

import SwiftUI

struct RecipeInformationCardView: View {
    let recipe: Recipe
    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .font(.title)
                .bold()
            Text(recipe.author)
            Divider()
            HStack {
                Label("\(recipe.cookTime)min", systemImage: "stopwatch")
                Spacer()
                Text(recipe.difficulty.asString)
                    .fontWeight(.medium)
                    .foregroundColor(recipe.difficulty.color)
                Spacer()
                Text(recipe.type.asString)
                    .fontWeight(.medium)
            }.font(.title3)
            
        }
        .padding()
        .background(Color("card_color"))
        .modifier(CardModifier())
    }
}

struct RecipeInformationCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInformationCardView(recipe: defaultRecipe)
            .previewLayout(.sizeThatFits)
    }
}
