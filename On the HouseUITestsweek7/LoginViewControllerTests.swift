//
//  LoginViewControllerTests.swift
//  On the House
//
//  Created by Client on 29/9/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import XCTest

class LoginViewControllerTests: XCTestCase {
    
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
    
    func testIfAllUIElementsExists_ShouldReturnTrue() {
        
        if(app.navigationBars["Offers"].exists) {
            let offersNavigationBar = app.navigationBars["Offers"]
            offersNavigationBar.otherElements["Offers"].tap()
            offersNavigationBar.children(matching: .button).element(boundBy: 0).tap()
            app.tables/*@START_MENU_TOKEN@*/.buttons["Log out"]/*[[".cells.buttons[\"Log out\"]",".buttons[\"Log out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        }
        
        XCTAssertTrue(app.textFields["Your Email"].exists)
        XCTAssertTrue(app.secureTextFields["Password"].exists)
        XCTAssertTrue(app.buttons["LOGIN"].exists)
        XCTAssertTrue(app.buttons["Forgot Password?"].exists)
        XCTAssertTrue(app.buttons["Continue with facebook"].exists)
        XCTAssertTrue(app.buttons["Not a member yet? Sign Up "].exists)
        XCTAssertTrue(app.buttons["Proceed without Log in"].exists)
        XCTAssertTrue(app.images["OTH-logo-lightbkgd-hires"].exists)
        XCTAssertTrue(app.images["Background"].exists)
        XCTAssertEqual(app.images["Background"].frame.height, app.frame.height)
        XCTAssertEqual(app.images["Background"].frame.width, app.frame.width)
      //  XCTAssertEqual(app.images["OTH-logo-lightbkgd-hires"].frame.height, 208)
      //  XCTAssertEqual(app.images["OTH-logo-lightbkgd-hires"].frame.width, 261)
        
    }
    
    
    func testInvalidCredentials_ShouldDisplayInvalidCredentialsAlert() {
        
        let yourEmailTextField = app.textFields["Your Email"]
        yourEmailTextField.tap()
        yourEmailTextField.typeText("test.oth.2017@gmail.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("1234")

        app.buttons["LOGIN"].tap()
        
        addUIInterruptionMonitor(withDescription:"Invalid Email Address/Password") { (alert) -> Bool in
            alert.buttons["OK"].tap()
            return true
        }
        
    }
  
    func testNoCredentials_ShouldDisplayEnterCredentialAlert() {
        
        app.buttons["LOGIN"].tap()
        
        addUIInterruptionMonitor(withDescription:"Enter Your Email or Password") { (alert) -> Bool in
            alert.buttons["OK"].tap()
            return true
        }
    
    }
    
    func testCorrectCredentials_ShouldDisplayOfferScreen() {
    
        let yourEmailTextField = app.textFields["Your Email"]
        yourEmailTextField.tap()
        yourEmailTextField.typeText("test.user.oth.2017@gmail.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("1234")
        
        app.buttons["LOGIN"].tap()
        
        XCTAssertTrue(app.navigationBars["Offers"].exists)

        app.navigationBars["Offers"].buttons["menu ui interface collection s"].tap()
        app.tables.buttons["Log out"].tap()
        
        XCTAssertTrue(app.buttons["LOGIN"].exists)
        
    }
    
    func testForgotPasswordButton_ShouldDisplayForgotPwdScreen() {
        
        app.buttons["Forgot Password?"].tap()
        XCTAssertTrue(app.buttons["Reset Password"].exists)
        app.buttons["icons8 chevron left filled 1"].tap()
        
    }
    
    func testSignUpButton_ShouldDisplaySignUpScreen() {
        
        app.buttons["Not a member yet? Sign Up "].tap()
        XCTAssertTrue(app.buttons["icons8 chevron left filled 1"].exists)
        app.buttons["icons8 chevron left filled 1"].tap()
        
    }
    
    func testSkipLoginButton_ShouldDisplaySignUpScreen() {
        
        app.buttons["Proceed without Log in"].tap()
        app.navigationBars["Offers"].buttons["menu ui interface collection s"].tap()
        app.tables.buttons["Log out"].tap()
        
    }

}
