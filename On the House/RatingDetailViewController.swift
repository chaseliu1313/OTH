//
//  RatingDetailViewController.swift
//  On the House
//
//  Created by Chase on 3/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class RatingDetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var Offerdescription: UITextView!
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var rating: UIImageView!
    @IBOutlet weak var comments: UITextView!
    
    var event_id = ""
    
    var Userrating = ""
    
    var type = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detail page: \(event_id)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func slider(_ sender: UISlider) {
        
        sender.value = roundf(sender.value)
        self.Userrating = String(roundf(sender.value))
        
    }
  

}
