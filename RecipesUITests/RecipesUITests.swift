//
//  RecipesUITests.swift
//  RecipesUITests
//
//  Created by Luca Becker on 08.05.22.
//

import XCTest

class RecipesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRegister() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let email = "\(UUID().uuidString)@dev.de"
        let password = "AAAaaa111!!!"
        let name = "RecipeAppTestUser"
        
        let authenticationScreen = AuthenticationScreen(app: app)
        try authenticationScreen.register(name: name, email: email, password: password)
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
