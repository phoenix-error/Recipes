//
//  AuthenticationBottomBarView.swift
//  Recipes
//
//  Created by Luca Becker on 12.05.22.
//

import SwiftUI

struct AuthenticationBottomBarView: View {
    
    @EnvironmentObject var router: ViewRouter
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var message: String
    var buttonText: String
    var action: () -> Void
    
    public init(message: String, buttonText: String, action: @escaping () -> Void) {
        self.message = message
        self.buttonText = buttonText
        self.action = action
    }
    
    var body: some View {
        HStack {
            Text(message)
            Button(action: action) {
                Text(buttonText)
            }
        }
        .opacity(0.9)
    }
}

struct AuthenticationBottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationBottomBarView(message: "This is dummy text", buttonText: "Click me") {
            print("Button clicked")
        }
    }
}
