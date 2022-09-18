//
//  View+Navigation.swift
//  Recipes
//
//  Created by Luca Becker on 18.09.22.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigation() -> some View {
        NavigationView {
            self
        }
    }
}
