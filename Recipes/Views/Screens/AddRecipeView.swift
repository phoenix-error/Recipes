//
//  AddRecipeView.swift
//  Recipes
//
//  Created by Luca Becker on 12.05.22.
//

import SwiftUI
import Combine

struct AddRecipeView: View {
    enum FocusField: Hashable {
        case ingredients, amount, steps
    }
    
    var recipeUnits: [Dimension] {
        let masses: [UnitMass] = [.milligrams, .grams, .kilograms, .ounces, .pounds]
        let volumes: [UnitVolume] = [.cups, .fluidOunces, .gallons, .teaspoons, .tablespoons, .milliliters, .liters]
        
        return masses + volumes
    }
    
    @FocusState private var focusedField: FocusField?
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var firebaseManager: FirebaseManager
    @StateObject private var recipeManager = RecipeManager()
    
    @State var prepTime = "0"
    @State var cookTime = "0"
    
    @State private var currentIngredient = ""
    @State private var currentAmount = ""
    @State private var currentUnit: Dimension?
    @State private var currentInstruction = ""
    
    var recipeAddable: Bool {
        return !recipeManager.name.isEmpty && !recipeManager.author.isEmpty &&
        //        TODO: Reintroduce when ingredients and steps can be added
        //        !recipeManager.ingredients.isEmpty && !recipeManager.steps.isEmpty &&
        !(recipeManager.type == .unknown) && !(recipeManager.difficulty == .unknown)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 50) {
                Text("Add Recipe")
                    .font(.largeTitle)
                    .bold()
                
                // MARK: Basic Information
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.title2)
                        .bold()
                    TextField("Name", text: $recipeManager.name)
                }
                
                // MARK: Type and Difficulty Picker
                VStack {
                    RecipeTypeView().environmentObject(recipeManager)
                    RecipeDifficultyView().environmentObject(recipeManager)
                }
                
                // MARK: Ingredients
                VStack(alignment: .leading, spacing: 10) {
                    RecipeIngredientView().environmentObject(recipeManager)
                    HStack {
                        TextField("Ingredient", text: $currentIngredient)
                            .focused($focusedField, equals: .ingredients)
                            .onSubmit {
                                self.focusedField = .amount
                            }
                            
                        TextField("Amount", text: $currentAmount)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .amount)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Button("Cancel") {
                                        self.focusedField = nil
                                    }
                                    
                                    Spacer()
                                    
                                    Button("Done") {
                                        if !currentIngredient.isEmpty && !currentAmount.isEmpty {
                                            guard let amount = Float(currentAmount) else { return }
                                            let unit = currentUnit?.symbol ?? ""
                                            
                                            recipeManager.ingredients.append(
                                                    RecipeIngredient(name: currentIngredient, amount: amount, unit: unit))
                                            
                                            currentAmount = ""
                                            currentIngredient = ""
                                            self.focusedField = .ingredients
                                        }
                                    }
                                }
                            }
                            .frame(width: 75)
                        
                        Picker("Unit", selection: $currentUnit) {
                            ForEach(recipeUnits, id: \.self) { recipeUnit in
                                Text(recipeUnit.symbol).tag(recipeUnit as Dimension?)
                            }
                            Text("other").tag(nil as Dimension?)
                        }
                    }
                }.lineLimit(1)
                
                //                RecipeInstructionView().environmentObject(recipeManager)
                //                TextField("Instruction", text: $currentInstruction).onSubmit {
                //                    if !currentInstruction.isEmpty {
                //                        recipeManager.steps.append(currentInstruction)
                //                        currentInstruction = ""
                //                    }
                //                }
                
                // MARK: Times
                HStack {
                    Text("prepTime")
                        .font(.headline)
                    
                    TextField("prepTime", text: $prepTime)
                        .keyboardType(.numberPad)
                        .onChange(of: prepTime) { value in
                            let filtered = value.filter { "0123456789".contains($0) }
                            if value != filtered {
                                self.prepTime = filtered
                                self.recipeManager.prepTime = Int(filtered) ?? 0
                            } else {
                                self.recipeManager.prepTime = Int(filtered) ?? 0
                            }
                        }
                        .textFieldStyle(.roundedBorder)
                    
                    Text("cookTime")
                        .font(.headline)
                    
                    TextField("cookTime", text: $cookTime)
                        .keyboardType(.numberPad)
                        .onChange(of: cookTime) { value in
                            let filtered = value.filter { "0123456789".contains($0) }
                            if value != filtered {
                                self.cookTime = filtered
                                self.recipeManager.cookTime = Int(filtered) ?? 0
                            } else {
                                self.recipeManager.cookTime = Int(filtered) ?? 0
                            }
                        }
                        .textFieldStyle(.roundedBorder)
                }
                
                // MARK: Author
                VStack(alignment: .leading) {
                    Text("Author")
                        .font(.title2)
                        .bold()
                    
                    TextField("Author", text: $recipeManager.author)
                }
                
                Button {
                    firebaseManager.createRecipe(recipeManager.formRecipe())
                    dismiss()
                } label: {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                }.buttonStyle(.borderedProminent)
                    .disabled(!recipeAddable)
                
            }
            .padding()
        }
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}

// MARK: Recipe Type View
struct RecipeTypeView: View {
    @EnvironmentObject var recipeManager: RecipeManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recipe Type")
                .font(.title2)
                .bold()
            Picker("Type", selection: $recipeManager.type) {
                ForEach(RecipeType.allCases.filter { $0 != .unknown }) { recipeType in
                    Text(recipeType.asString).tag(recipeType)
                }
            }.pickerStyle(.segmented)
            
        }
    }
}

// MARK: Recipe Difficulty View
struct RecipeDifficultyView: View {
    @EnvironmentObject var recipeManager: RecipeManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recipe Difficulty")
                .font(.title2)
                .bold()
            Picker("Difficulty", selection: $recipeManager.difficulty) {
                ForEach(RecipeDifficulty.allCases.filter { $0 != .unknown}) { recipeDifficulty in
                    Text(recipeDifficulty.asString).tag(recipeDifficulty)
                }
            }.pickerStyle(.segmented)
        }
    }
}
