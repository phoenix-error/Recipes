//
//  RootView.swift
//  Recipes
//
//  Created by Luca Becker on 08.05.22.
//

import SwiftUI

struct RootView: View {
    @State var isAuthenticated = AppManager.isAuthenticated()
    var body: some View {
        Group {
            isAuthenticated ?
            AnyView(HomeView()) :
            AnyView(AuthenticationView())
        }
        .onReceive(AppManager.Authenticated, perform: {
            isAuthenticated = $0
        })
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
