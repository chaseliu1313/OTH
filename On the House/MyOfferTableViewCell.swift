//
//  MyOfferTableViewCell.swift
//  On the House
//
//  Created by Geng Xu on 2017/10/2.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class MyOfferTableViewCell: UITableViewCell {

    @IBOutlet weak var showShortcut: UILabel!
    
    @IBOutlet weak var moreInfo: UIButton!
    
    @IBOutlet weak var Cancel: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class MyPastOfferTableViewCell:UITableViewCell {
    
    @IBOutlet weak var showShortcut: UILabel!
    
    @IBOutlet weak var moreInfo: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
