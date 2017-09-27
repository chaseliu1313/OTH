//
//  CompetitionViewController.swift
//  On the House
//
//  Created by Chase on 26/9/17.
//  Copyright © 2017 Geng Xu. All rights reserved.
//

import UIKit

class CompetitionTickets: UIViewController {

    @IBOutlet weak var answer: UITextField!
    var event_id = ""
    var member_id = ""
 
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
  let detailVC = storyboard.instantiateViewController(withIdentifier: "OfferDetail") as! OfferDeatil
    detailVC.sendToCompetition = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func `return`(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
  
    @IBAction func submit(_ sender: Any) {
        
       
        
        print(member_id)
        
    }

}

extension CompetitionTickets: sendToCompetitionDelegate {

    func sendInfo(event_id: String, member_id: String) {
        self.member_id = member_id
        self.event_id = event_id
    }

}
