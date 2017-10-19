//
//  VC1.swift
//  memHistoryRefined
//
//  Created by Santosh on 18/10/17.
//  Copyright © 2017 OTH. All rights reserved.
//

import UIKit

extension MemHisViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.memHistResponseData["memberships"] != nil else {
            return 0
        }
        
        return (self.memHistResponseData["memberships"]?.arrayValue.count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard self.memHistResponseData["memberships"] != nil else {
            return UITableViewCell()
        }
        
        let cell = memHistTableView.dequeueReusableCell(withIdentifier: "mhCell", for: indexPath) as! MemHistTableViewCell
        
        cell.memLevel.text = self.memHistResponseData["memberships"]![indexPath.row]["membership_level_name"].stringValue
        
        let startDate:String = DateUtility.getFormattedDate(dateToConvert: self.memHistResponseData["memberships"]![indexPath.row]["date_created"].doubleValue, format: "dd/MM/YYYY")
        let endDate:String = DateUtility.getFormattedDate(dateToConvert: self.memHistResponseData["memberships"]![indexPath.row]["date_expires"].doubleValue, format: "dd/MM/YYYY")
        
        cell.memPeriod.text = startDate + " - " + endDate
        
        cell.memPrice.text = "$" + self.memHistResponseData["memberships"]![indexPath.row]["price"].stringValue
        
        return cell
    }
}
