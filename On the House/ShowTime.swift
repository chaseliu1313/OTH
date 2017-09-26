//
//  ShowTime.swift
//  On the House
//
//  Created by Geng Xu on 9/19/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class ShowTime: UITableViewCell {


    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var ticketNumber: UITextField!
    @IBOutlet weak var bookNow: UIButton!

    var userMembership: Int!
    var showMembership: Int!
    
    var isCompetition = false
    var show: Show?
    
    var sendInfo : sendBookingInfoProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func bookNow(_ sender: Any) {
        let qty = ticketNumber.text!
        var error = ""
        let shipping = self.show!.shipping
        
        self.showMembership = Int(self.show!.membership_level_id!)
        self.userMembership = Int(UserDefaults.standard.string(forKey: "membership_level_id")!)
        
        if self.showMembership > userMembership
        {
        error = "This is a Gold Membership Event, Please Upgrade First"
            
        }
        
        let show_id = self.show!.id
        
        
        sendInfo.sendInfo(qty: qty, error: error, isCom: self.isCompetition, show_id: show_id!, shipping: shipping!)
        
        
        
        
    }
    
    
    
   
}



protocol sendBookingInfoProtocol {
    func sendInfo(qty: String, error: String, isCom: Bool, show_id: String, shipping: Bool)
}



