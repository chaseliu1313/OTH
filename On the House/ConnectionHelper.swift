//
//  ConnectionHelper.swift
//  On the House
//
//  Created by Chase on 30/8/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


struct ConnectionHelper{
    
    static let baseUrl = "https://ma.on-the-house.org/"
    
    static var status: String = ""
    
    
    
    
    static func getStatus(command: String, parameter : [String: Any], compeletion: @escaping (Bool, Member?) ->Void) {
        
        let url = baseUrl + command
        
        
        var newMember: Member!
        
        
        Alamofire.request(url, method: .post, parameters: parameter).responseJSON(completionHandler: { (response) in
            
            
            if response.result.value != nil{
                
                let json = JSON(response.data!)
                
                if json["status"].string! == "success"{
                    
                    self.status = json["status"].string!
                    let id = json["member"]["id"].string
                    let firstname = json["member"]["first_name"].string
                    let lastName = json["member"]["last_name"].string
                    let password = json["member"]["password"].string
                    
                    //print("\(id!): \(firstname!).\(lastName!), password: \(password!)")
                    
                    newMember = Member(id: id!,firstName: firstname!,lastName: lastName!,password: password!)
                    compeletion(true, newMember)
                    
                }
                
                
            }else {
                compeletion(false, nil)
            }
            
            
        })
        
        
    }
    
    
    
    
    
}
