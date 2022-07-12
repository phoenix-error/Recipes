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
        case "Breakfast": self = .breakfast
        case "Lunch": self = .lunch
        case "Dinner": self = .dinner
        case "Dessert": self = .dessert
        case "Snack": self = .snack
        default:
            self = .unknown
        }
    }
    
    var asString: String {
        switch self {
        case .breakfast:
            return "Breakfast"
        case .lunch:
            return "Lunch"
        case .dinner:
            return "Dinner"
        case .dessert:
            return "Dessert"
        case .snack:
            return "Snack"
        default:
            return "Unknown"
        }
    }
    
    var asText: Text {
        return Text(self.asString).foregroundColor(.white)
    }
}
