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
    
    
    
    
    static func userLogin(command: String, parameter : [String: Any], compeletion: @escaping (Bool) ->Void) {
        
        let url = baseUrl + command
        
        
        
        Alamofire.request(url, method: .post, parameters: parameter).responseJSON(completionHandler: { (response) in
            
            
            if response.result.value != nil{
                
                let json = JSON(response.data!)
                
                if json["status"].string! == "success"{
                    
                    self.status = json["status"].string!
                    NewMemberData.loginStatus = self.status
                    NewMemberData.id = json["member"]["id"].string!
                    NewMemberData.first_name = json["member"]["first_name"].string!
                    NewMemberData.last_name = json["member"]["last_name"].string!
                    NewMemberData.zone_id = json["member"]["zone_id"].string!
                    NewMemberData.timezone_id = json["member"]["timezone_id"].string!
                    NewMemberData.email = json["member"]["email"].string!
                    
                    
                    //print("\(id!): \(firstname!).\(lastName!), password: \(password!)")
                    
                    
                    compeletion(true)
                    
                }
                
                
            }else {
                compeletion(false)
            }
            
            
        })
        
        
    }
    
    
    
    
    
}
