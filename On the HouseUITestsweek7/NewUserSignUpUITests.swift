//
//  NewUserSignUpUITests.swift
//  On the HouseUITestsweek7
//
//  Created by Client on 27/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import XCTest

class NewUserSignUpUITests: XCTestCase {
    
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
    
    func testNewUserSignUpLoaded_ShouldReturnTrue() {
        app.buttons["Not a member yet? Sign Up "].tap()
        XCTAssertTrue(app.staticTexts["Nickname:"].exists)
    }
    
    func testNewUserSignUpSuccessfulAttempt_ShouldReturnTrue() {
        
        //works one time, please change nick name and email address for successful test.
        
        app.buttons["Not a member yet? Sign Up "].tap()
        
        let window = app.children(matching: .window).element(boundBy: 0)
        let element = window.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("Nickname111")
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("FirstName")
        
        let textField3 = element.children(matching: .textField).element(boundBy: 2)
        textField3.tap()
        textField3.typeText("LastName")
        
        let pleaseSelectPickerWheel = app/*@START_MENU_TOKEN@*/.pickerWheels["Please Select"]/*[[".pickers.pickerWheels[\"Please Select\"]",".pickerWheels[\"Please Select\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pleaseSelectPickerWheel/*@START_MENU_TOKEN@*/.press(forDuration: 0.5);/*[[".tap()",".press(forDuration: 0.5);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pleaseSelectPickerWheel.swipeUp()
        
        let textField4 = element.children(matching: .textField).element(boundBy: 3)
        textField4.tap()
        textField4.tap()
        textField4.typeText("3000")
        
        let textField5 = element.children(matching: .textField).element(boundBy: 4)
        textField5.tap()
        textField5.typeText("myEmailIsNew@gmail.com")
        
        let secureTextField = element.children(matching: .secureTextField).element(boundBy: 0)
        secureTextField.tap()
        secureTextField.typeText("myPassw0rd")
        
        let secureTextField2 = element.children(matching: .secureTextField).element(boundBy: 1)
        secureTextField2.tap()
        secureTextField2.typeText("myPassw0rd")
        app.buttons["next"].tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["If google search, what did you search for?"]/*[[".pickers.pickerWheels[\"If google search, what did you search for?\"]",".pickerWheels[\"If google search, what did you search for?\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let textField6 = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .textField).element
        textField6.tap()
        textField6.typeText("DailyPlanet")
        app.buttons["T&C."].tap()
        app.navigationBars["Terms And Conditions"].buttons["Done"].tap()
        app.buttons["Sign up"].tap()
        
        let button = app.navigationBars["Offers"].children(matching: .button).element(boundBy: 0)
        button.tap()
        
        let tablesQuery2 = app.tables
        let logOutButton = tablesQuery2/*@START_MENU_TOKEN@*/.buttons["Log out"]/*[[".cells.buttons[\"Log out\"]",".buttons[\"Log out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        logOutButton.tap()
        
        let yourEmailTextField = app.textFields["Your Email"]
        yourEmailTextField.tap()
        yourEmailTextField.typeText("myEmailIsNew@gmail.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("myPassw0rd")
        app.buttons["LOGIN"].tap()
        button.tap()
        
        let myMembershipButton = tablesQuery2/*@START_MENU_TOKEN@*/.buttons["My Membership"]/*[[".cells.buttons[\"My Membership\"]",".buttons[\"My Membership\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        myMembershipButton.tap()
        window.children(matching: .other).element(boundBy: 5).tap()
        app.buttons["SELECT"].tap()
        
        let tablesQuery = app.scrollViews.otherElements.tables
        tablesQuery/*@START_MENU_TOKEN@*/.secureTextFields["Password"]/*[[".cells.secureTextFields[\"Password\"]",".secureTextFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.secureTextFields.containing(.button, identifier:"Clear text").element/*[[".cells.secureTextFields.containing(.button, identifier:\"Clear text\").element",".secureTextFields.containing(.button, identifier:\"Clear text\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("1234")
        app.typeText("\r")
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Pay"]/*[[".cells.staticTexts[\"Pay\"]",".staticTexts[\"Pay\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let onTheHouseAlert = app.alerts["ON THE HOUSE"]
        onTheHouseAlert.buttons["OK"].tap()
        
        let leftArrowButton = app.buttons["left arrow"]
        leftArrowButton.tap()
        myMembershipButton.tap()
        onTheHouseAlert.buttons["Dismiss"].tap()
        leftArrowButton.tap()
        logOutButton.tap()
        
    }
    
    func testUser_ShouldReturnTrue(){

    }
    
}
