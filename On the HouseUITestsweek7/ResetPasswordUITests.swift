//
//  ResetPasswordUITests.swift
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
        }
        
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDisplaysView_ShouldReturnTrue() {
        app.buttons["Forgot Password?"].tap()
        XCTAssertTrue(app.buttons["Reset Password"].exists)
    }
    
    func testCorrectEmail_ShouldReturnTrue() {
        app.buttons["Forgot Password?"].tap()
        let emailAddressTextField = app.textFields["Email address"]
        emailAddressTextField.tap()
        emailAddressTextField.typeText("778899@example.com")
        app.buttons["Reset Password"].tap()
        XCTAssertTrue(app.buttons["LOGIN"].exists)
    }
    
    func testInCorrectEmail_ShouldReturnFalse() {
        app.buttons["Forgot Password?"].tap()
        let emailAddressTextField = app.textFields["Email address"]
        emailAddressTextField.tap()
        emailAddressTextField.typeText("778899111@example.com")
        app.buttons["Reset Password"].tap()
//        let alert = app.alerts["ON THE HOUSE"]
//        XCTAssertTrue(addUIInterruptionMonitor(withDescription: "ON THE HOUSE") { (alert) -> Bool in
//            alert.buttons["OK"].tap()
//            return true
//            } as! Bool)
        XCTAssertFalse(app.buttons["LOGIN"].exists)
    }
    
}
