//
//  LogoView.swift
//  Recipes
//
//  Created by Luca Becker on 11.05.22.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .padding()
            .frame(width: 400, height: 200)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
