//
//  APIHandler.swift
//  AlamofireSwiftyJSONTest2
//
//  Created by Client on 15/9/17.
//  Copyright © 2017 OTH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIHandler {
    
    private static let baseURL = "https://ma.on-the-house.org/api/v1/"
    
    private var responseData = [String:JSON]()
    
    /* Get request
     * The code snippet was adapted from these source(s) :
     *   https://github.com/SwiftyJSON/SwiftyJSON#work-with-alamofire
     *   https://stackoverflow.com/questions/27390656/how-to-return-value-from-alamofire
     */
    
    private func getRequest(apiParameters: String, completionHandler: @escaping (Dictionary<String,JSON>) -> Void) {
        
        let url = APIHandler.baseURL + apiParameters
        
        Alamofire.request(url, method: .get).responseJSON{ (response) in
            
            switch response.result {
                
            case .success(let value):
                
                self.responseData = JSON(value).dictionaryValue
                
            case .failure(let error):
                
                self.responseData = JSON(error).dictionaryValue
                
            }
            
            completionHandler(self.responseData)
        }
        
    }
    
    public func postRequest(apiParameters: String, postParameters: Parameters, completionHandler:@escaping (Dictionary<String,JSON>) -> Void){
        
        let url = APIHandler.baseURL + apiParameters
        
        Alamofire.request(url, method: .post, parameters: postParameters).responseJSON { (response) in
            
            switch(response.result) {
                
            case .success(let value):
                
                self.responseData = JSON(value).dictionaryValue
                
            case .failure(let error):
                
                self.responseData = JSON(error).dictionaryValue
                
            }
            
            completionHandler(self.responseData)
        }
        
    }
    //---------end of code snippet------------//
    
    /* Completion Handler to take data from the Async Data.
     * The following code snippet was adapted from this source :
     *     https://stackoverflow.com/questions/27390656/how-to-return-value-from-alamofire
     */
    
    public func extractGetResponse(apiParameters: String, completionHandler: @escaping (Dictionary<String,JSON>) -> Void) {
        
        getRequest(apiParameters: apiParameters, completionHandler: completionHandler)
        
    }
    
    public func extractPostResponse(apiParameters: String, postParameters: Parameters, completionHandler:@escaping (Dictionary<String,JSON>) -> Void) {
        
        postRequest(apiParameters: apiParameters, postParameters: postParameters, completionHandler: completionHandler)
        
    }
    
    //---------end of code snippet------------//
    
}
