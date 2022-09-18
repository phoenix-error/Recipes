//
//  HomeView.swift
//  Recipes
//
//  Created by Luca Becker on 08.05.22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        List(viewModel.recipes) { recipe in
            ZStack {
                RecipeCellView(recipe: recipe)
                NavigationLink("", destination: RecipeView(recipe: recipe))
                    .opacity(0)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Recipes")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    viewModel.showingAddView.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                
                Button(action: viewModel.logout) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
            }
        }
        .sheet(isPresented: $viewModel.showingAddView) {
            NavigationView {
                AddRecipeView()                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
