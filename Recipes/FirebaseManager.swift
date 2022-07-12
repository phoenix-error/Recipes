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
    
    var router: ViewRouter?
    
    // Variables for Authentication
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var processing = false
    @Published var errorMessage = ""
    
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
    var loginEnabled: Bool {
        return !processing && !email.isEmpty && !password.isEmpty ? false : true
    }
    
    var createEnabled: Bool {
        !processing && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty && password == passwordConfirmation ? false : true
    }
    
    var hasRouter: Bool {
        return router != nil
    }
    
    func login() {
        guard hasRouter else { return }
        
        processing = true
        
        auth.signIn(withEmail: email, password: password) { [self] authResult, error in
            
            guard error == nil else {
                processing = false
                errorMessage = error!.localizedDescription
                return
            }
            
            switch authResult {
            case .none:
                print("Could not sign in user.")
                processing = false
            case .some:
                print("User signed in")
                processing = false
                
                setPage(page: .home)
            }
            
        }
    }
    
    func create() {
        guard hasRouter else { return }
        
        processing = true
        
        auth.createUser(withEmail: email, password: password) { [self] authResult, error in
            guard error == nil else {
                errorMessage = error!.localizedDescription
                processing = false
                return
            }
            
            switch authResult {
            case .none:
                print("Could not create account.")
                processing = false
            case .some:
                print("User created")
                processing = false
                
                setPage(page: .home)
            }
        }
    }
    
    func logout() {
        guard hasRouter else { return }
        
        do {
            try auth.signOut()
            setPage(page: .signIn)
        } catch {
            print("Already logged out")
        }
    }
    
    func clearFields() {
        email = ""
        password = ""
        passwordConfirmation = ""
    }
    
    func setRouter(_ router: ViewRouter) {
        self.router = router
    }
    
    func setView() {
        if auth.currentUser != nil {
            setPage(page: .home)
        } else {
            setPage(page: .signIn)
        }
    }
    
    func setPage(page: AppPage) {
        DispatchQueue.main.async {
            withAnimation(.easeInOut) {
                self.router?.currentPage = page
            }
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
