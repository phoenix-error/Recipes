//
//  MockData.swift
//  Recipes
//
//  Created by Luca Becker on 08.06.22.
//

import Foundation

let defaultRecipe = Recipe(id: "627ba893be1f1f1f9f9a3865", title: "Patrick Pasta", name: "Patrick Coffey", type: RecipeType.snack, difficulty: RecipeDifficulty.hard,
                           image: "https://picsum.photos/id/63/400/400", prepTime: 2343, cookTime: 543, ingredients: [
                            RecipeIngredient(name: "culpa", amount: Float(Int.random(in: 1...10)), unit: "kg"),
                            RecipeIngredient(name: "ullamco", amount: Float(Int.random(in: 1...10)), unit: "kg"),
                            RecipeIngredient(name: "velit", amount: Float(Int.random(in: 1...10)), unit: "kg"),
                            RecipeIngredient(name: "aliqua", amount: Float(Int.random(in: 1...10)), unit: "kg"),
                            RecipeIngredient(name: "officia", amount: Float(Int.random(in: 1...10)), unit: "kg"),
                            RecipeIngredient(name: "laboris", amount: Float(Int.random(in: 1...10)), unit: "kg")
                           ], steps: [
                            "Deserunt est ut do nostrud esse et.",
                            "Eiusmod irure commodo id adipisicing velit excepteur nulla occaecat fugiat occaecat.",
                            "Anim fugiat magna reprehenderit sit qui.",
                            "Fugiat magna velit sunt adipisicing anim excepteur enim veniam mollit nulla.",
                            "Tempor ad amet id aute veniam dolor culpa.",
                            "Ullamco minim quis ullamco voluptate do labore enim veniam id culpa qui proident fugiat.",
                            "Est mollit nisi est minim cupidatat anim mollit Lorem aliquip quis.",
                            "In ad aliquip amet eu aliquip incididunt enim pariatur qui cillum deserunt.",
                            "Deserunt enim ullamco ea irure eu tempor reprehenderit.",
                            "Proident adipisicing irure ad commodo enim adipisicing elit aliquip mollit eiusmod adipisicing excepteur cillum.",
                            "Laboris culpa eiusmod aliquip ea.",
                            "Minim esse ea anim occaecat non proident aute voluptate qui dolore ea minim occaecat.",
                            "Sit ad enim reprehenderit dolore qui exercitation sint mollit id excepteur consequat reprehenderit aliqua."
                           ], author: "Luca Becker")
