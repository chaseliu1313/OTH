//
//  Checkbox.swift
//  On the House
//
//  Created by Zhang Zhang on 9/7/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class Checkbox: UIButton {

   //set up images
    var checkImage = UIImage(named: "checked")
    var uncheckImage = UIImage(named: "check")
    
    //bool 
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkImage, for: .normal)
            }else {
                self.setImage(uncheckImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: .touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if (sender == self) {
            if isChecked == true {
                isChecked = false
            }else {
                isChecked = true
            }
        }
    }
}
