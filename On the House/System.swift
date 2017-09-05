//
//  System.swift
//  On the House
//
//  Created by Chase on 30/8/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import Foundation


class System {
    
    static var didAuth: Bool = false

    static let timezones:[String : Int] = ["Perth" : 92, "Adelaide" : 100, "Darwin": 101, "Brisbane": 102, "Canberra": 103, "Hobart": 105, "Melbourne": 106, "Sydney": 108]
    
    static let states:[String : Int] = ["New South Wales" : 211, "Northern Territory": 212, "Queensland" : 213, "South Australia": 214, "Tasmania": 215, "Victoria": 216, "Western Australia": 217, "Australian Capital Territory": 210]
    
    static let questions:[String: Int] = ["If Google Search, what did you search for?" : 1,"Friend" : 2, "Newsletter": 3, "Twitter": 4, "Facebook" : 5, "LinkedIN" : 6, "Forum" : 7, "If Blog, what blog was it?": 22, "Footy Funatics": 26, "Toorak Times": 27, "Only Melbourne Website": 28, "Yelp" :29 , "Good Weekend website" : 30
    
    ]
    
    static let categories:[String: Int] = ["Adult Industry": 28, "Arts & Craft": 22, "Ballet" : 9, "Cabaret" : 17, "CD (product)": 37, "Children": 26, "Cirus and Physical Theatre": 16, "Comedy": 5, "Dance": 6, "DVD (Product)": 35, "Family": 32, "Festival": 15, "Film": 3, "Health and Fitness": 30, "Magic" : 38, "Miscellaneous":7, "Music": 4, "Musical":2, "Networking, Seminars, Workshops": 27, "Opera":8, "Operetta": 18, "Reiki Course": 20, "Speaking Engagement": 34, "Sport": 33, "Studio Audience": 31, "Theatre": 1, "Vaudeville": 19
    ]
    
    
   
    init(){
    }
    
    
    static func oneTimelogin()->Bool{
    
        if (NewMemberData.loginStatus == "success"){
        
        self.didAuth = true
            return self.didAuth
        }
        else{
        return self.didAuth
        }
    }
    
    
    
    static func getCategories(category : String) -> String
    {
        
        var id : Int!
        
        for selected in categories.keys {
        
            if category.contains(selected) {
            
            id = categories[category]
                return String(id)
            
            }
            else {id = 0}
        }
    
     return String(id)
        
    }
    
    
    static func getQuestion(question: String) -> String
    {
        var selected: String!
        var id: Int!
        
        for(selected) in questions.keys
        {
            if question.contains(selected) {
            
            id = questions[question]
              return String(id)
                
            }
            
            else {id = 0}
        }
        
    return String(id)
    }
    
    
    static func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    
    
    
    static func getTimezone() -> String {
    
        let timezone = TimeZone.current.identifier
        
        var location: String!
        
        var code: Int!
        
        for (location) in timezones.keys {
        
            if timezone.contains(location) {
            
            code = timezones[location]
                return String(code)
            }
            
            else{
                code = 0
            
            }
        }
    
        return String(code)
    }
    
    static func setCountry() -> String {
    
        return "13"
    
    }
    
    
    
    
    static func setState(state: String) -> String {
    
        var location: String!
        var code: Int!
        
        for (location) in states.keys {
            
            if state.contains(location) {
                
                code = states[location]
                return String(code)
            }
                
            else{
                code = 0
                
            }
        }
        
        return String(code)
    }

}
