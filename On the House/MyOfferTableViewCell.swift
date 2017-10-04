//
//  MyOfferTableViewCell.swift
//  On the House
//
//  Created by Geng Xu on 2017/10/2.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class MyOfferTableViewCell: UITableViewCell {

    @IBOutlet weak var showShortcut: UILabel! //name
    
    @IBOutlet weak var moreInfo: UIButton!
    
    @IBOutlet weak var Cancel: UIButton!
    
    @IBOutlet weak var dateTime: UILabel!
    
    @IBOutlet weak var qty: UILabel!
    
    @IBOutlet weak var venue: UILabel!
    
    var eventID :String?
    var type = true
    
    var sendInfo : sendInfoDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func cancel(_ sender: Any) {
        
    }
    
    @IBAction func moreInfo(_ sender: UIButton) {
        
       sendInfo.sendInfo(eventID: self.eventID!, type: type)
        
    }

}

class MyPastOfferTableViewCell:UITableViewCell {
    
    @IBOutlet weak var showShortcut: UILabel!
    
    @IBOutlet weak var moreInfo: UIButton!
    
    @IBOutlet weak var qty: UILabel!
    
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var venue: UILabel!
    
    var eventID : String?
    var type = false
    
     var sendInfo : sendInfoDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func moreInfo(_ sender: UIButton) {
        
        sendInfo.sendInfo(eventID: self.eventID!, type: type)
    }
    
    
}

protocol sendInfoDelegate {
    func sendInfo(eventID:String, type: Bool)
}
