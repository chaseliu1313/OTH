//
//  On_the_HouseUITestsweek7.swift
//  On the HouseUITestsweek7
//
//  Created by Chase on 11/9/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import XCTest

class On_the_HouseUITestsweek7: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testExample() {
//        
//        
////        let app = XCUIApplication()
////        let yourEmailTextField = app.textFields["Your Email"]
////        yourEmailTextField.tap()
////        yourEmailTextField.typeText("778899@exampl")
////        
////        let passwordSecureTextField = app.secureTextFields["Password"]
////        passwordSecureTextField.typeText("e.com")
////        passwordSecureTextField.tap()
////        passwordSecureTextField.tap()
////        passwordSecureTextField.typeText("65")
////        app.typeText("4321")
////        
////        let window = app.children(matching: .window).element(boundBy: 0)
////        window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).tables.children(matching: .cell).element(boundBy: 0).tap()
////        
////        let tablesQuery = app.tables
////        tablesQuery.buttons["My Membership"].tap()
////        app.buttons["icons8 chevron left filled 1"].tap()
////        tablesQuery.buttons["Change Passwrod"].tap()
////        
////        let element = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element
////        let secureTextField = element.children(matching: .secureTextField).element(boundBy: 0)
////        secureTextField.tap()
////        secureTextField.typeText("654321098")
////        
////        let secureTextField2 = element.children(matching: .secureTextField).element(boundBy: 1)
////        secureTextField2.tap()
////        secureTextField2.tap()
////        secureTextField2.typeText("1234")
////        element.children(matching: .secureTextField).element(boundBy: 2).typeText("56")
//        
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
    
}
