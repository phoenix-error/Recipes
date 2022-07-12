//
//  SignUpView.swift
//  Recipes
//
//  Created by Luca Becker on 08.05.22.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var router: ViewRouter
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        VStack(spacing: 15) {
            LogoView()
            
            Spacer()
            
            AuthenticationCredentialFieldsView(hasPasswordConfirmation: true)
            
            Button {
                firebaseManager.create()
            } label: {
                Text("Sign Up")
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
            .disabled(firebaseManager.createEnabled)
            
            if firebaseManager.processing {
                ProgressView()
            }
            if !firebaseManager.errorMessage.isEmpty {
                Text("Failed creating account: \(firebaseManager.errorMessage)")
                    .foregroundColor(.red)
            }
            
            Spacer()
            
            AuthenticationBottomBarView(message: "Already have an account?", buttonText: "Log In") {
                withAnimation(.easeInOut) {
                    firebaseManager.setPage(page: .signIn)
                    firebaseManager.clearFields()
                }
            }
        }
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
