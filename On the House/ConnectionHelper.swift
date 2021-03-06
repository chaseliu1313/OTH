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
    static var postStatus: String = ""
    static var errorMesg: String = ""
    
    
    
    //HTTP post method for login
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
                    NewMemberData.nickname = json["member"]["nickname"].string!
                    NewMemberData.zip = json["member"]["zip"].string!
                    NewMemberData.membership_id = json["member"]["membership_level_id"].string!
                    
                    
                    UserDefaults.standard.set(NewMemberData.id, forKey: "member_id")
                    UserDefaults.standard.set(NewMemberData.first_name, forKey: "first_name")
                    UserDefaults.standard.set(NewMemberData.last_name, forKey: "last_name")
                    UserDefaults.standard.set(NewMemberData.zone_id, forKey: "zone_id")
                    UserDefaults.standard.set(NewMemberData.timezone_id, forKey: "timezone_id")
                    UserDefaults.standard.set(NewMemberData.email, forKey: "email")
                    UserDefaults.standard.set(NewMemberData.nickname, forKey: "nickname")
                    UserDefaults.standard.set(NewMemberData.zip, forKey: "zip")
                    UserDefaults.standard.set(NewMemberData.membership_id, forKey: "membership_level_id")
                    UserDefaults.standard.set(json["member"]["password"].string!, forKey: "password")
                    UserDefaults.standard.synchronize()
                    //print("\(id!): \(firstname!).\(lastName!), password: \(password!)")
                    
                    
                    compeletion(true)
                    
                }
                else{
                
                    print("failed")
                    compeletion(false)
                }
                
                
            }else {
                print("failed")
                compeletion(false)
            }
            
            
        })
        
        
    }
    
    
    
    //HTTP post method- universal return error messages from the server 
    static func post(command: String, parameter: [String: Any], compeletion: @escaping (Bool, [String]) -> Void){
        
        let url = baseUrl + command
        
        
        
        Alamofire.request(url, method: .post, parameters: parameter).responseJSON { (response) in
            
            
            switch response.result {
            case .success(_):
                
                self.postStatus = JSON(response.data!)["status"].string!
                
                if self.postStatus == "success"
                {
                    compeletion(true,["Success"])
                }
                else
                {
                    var message: [String] = []
                    self.errorMesg = "The request has failed"
                    
                    let mesg = JSON(response.data!)["error"]["messages"].array!
                    
                    for m in mesg {
                        message.append(m.string!)
                    }
                    
                    
                    compeletion(false,message)
                }
                
            case .failure(_):
                print("connection faild")
                compeletion(false,["connection faild"])
                
                
                
            }
        }
        
        
    }

    
    static func postJSON(command: String, parameter: [String: Any], compeletion: @escaping(Bool, JSON)-> Void) {
        
        
        let url = baseUrl + command
        
        
        
        Alamofire.request(url, method: .post, parameters: parameter).responseJSON { (response) in
            
            let json = JSON(response.data!)
            switch response.result {
            case .success(_):
                
                self.postStatus = JSON(response.data!)["status"].string!
                
                if self.postStatus == "success"
                {
                    compeletion(true,json)
                }
                else
                {
                    self.errorMesg = "The request has failed"
                    compeletion(false,json)
                }
                
            case .failure(_):
                print("connection faild")
                compeletion(false, json)
                
                
            }
        }
        
        
    }
    //HTTP get method updates user detail
    static func get(command: String, completion: @escaping (Bool) -> Void){
      
        let url = baseUrl + command
        
        Alamofire.request(url).responseJSON { (response) in
        
            
            
            switch response.result{
            
            case .success(_):
                
                self.postStatus = JSON(response.data!)["status"].string!
                
                if self.postStatus == "success"
                {
                    
                    completion(true)
                }
                else
                {
                    self.errorMesg = "The request has failed"
                    completion(false)
                }
                
            case .failure(_):
                print("connection faild")
                completion(false)
            
            }
            
        }
    
    
    }
    
    //HTTP get method returns JSON object
    static func getJSON(command: String, completion: @escaping (Bool,JSON) -> Void){
        
        let url = baseUrl + command
        
        Alamofire.request(url).responseJSON { (response) in
            
            
            let json = JSON(response.data!)
            
            switch response.result{
                
            case .success(_):
                
                self.postStatus = JSON(response.data!)["status"].string!
                
                if self.postStatus == "success"
                {
                    
                    completion(true, json)
                }
                else
                {
                    self.errorMesg = "The request has failed"
                    completion(false, JSON.null)
                }
                
            case .failure(_):
                print("connection faild")
                completion(false, JSON.null)
                
            }
            
        }
        
        
    }
    static func getImage(imageURL :String, completion: @escaping (Bool, UIImage) -> Void){
        
        Alamofire.request(imageURL).responseData { (response) in
            
           
            
            switch response.result{
            
            case .success(_):
                 let image = UIImage.init(data: response.data!)
                completion(true,image!)
                
            case .failure(_):
                 
                completion(false, UIImage())
            
            }
            
        }
            
            
            
    }
    
    
}

// Added By Santosh ----///

class NetworkService {
    
    private static var baseURL = "https://ma.on-the-house.org/api/v1/"
    
    private var responseData = [String:JSON]()
    
    /* Get request
     * The code snippet was adapted from these source(s) :
     *   https://github.com/SwiftyJSON/SwiftyJSON#work-with-alamofire
     *   https://stackoverflow.com/questions/27390656/how-to-return-value-from-alamofire
     */
    
    public func getRequest(apiParameters: String, completionHandler: @escaping (Dictionary<String,JSON>) -> Void) {
        
        let url = getCompleteAPIURL(apiParameters: apiParameters)
        
        Alamofire.request(url).responseJSON{ (response) in
            
            switch response.result {
                
            case .success(let value):
                self.responseData = JSON(value).dictionaryValue
                
            case .failure(let error):
                self.handleError(error: error._code)
                
            }
            completionHandler(self.responseData)
        }
        
    }
    
    public func postRequest(apiParameters: String, postParameters: Parameters, completionHandler:@escaping (Dictionary<String,JSON>) -> Void){
        
        let url = NetworkService.baseURL + apiParameters
        
        Alamofire.request(url, method: .post, parameters: postParameters).responseJSON { (response) in
            
            switch(response.result) {
                
            case .success(let value):
                self.responseData = JSON(value).dictionaryValue
                
            case .failure(let error):
                self.handleError(error: error._code)
                
            }
            
            completionHandler(self.responseData)
        }
        
    }
    //---------end of code snippet------------//
    // 15 seconds.
    private func getCompleteAPIURL(apiParameters: String) -> URLRequest {
        let completeAPIUrl = URL(string: NetworkService.baseURL + apiParameters)
        var urlRequest = URLRequest(url: completeAPIUrl!)
        urlRequest.timeoutInterval = 15
        return urlRequest
    }
    
}

extension NetworkService : PNetworkErrorHandler {
    
    func handleError(error: Int) {
        
        switch(error) {
            
        case NSURLErrorTimedOut:
            print("Network Timed Out, Please Try Again Later.")
            break
            
        case NSURLErrorNotConnectedToInternet:
            print("It looks like your iPhone cannot connect to the internet.")
            break
            
        case badURLstatusCode:
            print("Internal Error.")
            break
        default:
            print(error)
            break
            
        }
        
    }
    
}

