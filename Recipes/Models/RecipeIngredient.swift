//
//  RecipeIngredient.swift
//  Recipes
//
//  Created by Luca Becker on 06.07.22.
//

import SwiftUI

struct RecipeIngredient: Codable, Hashable {
    var selected: Bool = false
    let name: String
    let amount: Float
    let unit: String?
    
    enum CodingKeys: String, CodingKey {
        case selected
        case name
        case amount
        case unit
    }
    
    static func == (lhs: RecipeIngredient, rhs: RecipeIngredient) -> Bool {
        return lhs.name == rhs.name && lhs.amount == rhs.amount && lhs.unit == rhs.unit
    }
}

extension Bool {
    mutating func toggle() {
        self = !self
    }
}
