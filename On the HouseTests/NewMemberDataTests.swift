//
//  NewMemberDataTest.swift
//  On the House
//
//  Created by Client on 1/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import XCTest
@testable import On_the_House

class NewMemberDataTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataMembers_ShouldReturnEmptyStringOnStart(){
    
        XCTAssertEqual(NewMemberData.nickname, "")
        XCTAssertEqual(NewMemberData.first_name, "")
        XCTAssertEqual(NewMemberData.last_name, "")
        XCTAssertEqual(NewMemberData.zip, "")
        XCTAssertEqual(NewMemberData.zone_id, "")
        XCTAssertEqual(NewMemberData.country_id, "")
        XCTAssertEqual(NewMemberData.timezone_id, "")
        XCTAssertEqual(NewMemberData.question_id, "")
        XCTAssertEqual(NewMemberData.question_text, "")
        XCTAssertEqual(NewMemberData.email, "")
        XCTAssertEqual(NewMemberData.password, "")
        XCTAssertEqual(NewMemberData.password_confirm, "")
        XCTAssertEqual(NewMemberData.terms, "1")
        XCTAssertEqual(NewMemberData.id, "")
        XCTAssertEqual(NewMemberData.street, "")
        XCTAssertEqual(NewMemberData.city, "")
        XCTAssertEqual(NewMemberData.phone, "")
        XCTAssertEqual(NewMemberData.title, "")
        XCTAssertEqual(NewMemberData.membership_id, "")
        XCTAssertEqual(NewMemberData.loginStatus, "error")
    }
    
    func testGetInformationFunc_ShouldReturnDictionaryWith13Fields() {
        XCTAssertEqual(NewMemberData.getinformation().keys.count, 13)
        XCTAssertEqual(NewMemberData.getinformation().values.count, 13)
    }

    func testGetInformationFuncVerifyDataStruct_ShouldHave13Fields(){
        XCTAssertNotNil(NewMemberData.getinformation()["nickname"])
        XCTAssertNotNil(NewMemberData.getinformation()["first_name"])
        XCTAssertNotNil(NewMemberData.getinformation()["last_name"])
        XCTAssertNotNil(NewMemberData.getinformation()["zip"])
        XCTAssertNotNil(NewMemberData.getinformation()["zone_id"])
        XCTAssertNotNil(NewMemberData.getinformation()["country_id"])
        XCTAssertNotNil(NewMemberData.getinformation()["timezone_id"])
        XCTAssertNotNil(NewMemberData.getinformation()["question_id"])
        XCTAssertNotNil(NewMemberData.getinformation()["question_text"])
        XCTAssertNotNil(NewMemberData.getinformation()["email"])
        XCTAssertNotNil(NewMemberData.getinformation()["password"])
        XCTAssertNotNil(NewMemberData.getinformation()["password_confirm"])
        XCTAssertNotNil(NewMemberData.getinformation()["terms"])
        XCTAssertEqual(NewMemberData.getinformation()["terms"], "1")
    }
    
}
