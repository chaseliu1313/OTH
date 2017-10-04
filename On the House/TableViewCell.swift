//
//  TableViewCell.swift
//  On the House
//
//  Created by Geng Xu on 2017/10/4.
//  Copyright © 2017年 Geng Xu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var show: UILabel!
    @IBOutlet weak var detail: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var location: UILabel!
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

}

class TableViewCell2: UITableViewCell {
    @IBOutlet weak var showPast: UILabel!

    @IBOutlet weak var rate: UIButton!

    @IBOutlet weak var datePast: UILabel!
    
    @IBOutlet weak var qtyPast: UILabel!
    
    @IBOutlet weak var locationPast: UILabel!
    
    var eventID :String?
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

}
