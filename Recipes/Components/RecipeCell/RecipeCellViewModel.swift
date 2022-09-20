//
//  RecipeCellViewModel.swift
//  Recipes
//
//  Created by Luca Becker on 19.09.22.
//

import Foundation
import SwiftUI

class RecipeCellViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var shownImage = UIImage() {
        didSet {
            fetchImage()
        }
    }
    
    let firebaseManager = FirebaseManager.shared
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func fetchImage() {
        guard shownImage == UIImage(),
            let image = recipe.image
        else { return }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.firebaseManager.downloadImage(url: image) { shownImage in
                if shownImage != nil {
                    self.shownImage = shownImage!
                }
            }
        }
    }
    
}
