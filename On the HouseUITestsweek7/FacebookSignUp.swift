//
//  FacebookSignUp.swift
//  On the HouseUITestsweek7
//
//  Created by Client on 27/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import XCTest

class FacebookSignUp: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        app.launch()
        continueAfterFailure = false
        app.launchArguments += ["UI-Testing"]
        //--Delete after Log out has been fixed---//
        if(app.navigationBars["Offers"].exists) {
            let offersNavigationBar = app.navigationBars["Offers"]
            offersNavigationBar.otherElements["Offers"].tap()
            offersNavigationBar.children(matching: .button).element(boundBy: 0).tap()
            app.tables/*@START_MENU_TOKEN@*/.buttons["Log out"]/*[[".cells.buttons[\"Log out\"]",".buttons[\"Log out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        }
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testContinueToFBWorks_ShouldReturnTrue() {
        
        let app = XCUIApplication()
        app.buttons["Continue with facebook"].tap()
        app.alerts["“On the House” Wants to Use “facebook.com” to Sign In"].buttons["Continue"].tap()
        XCTAssertTrue(app.otherElements["URL"].exists)

    }
    
    func testContinueToFBWorksCancelButton_ShouldReturnTrue() {
        
        let app = XCUIApplication()
        app.buttons["Continue with facebook"].tap()
        app.alerts["“On the House” Wants to Use “facebook.com” to Sign In"].buttons["Cancel"].tap()
        XCTAssertFalse(app.otherElements["URL"].exists)
        
    }
    
}
