//
//  RecipeType.swift
//  Recipes
//
//  Created by Luca Becker on 11.05.22.
//

import SwiftUI

enum RecipeType: String, Codable, CaseIterable, Identifiable {
    case breakfast, lunch, dinner, dessert, snack
    case unknown
    
    var id: Self { self }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
        case "breakfast": self = .breakfast
        case "lunch": self = .lunch
        case "dinner": self = .dinner
        case "dessert": self = .dessert
        case "snack": self = .snack
        default:
            self = .unknown
        }
    }
    
    var string: String {
        return self.rawValue.capitalized
    }
    
    var asText: Text {
        return Text(self.string).foregroundColor(.white)
    }
    
    static var allValidCases: [RecipeType] {
        return RecipeType.allCases.filter { $0 != .unknown }
    }
}
