//
//  DateUtility.swift
//  memHistoryRefined
//
//  Created by Santosh on 18/10/17.
//  Copyright © 2017 OTH. All rights reserved.
//

import Foundation

struct DateUtility {
    
    static func getFormattedDate(dateToConvert: Double, format: String) -> String {
        
        let date = NSDate(timeIntervalSince1970: dateToConvert)
        
        let dateFormating = DateFormatter()
        dateFormating.dateFormat = format
        
        return dateFormating.string(from: date as Date)
        
    }
}
