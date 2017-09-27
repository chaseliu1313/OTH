//
//  File.swift
//  AlamofireSwiftyJSONTest2
//
//  Created by Client on 15/9/17.
//  Copyright © 2017 OTH. All rights reserved.
//

import UIKit

class DateUtility {
    
    public func getFormattedDate(dateToConvert: Double, format: String) -> String {
        
        let date = NSDate(timeIntervalSince1970: dateToConvert)
        
        let dateFormating = DateFormatter()
        dateFormating.dateFormat = format
        
        return dateFormating.string(from: date as Date)
        
    }
}
