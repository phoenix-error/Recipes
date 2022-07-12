//
//  SignInView.swift
//  Recipes
//
//  Created by Luca Becker on 08.05.22.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var router: ViewRouter
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        VStack(spacing: 15) {
            LogoView()
            
            Spacer()
            
            AuthenticationCredentialFieldsView(hasPasswordConfirmation: false)
            
            Button {
                firebaseManager.login()
            } label: {
                Text("Log In")
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
            .disabled(firebaseManager.loginEnabled)
            
            if firebaseManager.processing {
                ProgressView()
            }
            
            if !firebaseManager.errorMessage.isEmpty {
                Text("Failed creating account: \(firebaseManager.errorMessage)")
                    .foregroundColor(.red)
            }
            
            Spacer()
            
            AuthenticationBottomBarView(message: "Don't have an account?", buttonText: "Sign Up") {
                withAnimation(.easeInOut) {
                    firebaseManager.setPage(page: .signUp)
                    firebaseManager.clearFields()
                }
            }
        }
        .padding()
        
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
