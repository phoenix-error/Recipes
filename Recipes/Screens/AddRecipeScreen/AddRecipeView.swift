//
//  AddRecipeView.swift
//  Recipes
//
//  Created by Luca Becker on 12.05.22.
//

import SwiftUI

struct AddRecipeView: View {
    
    enum FocusedField {
        case ingredients, steps
    }
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddRecipeViewModel()
    @FocusState private var focused: FocusedField?
    
    var body: some View {
        Form(content: {
            TextField("Title", text: $viewModel.title)
            
            Section {
                ForEach(viewModel.ingredients, id: \.self) { ingredient in
                    Text(ingredient.name)
                }
                
                TextField("Ingredient", text: $viewModel.newIngredient)
                    .focused($focused, equals: .ingredients)
                    .submitLabel(.next)
                    .onSubmit {
                        viewModel.addIngredient()
                        focused = .ingredients
                    }
                
            }
            
            Section {
                ForEach(viewModel.steps, id: \.self) { step in
                    Text(step)
                }
                
                TextField("Step", text: $viewModel.newStep)
                    .focused($focused, equals: .steps)
                    .submitLabel(.next)
                    .onSubmit {
                        viewModel.addStep()
                        focused = .steps
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
                    
                    if viewModel.pickerDifficulty == RecipeDifficulty.unknown.string {
                        Text("Unknown")
                            .tag(RecipeDifficulty.unknown.string)
                    }
                }
                
                Picker("Recipe type", selection: $viewModel.pickerType) {
                    ForEach(RecipeType.allValidCases) { type in
                        Text(type.string)
                            .tag(type.string)
                    }
                    if viewModel.pickerType == RecipeType.unknown.string {
                        Text("Unknown")
                            .tag(RecipeType.unknown.string)
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
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focused = nil
                }
            }
        }
    }
}

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
