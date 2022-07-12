//
//  ViewRouter.swift
//  Recipes
//
//  Created by Luca Becker on 08.05.22.
//

import SwiftUI

final class ViewRouter: ObservableObject {
    @Published var currentPage: AppPage = .signIn
}

enum AppPage {
    case signIn, signUp, home
}
