//
//  MHTableViewCell.swift
//  AlamofireSwiftyJSONTest2
//
//  Created by Client on 15/9/17.
//  Copyright © 2017 OTH. All rights reserved.
//

import UIKit

class MHTableViewCell: UITableViewCell {

    @IBOutlet weak var membershipLevel: UILabel!
    @IBOutlet weak var membershipPeriod: UILabel!
    @IBOutlet weak var membershipPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
