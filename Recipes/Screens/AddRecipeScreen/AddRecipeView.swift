//
//  AddRecipeView.swift
//  Recipes
//
//  Created by Luca Becker on 12.05.22.
//

import SwiftUI

struct AddRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddRecipeViewModel()
    
    var body: some View {
        Form(content: {
            TextField("Title", text: $viewModel.title)
            
            Section {
                ForEach(viewModel.ingredients, id: \.self) { ingredient in
                    Text(ingredient.name)
                }
                
                TextField("Ingredient", text: $viewModel.newIngredient)
                    .submitLabel(.next)
                    .onSubmit {
                        viewModel.addIngredient()
                    }
            }
            
            Section {
                ForEach(viewModel.steps, id: \.self) { step in
                    Text(step)
                }
                
                TextField("Step", text: $viewModel.newStep)
                    .submitLabel(.next)
                    .onSubmit {
                        viewModel.addStep()
                    }
            }
            
            Section {
                LazyVGrid(columns: [GridItem(.flexible(), alignment: .leading), GridItem(.flexible(), alignment: .trailing)]) {
                    HStack(spacing: 10) {
                        Text("Prep:")
                        TextField("Time", value: $viewModel.prepTime, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .timeTextField()
                        
                    }
                    HStack {
                        Text("Cook")
                        TextField("Time", value: $viewModel.cookTime, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .timeTextField()
                    }
                }
            }
            
            Section {
                Picker("Difficulty", selection: $viewModel.pickerDifficulty) {
                    ForEach(RecipeDifficulty.allValidCases) { difficulty in
                        Text(difficulty.string)
                            .tag(difficulty.string)
                    }
                }
                
                Picker("Recipe type", selection: $viewModel.pickerType) {
                    ForEach(RecipeType.allValidCases) { type in
                        Text(type.string)
                            .tag(type.string)
                    }
                }
            }
            Section {
                Button(viewModel.imagePickerTitle) {
                    viewModel.showingImagePicker.toggle()
                }
                
            }
            
            Section {
                TextField("Author", text: $viewModel.author)
            }
            
            Button("Add Recipe") {
                viewModel.addRecipe()
                dismiss()
            }.disabled(!viewModel.actionButtonEnabled)
        })
        .navigationTitle(viewModel.navTitle)
        .fullScreenCover(isPresented: $viewModel.showingImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $viewModel.image)
        }
    }
}
//        ScrollView {
//            VStack(alignment: .leading, spacing: 50) {
//                Text("Add Recipe")
//                    .font(.largeTitle)
//                    .bold()
//
//                // MARK: Basic Information
//                VStack(alignment: .leading) {
//                    Text("Name")
//                        .font(.title2)
//                        .bold()
//                    TextField("Name", text: $recipeManager.name)
//                        .textFieldStyle(.roundedBorder)
//                }
//
//                // MARK: Type and Difficulty Picker
//                RecipeTypeView().environmentObject(recipeManager)
//                RecipeDifficultyView().environmentObject(recipeManager)
//
//                // MARK: Ingredients
//                RecipeIngredientView().environmentObject(recipeManager)
//                TextField("Ingredient", text: $currentIngredient).onSubmit {
//                    if !currentIngredient.isEmpty {
//                        recipeManager.ingredients.append(RecipeIngredient(name: currentIngredient, amount: 1, unit: "kg"))
//                        currentIngredient = ""
//                    }
//                }
//
//                //                RecipeInstructionView().environmentObject(recipeManager)
//                //                TextField("Instruction", text: $currentInstruction).onSubmit {
//                //                    if !currentInstruction.isEmpty {
//                //                        recipeManager.steps.append(currentInstruction)
//                //                        currentInstruction = ""
//                //                    }
//                //                }
//
//                // MARK: Times
//                HStack {
//                    Text("prepTime")
//                        .font(.title3)
//                        .bold()
//
//                    TextField("prepTime", text: $prepTime)
//                        .keyboardType(.numberPad)
//                        .onChange(of: prepTime) { value in
//                            let filtered = value.filter { "0123456789".contains($0) }
//                            if value != filtered {
//                                self.prepTime = filtered
//                                self.recipeManager.prepTime = Int(filtered) ?? 0
//                            } else {
//                                self.recipeManager.prepTime = Int(filtered) ?? 0
//                            }
//                        }
//                        .textFieldStyle(.roundedBorder)
//
//                    Text("cookTime")
//                        .font(.title3)
//                        .bold()
//
//                    TextField("cookTime", text: $cookTime)
//                        .keyboardType(.numberPad)
//                        .onChange(of: cookTime) { value in
//                            let filtered = value.filter { "0123456789".contains($0) }
//                            if value != filtered {
//                                self.cookTime = filtered
//                                self.recipeManager.cookTime = Int(filtered) ?? 0
//                            } else {
//                                self.recipeManager.cookTime = Int(filtered) ?? 0
//                            }
//                        }
//                        .textFieldStyle(.roundedBorder)
//                }
//
//                // MARK: Author
//                VStack(alignment: .leading) {
//                    Text("Author")
//                        .font(.title2)
//                        .bold()
//
//                    TextField("Author", text: $viewModel.author)
//                        .textFieldStyle(.roundedBorder)
//
//                }
//
//                Button {
//                    //                    firebaseManager.createRecipe(recipeManager.formRecipe())
//                    dismiss()
//                } label: {
//                    Text("Add")
//                        .frame(maxWidth: .infinity)
//                }
//                .disabled(!viewModel.actionButtonEnabled)
//
//            }.padding()
//        }

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
            .embedInNavigation()
    }
}

private struct TimeTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .trailing) {
                Text("min")
                    .foregroundColor(.secondary)
                    .padding(.trailing, 5)
            }
            .frame(maxWidth: 85)
    }
}

private extension View {
    func timeTextField() -> some View {
        modifier(TimeTextFieldModifier())
    }
}
