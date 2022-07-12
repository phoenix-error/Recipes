//
//  AuthenticationScreen.swift
//  RecipesUITests
//
//  Created by Luca Becker on 30.06.22.
//

import Foundation
import XCTest

class AuthenticationScreen {
    
    let app: XCUIApplication
    let emailTextField: XCUIElement
    let passwordSecureTextField: XCUIElement
    let passwordConfirmSecureTextField: XCUIElement
    let loginButton: XCUIElement
    let signUpButton: XCUIElement

    init(app: XCUIApplication) {
        self.app = app
        emailTextField = app.textFields["Email"]
        passwordSecureTextField = app.secureTextFields["Password"]
        passwordConfirmSecureTextField = app.secureTextFields["Confirm Password"]
        loginButton = app.buttons["Log In"]
        signUpButton = app.buttons["Sign Up"]
    }
    
    func isLoginPage() throws {
        XCTAssert(app.images["Logo"].isHittable)
        
        XCTAssert(app.staticTexts["Don't have an account?"].isHittable)
        
        XCTAssert(emailTextField.isHittable)
        XCTAssert(passwordSecureTextField.isHittable)
        XCTAssert(loginButton.isHittable)
        XCTAssert(signUpButton.isHittable)
    }
    
    func isSignUpPage() throws {
        XCTAssert(app.images["Logo"].isHittable)
        
        XCTAssert(app.staticTexts["Already have an account?"].isHittable)
        
        XCTAssert(emailTextField.isHittable)
        XCTAssert(passwordSecureTextField.isHittable)
        XCTAssert(passwordConfirmSecureTextField.isHittable)
        XCTAssert(signUpButton.isHittable)
        XCTAssert(loginButton.isHittable)
    }
    
    func login(email: String, password: String) throws {
        do {
            try isSignUpPage()
            loginButton.tap()
        } catch {}
        
        XCTAssert(emailTextField.isHittable)
        XCTAssert(passwordSecureTextField.isHittable)
        XCTAssert(loginButton.isHittable)
        
        emailTextField.tap()
        emailTextField.typeAndContinue(email)
        passwordSecureTextField.typeAndContinue(password)
        
        XCTAssert(loginButton.isEnabled)
        loginButton.tap()
    }
    
    func register(name: String, email: String, password: String) throws {
        
        do {
            try isLoginPage()
            signUpButton.tap()
        } catch {}
        
        XCTAssert(emailTextField.isHittable)
        XCTAssert(passwordSecureTextField.isHittable)
        XCTAssert(passwordConfirmSecureTextField.isHittable)
    
        emailTextField.tap()
        emailTextField.typeAndContinue(email)
        passwordSecureTextField.typeAndContinue(password)
        passwordConfirmSecureTextField.typeAndContinue(password)
        
        XCTAssert(signUpButton.isEnabled)
        signUpButton.tap()
    }
}

extension XCUIElement {
    func pressEnterKey() {
        self.typeText("\n")
    }
    
    func typeAndContinue(_ text: String) {
        self.typeText(text)
        self.pressEnterKey()
    }
}
