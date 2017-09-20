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
        
        
        print("somtthing")
    }
}

protocol sendBookingInfoProtocol {
    func sendInfo(qty: Int)
}
