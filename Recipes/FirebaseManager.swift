//
//  FirebaseManager.swift
//  Recipes
//
//  Created by Luca Becker on 11.05.22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

final class FirebaseManager: ObservableObject {
    private let database = Firestore.firestore()
    private let auth = Auth.auth()
    private let storage = Storage.storage()
    
    static let shared = FirebaseManager()
    
    // Variables for database
    var recipeReference: CollectionReference {
        guard let uid = auth.currentUser?.uid else {
            return database.collection("recipes")
        }
        return database.collection(uid)
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
            _ = try recipeReference.addDocument(from: recipe)
        } catch let error {
            print("[!] Error writing recipe to Firestore \(error.localizedDescription)")
        }
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        guard let id = recipe.id else { return }
        
        recipeReference.document(id).delete() { error in
            if let error = error {
                print("[!] Error removing recipe: \(error)")
            }
        }
    }
}

extension FirebaseManager {
    func uploadImage(image: UIImage, completion: @escaping (String?) -> Void) {
        guard let user = auth.currentUser,
              let data = image.jpegData(compressionQuality: 0.5)
        else { completion(nil); return }
        
        let imageID = UUID().uuidString
        let imagePath = "\(user.uid)/\(imageID).jpg"
        let ref = storage.reference(withPath: imagePath)
        ref.putData(data) { _, error in
            if let error = error {
                print("[!] Error FirebaseStorage: \(error.localizedDescription)")
                completion(nil)
                return
            } else {
                completion(imagePath)
            }
        }
        
    }
    
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        let ref = storage.reference(withPath: url)

        ref.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let error = error {
                print("[!] Error FirebaseStorage: \(error.localizedDescription)")
                completion(nil)
                return
            } else {
                completion(UIImage(data: data!))
            }
        }
    }
    
    func deleteImage(url: String) {
        let ref = storage.reference(withPath: url)
        
        ref.delete { error in
            if let error = error {
                print("[!] Error FirebaseStorage: \(error.localizedDescription)")
            }
        }
    }
}
