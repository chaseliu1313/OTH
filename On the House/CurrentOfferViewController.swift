//
//  CurrentOfferViewController.swift
//  On the House
//
//  Created by Chase on 11/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class CurrentOfferViewController: UIViewController {

    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var tickets: UILabel!
    @IBOutlet weak var reviews: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.reviews.backgroundColor = UIColor.clear
        self.reviews.isEditable = false
        // Do any additional setup after loading the view.
    }

   

}
