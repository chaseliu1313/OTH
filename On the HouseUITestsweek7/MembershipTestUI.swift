//
//  MembershipTestUI.swift
//  On the HouseUITestsweek7
//
//  Created by Client on 27/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import XCTest

class MembershipTestUI: XCTestCase {
    
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
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMembershipUILoaded_ShouldReturnTrue() {
        
        // members must be bronze first.
        
        let app = XCUIApplication()
        let button = app.navigationBars["Offers"].children(matching: .button).element(boundBy: 0)
        button.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Log out"]/*[[".cells.buttons[\"Log out\"]",".buttons[\"Log out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let yourEmailTextField = app.textFields["Your Email"]
        yourEmailTextField.tap()
        yourEmailTextField.typeText("myEmailIsNew2@gmail.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("myPassw0rd2")
        app.buttons["LOGIN"].tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["My Membership"]/*[[".cells.buttons[\"My Membership\"]",".buttons[\"My Membership\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).tap()
        app.buttons["SELECT"].tap()
        
        let tablesQuery2 = app.scrollViews.otherElements.tables
        tablesQuery2/*@START_MENU_TOKEN@*/.secureTextFields["Password"]/*[[".cells.secureTextFields[\"Password\"]",".secureTextFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.secureTextFields.containing(.button, identifier:"Clear text").element/*[[".cells.secureTextFields.containing(.button, identifier:\"Clear text\").element",".secureTextFields.containing(.button, identifier:\"Clear text\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("1234")
        app.typeText("\r")
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Pay"]/*[[".cells.staticTexts[\"Pay\"]",".staticTexts[\"Pay\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["ON THE HOUSE"].buttons["OK"].tap()
        
    }
    
    func testDowngradeMembership_ShouldReturnTrue() {
        
        let app = XCUIApplication()
        app.navigationBars["Offers"].children(matching: .button).element(boundBy: 0).tap()
        
        let tablesQuery2 = app.tables
        let myMembershipButton = tablesQuery2/*@START_MENU_TOKEN@*/.buttons["My Membership"]/*[[".cells.buttons[\"My Membership\"]",".buttons[\"My Membership\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        myMembershipButton.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        element.tap()
        
        let selectButton = app.buttons["SELECT"]
        selectButton.tap()
        
        let tablesQuery = app.scrollViews.otherElements.tables
        tablesQuery/*@START_MENU_TOKEN@*/.secureTextFields["Password"]/*[[".cells.secureTextFields[\"Password\"]",".secureTextFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.secureTextFields.containing(.button, identifier:"Clear text").element/*[[".cells.secureTextFields.containing(.button, identifier:\"Clear text\").element",".secureTextFields.containing(.button, identifier:\"Clear text\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("1234")
        app.typeText("\r")
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Pay"]/*[[".cells.staticTexts[\"Pay\"]",".staticTexts[\"Pay\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let onTheHouseAlert = app.alerts["ON THE HOUSE"]
        onTheHouseAlert.buttons["OK"].tap()
        app.buttons["left arrow"].tap()
        myMembershipButton.tap()
        element.tap()
        selectButton.tap()
        onTheHouseAlert.buttons["Dismiss"].tap()

        
        
    }
    
}
