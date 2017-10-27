//
//  ChangePasswordUITests.swift
//  On the HouseUITestsweek7
//
//  Created by Client on 27/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import XCTest

class ChangePasswordUITests: XCTestCase {
    
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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChangePassword_ShouldReturnTrue() {
        
        //Please change password to successfully run this test.
        
        let app = XCUIApplication()
        
        if(app.navigationBars["Offers"].exists) {
            let offersNavigationBar = app.navigationBars["Offers"]
            offersNavigationBar.otherElements["Offers"].tap()
            offersNavigationBar.children(matching: .button).element(boundBy: 0).tap()
            app.tables/*@START_MENU_TOKEN@*/.buttons["Log out"]/*[[".cells.buttons[\"Log out\"]",".buttons[\"Log out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        }
        
        let yourEmailTextField = app.textFields["Your Email"]
        yourEmailTextField.tap()
        yourEmailTextField.typeText("myEmailIsNew2@gmail.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("myPassw0rd2")
        
        app.buttons["LOGIN"].tap()
        
        app.navigationBars["Offers"].children(matching: .button).element(boundBy: 0).tap()
        
        let tablesQuery2 = app.tables
        let changePasswordButton = tablesQuery2/*@START_MENU_TOKEN@*/.buttons["Change Password"]/*[[".cells.buttons[\"Change Password\"]",".buttons[\"Change Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        changePasswordButton.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        let element2 = element.children(matching: .other).element
        let secureTextField = element2.children(matching: .secureTextField).element(boundBy: 0)
        secureTextField.tap()
        
        let leftArrowButton = app.buttons["left arrow"]
        leftArrowButton.tap()
        
        let tablesQuery = tablesQuery2
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Update Profile"]/*[[".cells.buttons[\"Update Profile\"]",".buttons[\"Update Profile\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["left arrow"]/*[[".scrollViews.buttons[\"left arrow\"]",".buttons[\"left arrow\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        changePasswordButton.tap()
        secureTextField.tap()
        secureTextField.typeText("myPassw0rd")
        
        let secureTextField2 = element2.children(matching: .secureTextField).element(boundBy: 1)
        secureTextField2.tap()
        secureTextField2.typeText("myPassw0rd2")
        
        let secureTextField3 = element2.children(matching: .secureTextField).element(boundBy: 2)
        secureTextField3.tap()
        secureTextField3.typeText("myPassw0rd2")
        app.buttons["Change Password"].tap()
        app.alerts["ON THE HOUSE"].buttons["OK"].tap()
        leftArrowButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Log out"]/*[[".cells.buttons[\"Log out\"]",".buttons[\"Log out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
}
