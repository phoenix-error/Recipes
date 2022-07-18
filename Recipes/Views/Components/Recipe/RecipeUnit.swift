//
//  RecipeUnit.swift
//  Recipes
//
//  Created by Luca Becker on 18.07.22.
//

import Foundation

enum RecipeUnit: String, CaseIterable {
    // swiftlint:disable identifier_name
    case kg, l, ml, g, mg, tsp, tbsp, cup, oz, lb, other
    
    var masses: [UnitMass] {
        return [.milligrams, .grams, .kilograms, .ounces, .pounds]
    }
    
    var volumes: [UnitVolume] {
        return [.cups, .fluidOunces, .gallons, .teaspoons, .tablespoons, .milliliters, .liters]
    }
    
    func string() -> String {
        switch self {
        case .mg:
            return "milligrams"
        case .g:
            return "grams"
        case .kg:
            return "kilograms"
        case .ml:
            return "milliliter"
        case .l:
            return "liter"
        case .tsp:
            return "teaspoon"
        case .tbsp:
            return "tablespoon"
        case .cup:
            return "cup"
        case .oz:
            return "ounce"
        case .lb:
            return "pound"
        default:
            return "other"
        }
    }
    
//    func asUnit() -> Unit? {
//        switch self {
//        case .mg:
//            return Unit.
//        case .g:
//            return "grams"
//        case .kg:
//            return "kilograms"
//        case .ml:
//            return "milliliter"
//        case .l:
//            return "liter"
//        case .tsp:
//            return "teaspoon"
//        case .tbsp:
//            return "tablespoon"
//        case .cup:
//            return "cup"
//        case .oz:
//            return "ounce"
//        case .lb:
//            return "pound"
//        default:
//            return nil
//        }
//    }
}
