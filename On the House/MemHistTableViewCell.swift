//
//  MemHistTableViewCell.swift
//  memHistoryRefined
//
//  Created by Santosh on 17/10/17.
//  Copyright © 2017 OTH. All rights reserved.
//

import UIKit

class MemHistTableViewCell: UITableViewCell {

    @IBOutlet weak var memLevel: UILabel!
    @IBOutlet weak var memPeriod: UILabel!
    @IBOutlet weak var memPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
