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
