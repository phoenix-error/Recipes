//
//  HomeView.swift
//  Recipes
//
//  Created by Luca Becker on 08.05.22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var firebaseManager: FirebaseManager
    @State private var addingViewBool = false
    
    var body: some View {
        List(firebaseManager.recipes) { recipe in
            ZStack {
                RecipeCellView(recipe: recipe)
                NavigationLink("", destination: RecipeView(recipe: recipe))
                    .opacity(0)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Recipes")
        .onAppear(perform: firebaseManager.fetch)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    addingViewBool.toggle()
                    
                } label: {
                    Image(systemName: "plus")
                }
                
                Button {
                    firebaseManager.logout()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
            }
        }
        .sheet(isPresented: $addingViewBool) {
            AddRecipeView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
