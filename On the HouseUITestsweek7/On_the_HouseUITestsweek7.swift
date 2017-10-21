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
    
    
    func testOfferHome() {
        //User tap "Proceed without Log in" offerHome show up
        let app = XCUIApplication()
        app.buttons["Proceed without Log in"].tap()
        
        
    }
    
    func testOffReload(){
        //User reload offer
        
        XCUIApplication().buttons["Proceed without Log in"].tap()

    }
    
    func testDetail(){
        
        
    }
    
    func testPastOffer(){
        //User Log in, there will be no past offer and there is no history
        let app = XCUIApplication()
        let yourEmailTextField = app.textFields["Your Email"]
        yourEmailTextField.tap()
        yourEmailTextField.typeText("334455@123.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("123456")
        app.buttons["LOGIN"].tap()
        app.navigationBars["Offers"].children(matching: .button).element(boundBy: 0).tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["My Offers"]/*[[".cells.buttons[\"My Offers\"]",".buttons[\"My Offers\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["left arrow"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Log out"]/*[[".cells.buttons[\"Log out\"]",".buttons[\"Log out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        

        
    }
    
    
}
