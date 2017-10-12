//
//  AllRatingTabTableViewCell.swift
//  On the House
//
//  Created by Chase on 12/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class AllRatingTabTableViewCell: UITableViewCell {
    
    @IBOutlet weak var starts: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var comment: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
