//
//  AppManager.swift
//  Recipes
//
//  Created by Luca Becker on 16.09.22.
//

import Foundation
import Combine

struct AppManager {
    static let Authenticated = PassthroughSubject<Bool, Never>()
    
    static func isAuthenticated() -> Bool {
        return UserDefaults.standard.string(forKey: Config.authTokenKey) != nil
    }
}
