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
    
    
    var show: Show?
    
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
        
        self.showMembership = Int(self.show!.membership_level_id!)
        self.userMembership = Int(UserDefaults.standard.string(forKey: "membership_level_id")!)
        self.notifyUser(["This is a Gold Membership Event, Please Upgrade First"])
        
        if self.showMembership > userMembership
        {
        self.notifyUser(["This is a Gold Membership Event, Please Upgrade First"])
        }
        
        else
        {
        
        }
        
        
        
        print("somtthing")
    }
    
    
    
    func notifyUser( _ message: [String] ) -> Void
    {
        let meg: String = message[0]
        let alert = UIAlertController(title: "ON THE HOUSE", message: meg, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
}



protocol sendBookingInfoProtocol {
    func sendInfo(qty: Int)
}

