//
//  ResetPassword.swift
//  On the HouseUITestsweek7
//
//  Created by Client on 27/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import XCTest

class ResetPasswordUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments += ["UI-Testing"]
        //--Delete after Log out has been fixed---//
        if(app.navigationBars["Offers"].exists) {
            let offersNavigationBar = app.navigationBars["Offers"]
            offersNavigationBar.otherElements["Offers"].tap()
            offersNavigationBar.children(matching: .button).element(boundBy: 0).tap()
            app.tables/*@START_MENU_TOKEN@*/.buttons["Log out"]/*[[".cells.buttons[\"Log out\"]",".buttons[\"Log out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.buttons["Forgot Password?"].tap()
        }

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testResetPasswordViewIsDisplayed_ShouldReturnTrue() {
        
        let resetPasswordButton = app.buttons["Reset Password"]
        resetPasswordButton.tap()
        XCTAssertTrue(resetPasswordButton.exists)
        
    }
    
    func testCorrectCredentials_ShouldReturnTrue() {
        
        
        
    }
    
}
