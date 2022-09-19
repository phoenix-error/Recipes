//
//  RecipeCellView.swift
//  Recipes
//
//  Created by Luca Becker on 11.05.22.
//

import SwiftUI

struct RecipeCellView: View {
    let recipe: Recipe
    var body: some View {
        VStack {
            if !recipe.image.isEmpty {
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(alignment: .bottomTrailing) {
                            RecipeCellImageOverlayView(recipe: recipe)
                        }
                } placeholder: {
                    Color.clear
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(recipe.title)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    
                        Text(recipe.author.uppercased())
                            .font(.caption)
                            .foregroundColor(.secondary)
                    HStack {
                        Text("Difficulty: ")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        DifficultyView(difficulty: recipe.difficulty)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}

struct RecipeCellView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCellView(recipe: defaultRecipe)
    }
}

struct RecipeCellImageOverlayView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            recipe.type.asText.font(.headline)
            Text("|")
            recipe.prepTimeLabel
            
        }
        .foregroundColor(.white)
        .padding(5)
        .background(Color.black.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
    }
}

struct DifficultyView: View {
    var difficulty: RecipeDifficulty
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(difficulty.color(index: index))
            }
        }
        .frame(width: 40)
    }
}
