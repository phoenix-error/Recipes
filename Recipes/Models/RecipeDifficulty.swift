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
        case "easy": self = .easy
        case "medium": self = .medium
        case "hard": self = .hard
        default: self = .unknown
        }
    }
    
    var string: String {
        return self.rawValue.capitalized
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
    
    static var allValidCases: [RecipeDifficulty] {
        return RecipeDifficulty.allCases.filter { $0 != .unknown }
    }
}
