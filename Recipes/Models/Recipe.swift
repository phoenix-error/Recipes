//
//  Recipe.swift
//  Recipes
//
//  Created by Luca Becker on 11.05.22.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Recipe: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var type: RecipeType
    var difficulty: RecipeDifficulty
    var image: String? // String to URL in Firebase store
    var prepTime: Int
    var cookTime: Int
    var ingredients: [RecipeIngredient]
    var steps: [String]
    var author: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case type
        case difficulty
        case image
        case prepTime
        case cookTime
        case ingredients
        case steps
        case author
    }
}

// SwiftUI View extensions for Recipe
extension Recipe {
    var prepTimeLabel: some View {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .short
        
        let formattedString = formatter.string(from: TimeInterval(prepTime))!
        
        return Label(formattedString, systemImage: "clock")
    }
}
