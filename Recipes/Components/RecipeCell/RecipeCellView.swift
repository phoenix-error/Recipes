//
//  RecipeCellView.swift
//  Recipes
//
//  Created by Luca Becker on 11.05.22.
//

import SwiftUI

struct RecipeCellView: View {
    @ObservedObject private var viewModel: RecipeCellViewModel
    
    init(recipe: Recipe) {
        self.viewModel = RecipeCellViewModel(recipe: recipe)
    }
    
    var body: some View {
        VStack {
            if viewModel.shownImage != UIImage() {
                Image(uiImage: viewModel.shownImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .overlay(alignment: .bottomTrailing) {
                        RecipeCellImageOverlayView(recipe: viewModel.recipe)
                    }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.recipe.title)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    
                    Text(viewModel.recipe.author.uppercased())
                            .font(.caption)
                            .foregroundColor(.secondary)
                    HStack {
                        Text("Difficulty: ")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        DifficultyView(difficulty: viewModel.recipe.difficulty)
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(.white)
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
        .onAppear {
            viewModel.fetchImage()
        }
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