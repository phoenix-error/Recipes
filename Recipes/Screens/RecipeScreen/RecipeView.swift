//
//  RecipeView.swift
//  Recipes
//
//  Created by Luca Becker on 12.05.22.
//

import SwiftUI

struct RecipeView: View {
    @ObservedObject private var viewModel: RecipeViewModel
    
    init(recipe: Recipe) {
        self.viewModel = RecipeViewModel(recipe: recipe)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            RecipeRowView(title: "Title", value: viewModel.recipe.title)
            RecipeRowView(title: "Type", value: viewModel.recipe.type.string)
            RecipeRowView(title: "Difficulty", value: viewModel.recipe.difficulty.string)
            RecipeRowView(title: "Author", value: viewModel.recipe.author)
            HStack {
                Text("Prep time:")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(.secondary)
                Text("\(viewModel.recipe.prepTime)")
                Spacer()
                
                Text("Cook time")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(.secondary)
                Text("\(viewModel.recipe.cookTime)")
                Spacer()
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Ingredients")
                        .font(.system(size: 12, design: .monospaced))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(viewModel.recipe.ingredients.count)items")
                        .font(.system(size: 8, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                List {
                    ForEach(viewModel.recipe.ingredients, id: \.self) { ingredient in
                        Text(ingredient.name)
                    }
                }.listStyle(.plain)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Steps")
                        .font(.system(size: 12, design: .monospaced))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(viewModel.recipe.steps.count)items")
                        .font(.system(size: 8, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                
                List {
                    ForEach(viewModel.recipe.steps, id: \.self) { step in
                        Text(step)
                    }
                }.listStyle(.plain)
            }
        }
        .padding()
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
            .padding()
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
    
}

struct RecipeRowView: View {
    var title: String
    var value: String
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(.secondary)
                Text(value)
            }
            Spacer()
        }
    }
}
