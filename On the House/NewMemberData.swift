//
//  NewMemberData.swift
//  On the House
//
//  Created by bradlbs on 2017/8/30.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import Foundation

class Member{
    
    let id: String
    let firstName: String
    let lastName: String
    let password: String
    
    init(id: String, firstName: String, lastName:String, password:String) {
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
    }
    
    
    func printMemnber(){
        
        
        print("\(id): \(firstName).\(lastName), password: \(password)")
    }
    
    
}

    struct NewMemberData{
        static var nickname = ""
        static var first_name = ""
        static var last_name = ""
        static var zip = ""
        static var zone_id = ""
        static var country_id = ""
        static var timezone_id = ""
        static var question_id = ""
        static var question_text = ""
        static var email = ""
        static var password = ""
        static var password_confirm = ""
        static var term = "1"
        
        static func getinformation() -> [String: String] {
            return ["nickname": nickname,
                    "first_name": first_name,
                    "last_name": last_name,
                    "zip": zip,
                    "zone_id": zone_id,
                    "country_id": country_id,
                    "timezone_id": timezone_id,
                    "question_id": question_id,
                    "question_text": question_text,
                    "email": email,
                    "password": password,
                    "password_confirm": password_confirm,
                    "terms": "1"]
        }

    
    
    
}
