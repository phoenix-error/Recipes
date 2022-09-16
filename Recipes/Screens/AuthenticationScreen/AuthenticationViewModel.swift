//
//  AuthenticationViewModel.swift
//  Recipes
//
//  Created by Luca Becker on 16.09.22.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    private enum Screen {
        case signIn, signUp
    }
    
    @Published private var screen: Screen = .signIn
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    
    let manager = FirebaseManager.shared
    
    var actionButtonText: String {
        return self.screen == .signIn ? "Log in": "Sign Up"
    }
    
    var bottomText: String {
        return self.screen == .signIn ? "Don't have an account?": "Already have an account?"
    }
    
    var bottomButtonText: String {
        return self.screen == .signIn ? "Sign Up": "Log in"
    }
    
    var actionButtonEnabled: Bool {
        var enabled = true
        
        if screen == .signUp {
            enabled = enabled && !repeatPassword.isEmpty && password == repeatPassword
        }
        
        return !email.isEmpty && !password.isEmpty && enabled
            
    }
    
    var isSignUp: Bool {
        return screen == .signUp
    }
    
    var matchingPasswords: Bool {
        return password == repeatPassword
    }
    
    func switchScreens() {
        if screen == .signIn {
            screen = .signUp
        } else {
            screen = .signIn
        }
        
        password = ""
        repeatPassword = ""
    }
    
}

extension AuthenticationViewModel {
    func login() {
        manager.login(email: email, password: password)
    }
    
    func signUp() {
        manager.signUp(email: email, password: password)
    }
}
