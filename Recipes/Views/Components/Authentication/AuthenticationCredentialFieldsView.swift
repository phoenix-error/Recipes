//
//  AuthenticationCredentialFieldsView.swift
//  Recipes
//
//  Created by Luca Becker on 12.05.22.
//

import SwiftUI

struct AuthenticationCredentialFieldsView: View {
    
    enum Field: Hashable {
        case email
        case password
        case confirmPassword
    }
    
    @EnvironmentObject var firebaseManager: FirebaseManager
    @FocusState private var focusedField: Field?
    
    let hasPasswordConfirmation: Bool
    
    var body: some View {
        Group {
            TextField("Email", text: $firebaseManager.email)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
                .textContentType(.emailAddress)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
            
            SecureField("Password", text: $firebaseManager.password)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
                .textContentType(.password)
                .padding(.bottom, hasPasswordConfirmation ? 0 : 30)
                .focused($focusedField, equals: .password)
                .submitLabel(hasPasswordConfirmation ? .next: .done)
        
            if hasPasswordConfirmation {
                SecureField("Confirm Password", text: $firebaseManager.passwordConfirmation)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                    .textContentType(.password)
                    .border(Color.red, width: firebaseManager.passwordConfirmation != firebaseManager.password ? 1 : 0)
                    .padding(.bottom, 30)
                    .focused($focusedField, equals: .confirmPassword)
                    .submitLabel(.done)
            }
        }
        .onSubmit {
            switch focusedField {
            case .email:
                focusedField = .password
            case .password:
                if hasPasswordConfirmation {
                    focusedField = .confirmPassword
                }
                focusedField = nil
            default:
                focusedField = nil
            }
        }
    }
    
}

struct AuthenticationCredentialFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationCredentialFieldsView(hasPasswordConfirmation: true)
        AuthenticationCredentialFieldsView(hasPasswordConfirmation: false)
    }
}
