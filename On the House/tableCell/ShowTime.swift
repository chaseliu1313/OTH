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
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var limit: UILabel!
    
    var userMembership: Int!
    var showMembership: Int!
    var isSoldOut = false
    
    var isCompetition = false
    var show: Show?
    var uplimit = 0
    var bottomlimit = 0
    
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
        
       
        var error = ""
        let shipping = self.show!.shipping!
        
       
        
        self.showMembership = Int(self.show!.membership_level_id!)
       
        
        var memberLevel = 0
        
        if let Mlevel =  UserDefaults.standard.string(forKey: "membership_level_id")
        {
            memberLevel = Int(Mlevel)!
        }
        
         self.userMembership = memberLevel
        
        if self.showMembership > userMembership
        {
        error = "This is a Gold Membership Event, Please Upgrade First"
            
        }
        
        if ticketNumber.text!.isEmpty  && !self.ticketNumber.isHidden {
            
            error = "Please Enter the Quantity"
            
        }
        
        if !UserDefaults.standard.bool(forKey: "isLoggedIn") {
            
            error = "Please log in first"
        }
        
        if isSoldOut {

            error = "This show has been sold out"
        }
        
        
        
        
        
        if let qty = ticketNumber.text, let show_id = self.show?.id {
            
            let qtyNum = Int(qty)!
            if bottomlimit == 0 {
                
                
                if qtyNum <= bottomlimit || qtyNum > uplimit {
                    
                    error = "Please Enter the corret quantity"
                }
                
            }
            else {
                
                if qtyNum != uplimit {
                    
                    error = "You can only reserve \(uplimit) tickets"
                }
                
            }
            
        
        sendInfo.sendInfo(qty: qty, error: error, isCom: self.isCompetition, show_id: show_id, shipping: shipping)
        
        }
        
    }
    

    
    
   
}



protocol sendBookingInfoProtocol {
    func sendInfo(qty: String, error: String, isCom: Bool, show_id: String, shipping: Bool)
}



