//
//  ContentView.swift
//  Recipes
//
//  Created by Luca Becker on 08.05.22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var router: ViewRouter
    
    var body: some View {
        switch router.currentPage {
        case .signIn:
            SignInView()
                .transition(.slide)
        case .signUp:
            SignUpView()
                .transition(.slide)
        case .home:
            HomeView()
                .transition(.scale)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
