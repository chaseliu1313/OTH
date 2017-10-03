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
    
    var eventID = ""
    var type = true
    
    
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
        
    }

}

class MyPastOfferTableViewCell:UITableViewCell {
    
    @IBOutlet weak var showShortcut: UILabel!
    
    @IBOutlet weak var moreInfo: UIButton!
    
    @IBOutlet weak var qty: UILabel!
    
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var venue: UILabel!
    
    var eventID = ""
    var type = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func moreInfo(_ sender: UIButton) {
        
    }
    
    
}

protocol sendInfoDelegate {
    func sendInfo(eventID:String, type: Bool)
}
