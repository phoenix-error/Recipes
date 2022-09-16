//
//  AuthenticationView.swift
//  Recipes
//
//  Created by Luca Becker on 16.09.22.
//

import SwiftUI

struct AuthenticationView: View {
    enum Field: Hashable {
        case email
        case password
        case repeatPassword
    }
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack(spacing: 15) {
            LogoView()
            
            Spacer()
            
            TextField("Email", text: $viewModel.email)
                .credentialField()
                .textContentType(.emailAddress)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
            
            SecureField("Password", text: $viewModel.password)
                .credentialField()
                .textContentType(.password)
                .focused($focusedField, equals: .password)
                .submitLabel(viewModel.isSignUp ? .next: .done)
            
            if viewModel.isSignUp {
                SecureField("Repeat Password", text: $viewModel.repeatPassword)
                    .credentialField()
                    .textContentType(.password)
                    .border(Color.red, width: viewModel.matchingPasswords ? 0 : 1)
                    .focused($focusedField, equals: .repeatPassword)
                    .submitLabel(.done)
            }
            
            Spacer()
            
            Button(action: viewModel.isSignUp ? viewModel.signUp: viewModel.login) {
                Text(viewModel.actionButtonText)
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
            .disabled(!viewModel.actionButtonEnabled)
            
            Spacer()
            
            AuthenticationBottomBarView(message: viewModel.bottomText, buttonText: viewModel.bottomButtonText) {
                withAnimation(.easeInOut) {
                    viewModel.switchScreens()
                }
            }
        }
        .padding()
        .onSubmit {
            switch focusedField {
            case .email:
                focusedField = .password
            case .password:
                if viewModel.isSignUp {
                    focusedField = .repeatPassword
                }
                focusedField = nil
            default:
                focusedField = nil
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}

struct CredentialField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.thinMaterial)
            .cornerRadius(10)
            .textInputAutocapitalization(.never)
    }
}

extension View {
    func credentialField() -> some View {
        modifier(CredentialField())
    }
}
