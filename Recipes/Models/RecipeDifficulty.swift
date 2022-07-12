//
//  RecipeDifficulty.swift
//  Recipes
//
//  Created by Luca Becker on 11.05.22.
//

import SwiftUI

enum RecipeDifficulty: String, Codable, CaseIterable, Identifiable {
    case easy, medium, hard
    case unknown
    
    var id: Self { self }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
        case "Easy": self = .easy
        case "Medium": self = .medium
        case "Hard": self = .hard
        default:
            self = .unknown
        }
    }
    
    var asString: String {
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        default:
                return "Unknown"
        }
    }
    
    var color: Color {
        switch self {
        case .easy:
            return .green
        case .medium:
            return .orange
        case .hard:
            return .red
        default:
            return .black
        }
    }
}
