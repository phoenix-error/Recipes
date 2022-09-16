//
//  FirebaseManager.swift
//  Recipes
//
//  Created by Luca Becker on 11.05.22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

final class FirebaseManager: ObservableObject {
    let database = Firestore.firestore()
    let auth = Auth.auth()
    
    static let shared = FirebaseManager()
    
    // Variables for Firestore
    @Published var recipes: [Recipe] = []
    
    // Variables for database
    private var recipeDB: CollectionReference {
        return database.collection("recipes")
    }
    
    init() {
        fetch()
    }
    
    // MARK: Fetch from Firestore
    func fetch() {
        recipeDB.addSnapshotListener { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.recipes = documents.compactMap { queryDocumentSnapshot -> Recipe? in
                return try? queryDocumentSnapshot.data(as: Recipe.self)
            }
        }
    }
    
}

// MARK: FirebaseAuth functions
extension FirebaseManager {
    func login(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            switch authResult {
            case .none:
                print("Could not sign in user.")
            case .some:
                print("User signed in")
                UserDefaults.standard.set(UUID().uuidString, forKey: Config.authTokenKey)
                AppManager.Authenticated.send(true)
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            switch authResult {
            case .none:
                print("Could not create account.")
            case .some:
                print("User created")
                UserDefaults.standard.set(UUID().uuidString, forKey: Config.authTokenKey)
                AppManager.Authenticated.send(true)
            }
        }
    }
    
    func logout() {
        do {
            try auth.signOut()
        } catch {
            print("Already logged out")
        }
    }
}

// MARK: CRUD for Firestore
extension FirebaseManager {
    func createRecipe(_ recipe: Recipe) {
        do {
            _ = try recipeDB.addDocument(from: recipe)
        } catch let error {
            print("Error writing Recipe to Firestore \(error.localizedDescription)")
        }
    }
}
