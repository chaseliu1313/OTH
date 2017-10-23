//
//  FinishReservViewController.swift
//  On the House
//
//  Created by Chase on 13/10/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class FinishReservViewController: UIViewController {

    
    var nonce = ""
    var reservation_id = " "
    var show_id = " "
    var member_id = " "
    var price = " "
    var tickets = " "
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var lable: UILabel!
    
    
    let command = "api/v1/reserve/complete"
    var parameter = ["nonce": "", "reservation_id":"", "show_id": "", "member_id": "", "price": "", "tickets": ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.spinner.hidesWhenStopped = true
         self.spinner.startAnimating()
  UIApplication.shared.beginIgnoringInteractionEvents()
    self.parameter.updateValue(self.reservation_id, forKey: "reservation_id")
        self.parameter.updateValue(self.show_id, forKey: "show_id")
        self.parameter.updateValue(self.member_id, forKey: "member_id")
        self.parameter.updateValue(self.price, forKey: "price")
        self.parameter.updateValue(self.tickets, forKey: "tickets")
        self.finish()
        
    }

  
    func finish(){
        
        
        ConnectionHelper.postJSON(command: command, parameter: parameter) { (success, json) in
            
            if success {
                
                print(json)
                self.lable.text = "Thanks for making your reservation with ON THE HOUSE. and remeber... if you've seen a show you loved, let others know!"
                
            }
            
            else {
                
                if let error = json["error"]["messages"].arrayObject as? [String] {
                    
                    
                     let message = error[0]
                        
                        
                        self.lable.text = message
                    
                    
                    
                    
                }
                
                
            }
            
          self.spinner.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
        }
        
        
        
    }

}
